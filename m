From: Yves =?ISO-8859-1?Q?J=E4ger?= <yves.jaeger@fraenz-jaeger.de>
Subject: own driver crashes + patch
Date: 08 Aug 2002 15:01:11 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1028811676.1323.26.camel@dilbert>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-dOQLehwZt+EsarSXkkVo"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from moutng.kundenserver.de ([212.227.126.171])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17cmuq-000398-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 08 Aug 2002 06:01:25 -0700
Received: from [212.227.126.155] (helo=mrelayng1.kundenserver.de)
	by moutng1.kundenserver.de with esmtp (Exim 3.35 #2)
	id 17cmui-0007g2-00
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Aug 2002 15:01:16 +0200
Received: from [62.134.106.54] (helo=dilbert.igfj.westend.de)
	by mrelayng1.kundenserver.de with asmtp (Exim 3.35 #2)
	id 17cmui-0000Vj-00
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Aug 2002 15:01:16 +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--=-dOQLehwZt+EsarSXkkVo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all, 

I'm writing a Framebuffer driver for an embedded system that contains an
LCD display and and Toshiba T6963 controller. 

I had the problem, that my driver crashed because the screensize
(126x64) is lower than the boot-logo (80x80). And this parameter is not
checked in fbcon.c

To see a Kernel with the virtual framebuffer crash, apply the patch
vfb.diff and enable the Virtual Framebuffer in your configuration and
kernel command line.

The workaround is shown in file fbcon-2.4.18.patch. 
I'm not sure if that is the right place to check the boot-logo size.
Perhaps somebody has a better idea.

Best regards 
Yves Jaeger 


--=-dOQLehwZt+EsarSXkkVo
Content-Description: 
Content-Disposition: inline; filename=vfb.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-15

--- vfb.c	Wed Aug  7 15:14:05 2002
+++ vfb.c.new	Wed Aug  7 15:34:58 2002
@@ -62,7 +62,7 @@
=20
 static struct fb_var_screeninfo vfb_default =3D {
     /* 640x480, 8 bpp */
-    640, 480, 640, 480, 0, 0, 8, 0,
+    128, 64, 128, 64, 0, 0, 1, 0,
     {0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
     0, 0, -1, -1, 0, 20000, 64, 64, 32, 32, 64, 2,
     0, FB_VMODE_NONINTERLACED

--=-dOQLehwZt+EsarSXkkVo
Content-Disposition: attachment; filename=fbcon-2.4.18.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=fbcon-2.4.18.patch; charset=ISO-8859-15

diff -ru linux/drivers/video/fbcon.c linux-2.4.18-t6963/drivers/video/fbcon=
.c
--- linux/drivers/video/fbcon.c	Mon Feb 25 20:38:07 2002
+++ linux-2.4.18-t6963/drivers/video/fbcon.c	Thu Aug  8 14:43:39 2002
@@ -754,8 +754,14 @@
     }
 =09
     if (logo) {
-	logo_shown =3D -2;
-    	conp->vc_top =3D logo_lines;
+	if (logo_lines > conp->vc_bottom)
+	{
+		logo_shown =3D -1;
+		printk(KERN_INFO "fbcon_startup: disable boot-logo (boot-logo bigger tha=
n screen).\n");
+	} else {
+		logo_shown =3D -2;
+		conp->vc_top =3D logo_lines;
+	}
     }
    =20
     if (con =3D=3D fg_console && softback_buf) {

--=-dOQLehwZt+EsarSXkkVo--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
