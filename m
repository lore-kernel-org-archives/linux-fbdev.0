From: "Andy Sy" <andy@nospam.com>
Subject: important change to tdfxfb.txt
Date: Sat, 14 Jun 2003 18:53:33 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <003b01c33263$37efcf40$0100a8c0@duron12>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0038_01C332A6.4135A320"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [202.78.77.6] (helo=mail.netasia.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19R8cO-0004HN-00
	for <Linux-fbdev-devel@lists.sourceforge.net>; Sat, 14 Jun 2003 03:50:44 -0700
Received: from duron12 ([202.78.77.70])
	by mail.netasia.net (8.11.6/8.11.6) with SMTP id h5EAiRT01551
	for <Linux-fbdev-devel@lists.sourceforge.net>; Sat, 14 Jun 2003 18:44:27 +0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0038_01C332A6.4135A320
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

The following note should be added:

"NOTE: this will only work if you've compiled tdfx into
the kernel and NOT as a module only."

Otherwise it might cause endless frustration as well. :-)


===============================
a n d y @ n e t f x p h . c o m


------=_NextPart_000_0038_01C332A6.4135A320
Content-Type: text/plain;
	name="tdfxfb.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="tdfxfb.txt"

This is just a quickly hacked together doc for using tdfxfb so=0A=
you don't have to look at the source or use trial and error to=0A=
know how to configure it.=0A=
=0A=
Passing command lines to the tdfxfb driver works similar to=0A=
the other framebuffer drivers.=0A=
=0A=
The syntax for kernel parameters is:=0A=
=0A=
  video=3Dtdfx:option1,option2,...=0A=
=0A=
optionn is in the form:=0A=
=0A=
  optionname:value=0A=
=0A=
value being optional.=0A=
=0A=
To set the resolution and refresh, use the following syntax:=0A=
=0A=
WWWWxHHHH-BPP@RR=0A=
 =0A=
where WWWW =3D width, HHHH=3Dheight in pixels, BPP=3Dbits per pixel,=0A=
and RR is the refresh rate.=0A=
=0A=
example:=0A=
=0A=
(in lilo.conf)=0A=
=0A=
append=3D"video=3Dtdfx:font:VGA8x16,1152x864-16@70"=0A=
=0A=
NOTE: this will only work if you've compiled tdfx into=0A=
the kernel and NOT as a module only.=0A=
=0A=
Other options are noaccel,nowrap,nopan,nowhwcursor,inverse,nomtrr.=0A=
I have not tried any of these yet, just saw them in tdfxfb_setup()=0A=
in /usr/src/linux/video/drivers/tdfxfb.c.=0A=
=0A=
The syntax for setting a mode is explained in =0A=
/usr/src/linux/video/drivers/modefb.c in the comments=0A=
for fb_find_mode().  The valid refresh rate/resolution =0A=
combinations and settings for them are listed and will=0A=
be taken from there and not /etc/fb.modes.=0A=
=0A=
If you own a Voodoo3/4/5, the nice thing with using the =0A=
tdfxfb driver over vesafb (which also works nicely) is that=0A=
you can set the refresh rate for your fbcon mode.  No more =0A=
having to live with 60Hz!  The con is that as of now (2.4.20)=0A=
the penguin logo display is still quite glitchy.=0A=
=0A=
=0A=
Written by: codeboy@postmark.net=0A=
Date: 2003-6-14=0A=
=0A=

------=_NextPart_000_0038_01C332A6.4135A320--



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
