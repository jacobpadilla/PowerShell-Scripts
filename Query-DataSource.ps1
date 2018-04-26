param(
    [string]$sql=$(throw 'file name is required.'),
    [string]$dsn=$("Census")
    )

function Get-ODBC-Data{
   param(
   [string]$sql=$(throw 'file name is required.'),
   [string]$dsn=$(throw 'DSN is required.')
   )
   
   $query = [IO.File]::ReadAllText($sql)
   $conn = New-Object System.Data.Odbc.OdbcConnection
   $conn.ConnectionString = "DSN=$dsn;"
   $conn.open()
   $cmd = New-object System.Data.Odbc.OdbcCommand($query,$conn)
   $ds = New-Object system.Data.DataSet
   (New-Object system.Data.odbc.odbcDataAdapter($cmd)).fill($ds) | out-null
   $conn.close()
   $ds.Tables[0]
}


Get-ODBC-Data $sql $dsn| Format-Table
exit