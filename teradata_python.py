# -*- coding: utf-8 -*-
"""
Created on Mon Apr  2 16:39:13 2018

@author: muaaz.sarfaraz
"""

import teradata
import pandas as pd

host,username,password = '10.17.5.105','username', 'password'
#Make a connection
udaExec = teradata.UdaExec (appName="test", version="1.0", logConsole=False)


connect = udaExec.connect(method="odbc",system=host, username=username,
                            password=password, driver="Teradata")

query = "SELECT top 10 * FROM TABLE;"

#Reading query to df
df = pd.read_sql(query,connect)