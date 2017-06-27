<?php
    /* Google Exclude File Generator Script for the Nginx Ultimate Bad Bot Blocker
     * Created by: Mitchell Krog (mitchellkrog@gmail.com)
     * Copyright: Mitchell Krog - https://github.com/mitchellkrogza
     * Repo Url: https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker
     * MIT License
     * Copyright (c) 2017 Mitchell Krog - mitchellkrog@gmail.com
     */
namespace mitchellkrogza;

use Mso\IdnaConvert\IdnaConvert;

class Generator
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
     * Open our input domain list and create our array
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
     * Write to File Function
     * @param $filename
     * @param $data
     */
    protected function writeToFile($filename, $data)
    {
    $file = "/home/travis/build/mitchellkrogza/nginx-ultimate-bad-bot-blocker/$filename";
	$handle = fopen($file, 'w') or die('Cannot open file:  '.$file);
	fwrite($handle, $data);
    }

    /**
     * Create Google Exclude Files Splitting them at Google's 30,000 Character Limit
     * @param $lines
     */
	public function createGoogleExclude(array $lines)
    {
        $regexLines = [];
        foreach ($lines as $line) {
            $regexLines[] = preg_quote($line);
        }
        $data = implode('|', $regexLines);
        $googleLimit = 30000;
        $dataLength = strlen($data);
        $lastPosition = 0;
        for ($x = 1; $lastPosition < $dataLength; $x++) {
            if( ($dataLength-$lastPosition) >= $googleLimit){
                $pipePosition = strrpos(substr($data, $lastPosition, $googleLimit), '|');
                $dataSplit = substr($data, $lastPosition, $pipePosition);
                $lastPosition = $lastPosition + $pipePosition+1;
            }else{
                $dataSplit = substr($data, $lastPosition);
                $lastPosition = $dataLength; // Break
            }
            $this->writeToFile('google-exclude-0' . $x . '.txt', $dataSplit);
        }
    }
}
$generator = new Generator();
$generator->generateFiles();