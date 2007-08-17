From: sanjeev sinha <sinha_crl@yahoo.co.in>
Subject: Re: Mirroring the display
Date: Fri, 17 Aug 2007 10:58:19 +0100 (BST)
Message-ID: <512476.38227.qm@web94114.mail.in2.yahoo.com>
References: <ce8e877b0708160011p83b8648j96749433b3857d@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1379574469=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILybL-00029t-7j for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Aug 2007 02:58:43 -0700
Received: from web94114.mail.in2.yahoo.com ([203.104.16.68])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1ILybJ-0000Gs-GV
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Aug 2007 02:58:43 -0700
In-Reply-To: <ce8e877b0708160011p83b8648j96749433b3857d@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

--===============1379574469==
Content-Type: multipart/alternative; boundary="0-446116575-1187344699=:38227"
Content-Transfer-Encoding: 7bit

--0-446116575-1187344699=:38227
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

I am also having the same problem .
  pls inform if u get the solution
  =20
  Sanjeev Sinha

selvaganesan <selvaganesan@gmail.com> wrote:
    Dear all,=20
  =20
  I would like to capture the primary display and send it over the
network. All the primary display will be mirroring in the network pcs.   =
Functionality is exactly as same as VNC.=20
Remote pc should have control and events of
primary display as like as VNC.
  I have a few ideas but not sure about it.=20
  i) Accessing the framebuffer and sending it across the network.
  =20
    Doubts in this approach:
         1. Will it be a generic solution as hardware independent?
       2. Will it be fast?
       3. Will i be able to control and events from the remote pc as like=
 as VNC?
       4. Do i need to change any configurations? any configuration depen=
dent? =20
         5.Is  it feasible?
   =20
 =20
ii) Accesing the X Window, hooking it and sending it across the network a=
s VNC does.=20
         1.Will it be fast?=20
         2.Is it feasible?
 =20
Can anybody suggest me the best way to do this?
  Where can i start now?
  Thanks in advance,
  selva
  =20

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems? Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/__________=
_____________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


      =20
---------------------------------
 5, 50, 500, 5000 - Store N number of mails in your inbox. Click here.
--0-446116575-1187344699=:38227
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<div>I am also having the same problem .</div>  <div>pls inform if u get =
the solution</div>  <div>&nbsp;</div>  <div>Sanjeev Sinha<BR><BR><B><I>se=
lvaganesan &lt;selvaganesan@gmail.com&gt;</I></B> wrote:</div>  <BLOCKQUO=
TE class=3Dreplbq style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LE=
FT: #1010ff 2px solid">  <DIV>Dear all, </DIV>  <DIV>&nbsp;</DIV>  <DIV>I=
&nbsp;would like to capture the primary display and send it over the<BR>n=
etwork. All the primary display will be mirroring in the network pcs.   <=
div>Functionality is exactly as same as VNC. <BR>Remote pc should have co=
ntrol and events of<BR>primary display as like as VNC.</div>  <div>I have=
 a few ideas but not sure about it. </div>  <div>i) Accessing the framebu=
ffer and sending it across the network.<BR>&nbsp;&nbsp; <BR>&nbsp;&nbsp;&=
nbsp; Doubts in this approach:</div>  <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; 1. Will it be a generic solution as hardware independent?<BR>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. Will it
 be fast?<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3. Will i be able to co=
ntrol and events from the remote pc as like as VNC?<BR>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 4. Do i need to change any configurations? any configu=
ration dependent?&nbsp; </div>  <div>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 5.Is=
&nbsp; it feasible?<BR>&nbsp;&nbsp;&nbsp; </div>  <div><BR>ii) Accesing t=
he X Window, hooking it and sending it across the network as VNC does. </=
div>  <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.Will it be fast? </div>=
  <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.Is it feasible?</div>  <div=
><BR>Can anybody suggest me the best way to do this?</div>  <div>Where ca=
n i start now?</div>  <div>Thanks in advance,</div>  <div>selva</div>  <d=
iv>&nbsp;</div></DIV>----------------------------------------------------=
---------------------<BR>This SF.net email is sponsored by: Splunk Inc.<B=
R>Still grepping through log files to find problems? Stop.<BR>Now Search =
log events and configuration files
 using AJAX and a browser.<BR>Download your FREE copy of Splunk now &gt;&=
gt; http://get.splunk.com/_______________________________________________=
<BR>Linux-fbdev-devel mailing list<BR>Linux-fbdev-devel@lists.sourceforge=
.net<BR>https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel<BR=
></BLOCKQUOTE><BR><p>&#32;


      <!--4--><hr size=3D1></hr> 5, 50, 500, 5000 - Store N number of mai=
ls in your inbox. <a href=3D"http://in.rd.yahoo.com/tagline_mail_4/*http:=
//help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/">Click he=
re.</a>
--0-446116575-1187344699=:38227--


--===============1379574469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1379574469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1379574469==--
