<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

if ( ! function_exists('http_ping'))
{
    function http_ping($url)
    {
        $ch = curl_init($url);
        curl_setopt($ch,CURLOPT_CONNECTTIMEOUT,15);
        curl_setopt($ch,CURLOPT_HEADER,true);
        curl_setopt($ch,CURLOPT_NOBODY,true);
        curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);
        $response = curl_exec($ch);
        $httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
        return $httpcode;
    }
}
?>