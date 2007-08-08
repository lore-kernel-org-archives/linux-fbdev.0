From: sanjeev sinha <sinha_crl@yahoo.co.in>
Subject: help required for Frame buffer update region
Date: Wed, 8 Aug 2007 12:55:46 +0100 (BST)
Message-ID: <78833.58007.qm@web94105.mail.in2.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0796362884=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IIk8v-0007cA-RU for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Aug 2007 04:56:02 -0700
Received: from web94105.mail.in2.yahoo.com ([203.104.16.59])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1IIk8u-0001wU-9H
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Aug 2007 04:56:01 -0700
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

--===============0796362884==
Content-Type: multipart/alternative; boundary="0-1191517883-1186574146=:58007"
Content-Transfer-Encoding: 7bit

--0-1191517883-1186574146=:58007
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

=20
  Dear all,
  =20
  I am a student.My academic project is similar to VNC. I have to design =
remote display sharing and on linux.
  For that what I did is I accessed the frame buffer using fixed info and=
 varable info structure (include/fb.h) , IOCTL  and mmap call(after enabl=
ing the frame buffer). Problem is that I have to send this frame buffer m=
emory area to other network computer to display the complete picture (lik=
e VNC). I can not send complete frame buffer every  time(1.5-2. MB). I wa=
nt to send the complete fb once and then the updated  region only. Is the=
re any way by which I can directly know what all frame buffer memory regi=
on has been updated so that I will send only that portion. Otherwise I ha=
ve to compare all the bytes,compress it and send.But this will have refre=
sh rate (effiency ) issue. Please help me
  =20
  =20
  =20
  After mmap application is not writing anything to framebuffer pointer(d=
escriptor).
  For every update kernel is writing. So we can not make the mmap with re=
ad option and find the page fault and send the updated pages. This option=
 (in this way ) is ruled out.
  =20
  I have one idea. All the X calls to driver (for display update) can be =
hooked and then I will send those calls (hook Information) to remote comp=
uter where in the display can be updated using this hook information. I d=
on't know how to hook the display. In window it can be done ( I got this =
window info from Net),but in linux I am not aware of it.If you can help ,=
 please suggest.
  =20
  =20
  The later part of my project is both the display should behave as dual =
head.Now I am blank about how to share the frame buffer area of one CPU o=
n two display screen like dual head.please help me in this matter also.
  =20
  Regards,
  Sanjeev
  =20
 =20

=20

      =20
---------------------------------
 Unlimited freedom, unlimited storage. Get it now
--0-1191517883-1186574146=:58007
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<DIV>&nbsp;</DIV>  <DIV>Dear all,</DIV>  <DIV>&nbsp;</DIV>  <DIV>I am a s=
tudent.My academic project is similar to VNC. I have to design remote dis=
play sharing and on linux.</DIV>  <DIV>For that what I did is I&nbsp;acce=
ssed the frame buffer using fixed info and varable info structure (includ=
e/fb.h) , IOCTL&nbsp; and mmap call(after enabling the frame buffer). Pro=
blem is that I have to&nbsp;send this frame buffer memory area to other n=
etwork computer to display the&nbsp;complete picture (like VNC). I can no=
t send complete frame buffer every &nbsp;time(1.5-2. MB). I want to send =
the complete fb once and then the updated &nbsp;region only. Is there any=
 way by which I can directly know what all frame&nbsp;buffer memory regio=
n has been updated so that I will send only that portion. Otherwise I hav=
e to compare all the bytes,compress it and send.But this will have refres=
h rate (effiency ) issue. Please help me</DIV>  <DIV>&nbsp;</DIV>  <DIV>&=
nbsp;</DIV>  <DIV>&nbsp;</DIV>=20
 <DIV>After mmap application is not writing anything to framebuffer point=
er(descriptor).</DIV>  <DIV>For every update kernel is writing. So we can=
 not make the mmap with read option and find the page fault and send the =
updated pages. This option (in this way ) is ruled out.</DIV>  <DIV>&nbsp=
;</DIV>  <DIV>I have one idea. All the X calls&nbsp;to driver&nbsp;(for d=
isplay update) can be hooked and then I will send those calls (hook Infor=
mation) to remote computer where in the display can be updated using this=
 hook information. I don't know how to hook the display. In window it can=
 be done ( I got this window info from Net),but in linux I am not aware o=
f it.If you can help , please suggest.</DIV>  <DIV>&nbsp;</DIV>  <DIV>&nb=
sp;</DIV>  <DIV>The later part of my project is both the display should b=
ehave as dual head.Now I am blank about how to share the frame buffer are=
a of one CPU on two display screen like dual head.please help me in this =
matter also.</DIV>  <DIV>&nbsp;</DIV>=20
 <DIV>Regards,</DIV>  <DIV>Sanjeev</DIV>  <DIV>&nbsp;</DIV>  <DIV><BR><BR=
>&nbsp;</DIV><p>&#32;


      <!--2--><hr size=3D1></hr> Unlimited freedom, unlimited storage. <a=
 href=3D"http://in.rd.yahoo.com/tagline_mail_2/*http://help.yahoo.com/l/i=
n/yahoo/mail/yahoomail/tools/tools-08.html/">Get it now</a>
--0-1191517883-1186574146=:58007--


--===============0796362884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0796362884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0796362884==--
