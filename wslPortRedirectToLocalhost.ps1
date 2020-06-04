function RedirectPort([String]$port)
{
  if (-not $port) {
    echo 'Port doesnt set'
    exit 1
  }

  $match = (bash -c "ifconfig eth0 | grep 'inet '") -match 'inet (\d+\.\d+\.\d+\.\d+)'
  if ($match) {
    $wslAddress = $Matches.1
    echo 'localhost:'$port' redirecting to $wslAddress':'$port'
    
    iex "netsh interface portproxy delete v4tov4 listenaddress=127.0.0.1 listenport=$port"
    iex "netsh interface portproxy add v4tov4 listenaddress=127.0.0.1 listenport=$port connectaddress=$wslAddress connectport=$port"
  }
}

RedirectPort -port 8087
RedirectPort -port 8086
RedirectPort -port 8080
