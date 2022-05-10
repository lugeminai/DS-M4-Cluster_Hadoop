

# Cantidad de nodos
$nodes = 2


docker network create --driver=bridge hadoop | out-null


docker rm -f hadoop-master | out-null

Write-Output "start hadoop-master container..."

docker run -itd --net=hadoop -p 50070:50070 -p 8088:8088 --name hadoop-master --hostname hadoop-master  uracilo/hadoop | out-null


$i=1

while($i -le $nodes)
{
    docker rm -f hadoop-slave$i | out-null
    Write-Output "start hadoop-slave$i container..."
    docker run -itd --net=hadoop --name hadoop-slave$i --hostname hadoop-slave$i uracilo/hadoop | out-null
    $i++
}

Write-Output "All services started 1 Master $nodes slaves"