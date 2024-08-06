Attribute VB_Name = "Module2"
Option Explicit
Sub stockvolume()

'var to hold counter
Dim i As Double

'var to hold ticker
Dim ticker As String
'var to hold quarterly change/percent change
Dim quarterlychange As Double
Dim percentchange As Double

'var for summary
Dim summaryrow As Integer

'others vars
Dim ws As Worksheet
Dim openingprice As Double
Dim closingprice As Double
Dim totalvolume As Double
Dim lastrow As Long
Dim percentchangehigh As Double
Dim percentchangelow As Double
Dim totalvolumefinal As Integer
Dim interior As CellFormat
Dim cell As Range

'For Loop for Worksheets
For Each ws In Worksheets:
 quarterlychange = 0
  percentchange = 0
  summaryrow = 2

'headers
ws.Cells(1, 9).Value = "Ticker"
ws.Cells(1, 10).Value = "Quarterly Change"
ws.Cells(1, 11).Value = "Percent Change"
ws.Cells(1, 12).Value = "Total Stock Volume"

'set last row
lastrow = ws.Cells(Rows.Count, 1).End(xlUp).Row

'loop column A
For i = 2 To lastrow

    'is it within the same ticker?
    If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
        'set ticker name
        ticker = ws.Cells(i, 1).Value
        'set opening/closing
        openingprice = ws.Cells(i, 3).Value
        closingprice = ws.Cells(i, 6).Value
        'set quarterlychange
        quarterlychange = (closingprice - openingprice) / openingprice
        'print totals
        ws.Range("I" & summaryrow).Value = ticker
        ws.Range("J" & summaryrow).Value = quarterlychange
        ws.Range("K" & summaryrow).Value = percentchange
        ws.Range("L" & summaryrow).Value = totalvolume
        'column 15, 16 & 17 cell names
    ws.Cells(2, 15).Value = "Greatest % Increase"
    ws.Cells(3, 15).Value = "Greatest % Decrease"
    ws.Cells(4, 15).Value = "Total Volume"
    ws.Cells(1, 16).Value = "Ticker"
    ws.Cells(1, 17).Value = "Value"
    End If
    
    'add one to drop data down
    summaryrow = summaryrow + 1
    
    'reset quarterlychange
    quarterlychange = 0
    
'    'if the cell immediately following is the same
If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
    ' Calculate quarterly change, percent change, and total volume for the current ticker
    quarterlychange = ws.Cells(i, 6).Value - ws.Cells(i, 3).Value
    percentchange = (ws.Cells(i, 6).Value - ws.Cells(i, 3).Value) / ws.Cells(i, 3).Value
    totalvolume = ws.Cells(i, 7).Value

    ' Perform any additional operations for the current ticker
    
    ' Reset any variables if needed
    
    ' Output the calculated values for the current ticker
    ws.Range("I" & summaryrow).Value = ticker
    ws.Range("J" & summaryrow).Value = quarterlychange
    ws.Range("K" & summaryrow).Value = percentchange
    ws.Range("L" & summaryrow).Value = totalvolume
    
    ' Increment the summary row counter
    summaryrow = summaryrow + 1
Else
    ' Perform alternative operations if the ticker remains the same
    On Error Resume Next
    ws.Range("P2").Value = WorksheetFunction.Lookup(ws.Range("Q2").Value, ws.Range("K2:K1501"), ws.Range("I2:I1501"))
    If Err.Number <> 0 Then
        ws.Range("P2").Value = "Not Found"
    End If
    Err.Clear
End If


If Err.Number <> 0 Then
    Range("P2").Value = "Not Found"
End If
Err.Clear
Range("P3").Value = WorksheetFunction.Lookup(Range("Q3").Value, Range("K2:K1501"), Range("I2:I1501"))
If Err.Number <> 0 Then
    Range("P3").Value = "Not Found"
End If
Err.Clear
Range("P4").Value = WorksheetFunction.Lookup(Range("Q4").Value, Range("L2:L1501"), Range("I2:I1501"))
If Err.Number <> 0 Then
    Range("P4").Value = "Not Found"
End If

  
'column 17 calculations (change values of ranges from FF to KK and GG to LL)
ws.Cells(2, 17).Value = Application.WorksheetFunction.Max(Range("k:k"))
ws.Cells(3, 17).Value = Application.WorksheetFunction.Min(Range("k:k"))
ws.Cells(4, 17).Value = Application.WorksheetFunction.Max(Range("l:l"))

'column 16 ticker lookups
    percentchangehigh = ws.Cells(2, 17).Value
    percentchangelow = ws.Cells(3, 17).Value
    
    'totalvolumefinal = Cells(4, 17).value
 ws.Cells(i, 11).NumberFormat = "0.00%"
For Each cell In ws.Range("J2:J96001")
    If cell.Value < 0 Then
        cell.interior.ColorIndex = 3 ' Red color for negative values
    ElseIf cell.Value > 0 Then
        cell.interior.ColorIndex = 4 ' Green color for positive values
    Else
        cell.interior.ColorIndex = xlNone ' No fill color for zero values
    End If
Next cell
Next i
Next ws
End Sub
