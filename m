From: <Stuart_Hayes@Dell.com>
Subject: vesafb probe question
Date: Fri, 7 Jan 2005 15:03:29 -0600
Message-ID: <7A8F92187EF7A249BF847F1BF4903C040AFC32@ausx2kmpc103.aus.amer.dell.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4F4FC.56C05E22"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cn1Gk-00004t-Ij
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 07 Jan 2005 13:03:38 -0800
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cn1Gj-0003s4-0O
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 07 Jan 2005 13:03:38 -0800
content-class: urn:content-classes:message
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Stuart_Hayes@Dell.com

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4F4FC.56C05E22
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable


I'm getting a message in dmesg:  "localhost kernel: vesafb: probe of
vesafb0 failed with error -6"

I searched the web, and found that a lot of people are getting this, but
I couldn't find an answer, so I looked into it.

This appears to be because "vesafb" returns -ENXIO ("No such device or
address") when its probe function fails.  However, driverse/base/bus.c
spews an error message during device_attach() if a matching driver's
probe function returns anything but -ENODEV ("No such device").

Would a patch (like the one below) to change vesafb to return ENODEV
instead of ENXIO be appropriate, or am I missing something?

Thanks!
Stuart
stuart_hayes@dell.com



diff -purN linux-2.6.9-1.906_ELorig/drivers/video/vesafb.c
linux-2.6.9-1.906_EL/drivers/video/vesafb.c
--- linux-2.6.9-1.906_ELorig/drivers/video/vesafb.c	2004-10-18
17:53:11.000000000 -0400
+++ linux-2.6.9-1.906_EL/drivers/video/vesafb.c	2005-01-06
14:45:18.000000000 -0500
@@ -222,7 +222,7 @@ static int __init vesafb_probe(struct de
 	int i, err;
=20
 	if (screen_info.orig_video_isVGA !=3D VIDEO_TYPE_VLFB)
-		return -ENXIO;
+		return -ENODEV;
=20
 	vesafb_fix.smem_start =3D screen_info.lfb_base;
 	vesafb_defined.bits_per_pixel =3D screen_info.lfb_depth;
@@ -380,7 +380,7 @@ static int __init vesafb_probe(struct de
 		(ypan) ? FBINFO_HWACCEL_YPAN : 0;
=20
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
-		err =3D -ENXIO;
+		err =3D -ENODEV;
 		goto err;
 	}
 	if (register_framebuffer(info)<0) {

------_=_NextPart_001_01C4F4FC.56C05E22
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6527.0">
<TITLE>vesafb probe question</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">I'm getting a message in dmesg:&nbsp; =
&quot;localhost kernel: vesafb: probe of vesafb0 failed with error =
-6&quot;</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I searched the web, and found that a =
lot of people are getting this, but I couldn't find an answer, so I =
looked into it.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">This appears to be because =
&quot;vesafb&quot; returns -ENXIO (&quot;No such device or =
address&quot;) when its probe function fails.&nbsp; However, =
driverse/base/bus.c spews an error message during device_attach() if a =
matching driver's probe function returns anything but -ENODEV (&quot;No =
such device&quot;).</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Would a patch (like the one below) to =
change vesafb to return ENODEV instead of ENXIO be appropriate, or am I =
missing something?</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks!<BR>
Stuart</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">stuart_hayes@dell.com</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">diff -purN =
linux-2.6.9-1.906_ELorig/drivers/video/vesafb.c =
linux-2.6.9-1.906_EL/drivers/video/vesafb.c</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">--- =
linux-2.6.9-1.906_ELorig/drivers/video/vesafb.c&nbsp;&nbsp;&nbsp;&nbsp; =
2004-10-18 17:53:11.000000000 -0400</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">+++ =
linux-2.6.9-1.906_EL/drivers/video/vesafb.c 2005-01-06 =
14:45:18.000000000 -0500</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">@@ -222,7 +222,7 @@ static int __init =
vesafb_probe(struct de</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, =
err;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(screen_info.orig_video_isVGA !=3D VIDEO_TYPE_VLFB)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENXIO;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
vesafb_fix.smem_start =3D screen_info.lfb_base;</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
vesafb_defined.bits_per_pixel =3D screen_info.lfb_depth;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">@@ -380,7 +380,7 @@ static int __init =
vesafb_probe(struct de</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ypan) ? FBINFO_HWACCEL_YPAN =
: 0;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(fb_alloc_cmap(&amp;info-&gt;cmap, 256, 0) &lt; 0) {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D -ENXIO;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D -ENODEV;</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err;</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</FONT>

<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(register_framebuffer(info)&lt;0) {</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C4F4FC.56C05E22--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
