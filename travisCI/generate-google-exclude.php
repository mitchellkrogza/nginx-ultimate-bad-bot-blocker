<?php
    /* Google Exclude File Generator Script for the Nginx Ultimate Bad Bot Blocker
     * Created by: Mitchell Krog (mitchellkrog@gmail.com)
     * Copyright: Mitchell Krog - https://github.com/mitchellkrogza
     * Repo Url: https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker
     * MIT License
     * Copyright (c) 2017 Mitchell Krog - mitchellkrog@gmail.com
     */
class Generate
{
    
    private $projectUrl = "https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker";
    public function generateFiles()
    {
        date_default_timezone_set('Africa/Johannesburg');
        $date = date('Y-m-d H:i:s');
        $lines = $this->domainWorker();
        $this->createGoogleExclude($lines);
    }
    /**
     * @return array
     */
    public function domainWorker()
    {
        $domainsFile = "/home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/_generator_lists/bad-referrers.list";
        $handle = fopen($domainsFile, "r");
        if (!$handle) {
            throw new \RuntimeException('Error opening file ' . $domainsFile);
        }
        $lines = array();
        while (($line = fgets($handle)) !== false) {
            $line = trim(preg_replace('/\s\s+/', ' ', $line));
            // convert russian domains
            if (preg_match('/[А-Яа-яЁё]/u', $line)) {
                $IDN = new IdnaConvert();
                $line = $IDN->encode($line);
            }
            if (empty($line)) {
                continue;
            }
            $lines[] = $line;
        }
        fclose($handle);
        $uniqueLines = array_unique($lines, SORT_STRING);
        sort($uniqueLines, SORT_STRING);
        if (is_writable($domainsFile)) {
            file_put_contents($domainsFile, implode("\n", $uniqueLines));
        } else {
            trigger_error("Permission denied");
        }
        return $lines;
    }
    /**
     * @param $file
     * @param $data
     */
    protected function writeToFile($file, $data)
    {
        if (is_writable($file)) {
            file_put_contents($file, $data);
            if (!chmod($file, 0755)) {
                trigger_error("Couldn't not set " . basename($file) . " permissions to 755");
            }
        } else {
            trigger_error("Permission denied");
        }
    }
    public function createGoogleExclude(array $lines)
    {
        $regexLines = [];
        foreach ($lines as $line) {
            $regexLines[] = preg_quote($line);
        }
        $data = implode('|', $regexLines);
        $googleLimit = 30000;
        $dataLength = strlen($data);
        // keep track of the last split
        $lastPosition = 0;
        for ($x = 1; $lastPosition < $dataLength; $x++) {
            // already in the boundary limits?
            if( ($dataLength-$lastPosition) >= $googleLimit){
                // search for the last occurence of | in the boundary limits
                $pipePosition = strrpos(substr($data, $lastPosition, $googleLimit), '|');
                $dataSplit = substr($data, $lastPosition, $pipePosition);
                // without trailing pipe at the beginning of next round
                $lastPosition = $lastPosition + $pipePosition+1;
            }else{
                // Rest of the regex (no pipe at the end)
                $dataSplit = substr($data, $lastPosition);
                $lastPosition = $dataLength; // Break
            }
            $file = '/home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/google-exclude-0' . $x . '.txt';
            $this->writeToFile($file, $dataSplit);
        }
    }
}
$generator = new Generate();
$generator->generateFiles();