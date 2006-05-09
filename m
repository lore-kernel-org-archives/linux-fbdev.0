From: Martin Michlmayr <tbm@cyrius.com>
Subject: [PATCH] Fix maxine compilation error
Date: Tue, 9 May 2006 23:01:14 +0200
Message-ID: <20060509210114.GA13897@deprecation.cyrius.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FdZL6-0005v3-E7
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 May 2006 14:01:52 -0700
Received: from sorrow.cyrius.com ([65.19.161.204])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FdZL4-0006EC-H3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 May 2006 14:01:52 -0700
Content-Disposition: inline
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
Content-Type: text/plain; charset="utf-8"
To: linux-fbdev-devel@lists.sourceforge.net

I have no idea if the patch below is correct.  Are fb_get_fix/fb_get_var
still needed?  Is there any information about converting fb drivers to
the 2.6 api?


[PATCH] Fix maxine compilation error

Fix the following compilation error:

  CC      drivers/video/maxinefb.o
drivers/video/maxinefb.c:58: warning: initializer-string for array of cha=
rs is too long
drivers/video/maxinefb.c:58: warning: (near initialization for =E2=80=98m=
axinefb_fix.id=E2=80=99)
drivers/video/maxinefb.c:110: error: unknown field =E2=80=98fb_get_fix=E2=
=80=99 specified in initializer
drivers/video/maxinefb.c:110: error: =E2=80=98gen_get_fix=E2=80=99 undecl=
ared here (not in a function)
drivers/video/maxinefb.c:111: error: unknown field =E2=80=98fb_get_var=E2=
=80=99 specified in initializer
drivers/video/maxinefb.c:111: error: =E2=80=98gen_get_var=E2=80=99 undecl=
ared here (not in a function)
make[2]: *** [drivers/video/maxinefb.o] Error 1

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- drivers/video/maxinefb.c~	2006-05-09 20:50:36.000000000 +0000
+++ drivers/video/maxinefb.c	2006-05-09 20:57:27.000000000 +0000
@@ -55,7 +55,7 @@
 };
=20
 static struct fb_fix_screeninfo maxinefb_fix =3D {
-	.id =3D		"Maxine onboard graphics 1024x768x8",
+	.id =3D		"Maxine",
 	.smem_len =3D	(1024*768),
 	.type =3D		FB_TYPE_PACKED_PIXELS,
 	.visual =3D	FB_VISUAL_PSEUDOCOLOR,
@@ -107,8 +107,6 @@
=20
 static struct fb_ops maxinefb_ops =3D {
 	.owner		=3D THIS_MODULE,
-	.fb_get_fix	=3D gen_get_fix,
-	.fb_get_var	=3D gen_get_var,
 	.fb_setcolreg	=3D maxinefb_setcolreg,
 	.fb_fillrect	=3D cfb_fillrect,
 	.fb_copyarea	=3D cfb_copyarea,


--=20
Martin Michlmayr
http://www.cyrius.com/


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
