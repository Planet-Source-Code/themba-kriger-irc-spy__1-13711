VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form Form1 
   Caption         =   "Irc Spy by Themba Kriger"
   ClientHeight    =   10290
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   12105
   LinkTopic       =   "Form1"
   ScaleHeight     =   10290
   ScaleWidth      =   12105
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Listen"
      Height          =   495
      Left            =   10200
      TabIndex        =   15
      Top             =   2520
      Width           =   1815
   End
   Begin VB.TextBox Text5 
      Height          =   285
      Left            =   10200
      TabIndex        =   13
      Top             =   2160
      Width           =   1815
   End
   Begin VB.TextBox Text4 
      Height          =   285
      Left            =   10200
      TabIndex        =   11
      Top             =   1560
      Width           =   1815
   End
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   10200
      TabIndex        =   9
      Top             =   960
      Width           =   1815
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   10200
      TabIndex        =   7
      Top             =   360
      Width           =   1815
   End
   Begin VB.Frame Frame3 
      Caption         =   "Click any List to put that line in this text box. click the box to put the text on the clipboard:"
      Height          =   735
      Left            =   0
      TabIndex        =   4
      Top             =   9480
      Width           =   10095
      Begin VB.TextBox Text1 
         Height          =   375
         Left            =   120
         TabIndex        =   5
         Top             =   240
         Width           =   9855
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "From Server to Client:"
      Height          =   4935
      Left            =   0
      TabIndex        =   2
      Top             =   4440
      Width           =   10095
      Begin VB.ListBox List2 
         Height          =   4545
         Left            =   120
         TabIndex        =   3
         Top             =   240
         Width           =   9855
      End
      Begin MSWinsockLib.Winsock Winsock2 
         Left            =   4440
         Top             =   960
         _ExtentX        =   741
         _ExtentY        =   741
         _Version        =   393216
         RemoteHost      =   "10.10.10.10"
         RemotePort      =   6667
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "From Client to Server:"
      Height          =   4335
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   10095
      Begin VB.ListBox List1 
         Height          =   3960
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   9855
      End
      Begin MSWinsockLib.Winsock Winsock1 
         Left            =   9000
         Top             =   3600
         _ExtentX        =   741
         _ExtentY        =   741
         _Version        =   393216
         LocalPort       =   6666
      End
   End
   Begin VB.Label Label5 
      BackStyle       =   0  'Transparent
      Caption         =   $"Form1.frx":0000
      Height          =   5100
      Left            =   10200
      TabIndex        =   14
      Top             =   3240
      Width           =   1920
      WordWrap        =   -1  'True
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Server Address:"
      Height          =   195
      Left            =   10200
      TabIndex        =   12
      Top             =   1920
      Width           =   1125
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Email Address:"
      Height          =   195
      Left            =   10200
      TabIndex        =   10
      Top             =   1320
      Width           =   1035
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Real Name:"
      Height          =   195
      Left            =   10200
      TabIndex        =   8
      Top             =   720
      Width           =   840
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Nick Name:"
      Height          =   195
      Left            =   10200
      TabIndex        =   6
      Top             =   120
      Width           =   840
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim globdt As String

Private Sub Command1_Click()
Winsock1.Listen
End Sub

'Well I wrote this quick little app in under 10 minutes just so
'i could get some data being sent between the irc client and server.
'but you can adapt it to suit many client server apps like napster or whatever.
'well this is how you use it. in mirc or whatever other client you are using
'set the server to connect to your local ip and port 6666 then set your nick and
'other information including server here. run this app. run your client and
'connect. this is just a quick app if you really want to see whats
'going on download netboy by ndg software. well enjoy and please vote.
'thanx Themba Kriger
'email questions and comments to dysphorical@hotmail.com


Private Sub List2_Click()
Text1 = List2.Text
End Sub
Private Sub List1_Click()
Text1 = List1.Text
End Sub

Private Sub Text1_Click()
Clipboard.SetText Text1
End Sub

Private Sub Winsock1_ConnectionRequest(ByVal requestID As Long)
Winsock1.Close
Winsock1.Accept (requestID)
Call Winsock2.Connect(Text5, "6667")
End Sub

Private Sub Winsock1_DataArrival(ByVal bytesTotal As Long)
Dim Dta As String
Call Winsock1.GetData(Dta, vbString)
List1.AddItem (Dta)
If Winsock2.State = 7 Then
Winsock2.SendData (Dta)
Else
Call Winsock2.Connect("10.10.10.10", "6667")
globdt = Dta
End If
End Sub

Private Sub Winsock2_Connect()
Winsock2.SendData "User " & Text3 & Winsock2.LocalHostName & " " & Winsock2.RemoteHost & " :" & Text4 & vbCrLf
Winsock2.SendData "NICK " & Text2 & vbCrLf
End Sub

Private Sub Winsock2_DataArrival(ByVal bytesTotal As Long)
Dim dtta As String
Call Winsock2.GetData(dtta, vbString)
List2.AddItem (dtta)
Winsock1.SendData (dtta)
End Sub
