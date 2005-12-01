From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: scroll modes
Date: Fri, 02 Dec 2005 07:27:50 +0800
Message-ID: <438F86F6.9090800@gmail.com>
References: <438D9E60.7040007@t-online.de> <Pine.LNX.4.62.0511301347230.2123@pademelon.sonytel.be> <438DE211.2060900@t-online.de> <438E0E23.2000203@gmail.com> <438E2D8E.2040503@t-online.de> <438E3D66.8080601@gmail.com> <438F8136.5030005@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhxrI-0007qJ-6U
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Dec 2005 15:29:00 -0800
Received: from zproxy.gmail.com ([64.233.162.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhxrG-0006ru-Pe
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Dec 2005 15:29:00 -0800
Received: by zproxy.gmail.com with SMTP id r28so397588nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 01 Dec 2005 15:28:58 -0800 (PST)
In-Reply-To: <438F8136.5030005@t-online.de>
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
Content-Type: text/plain; charset="iso-8859-1"
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>

Knut Petersen wrote:
> Hi Geert/Antonino,
>=20
 > I have to admit that I=B4m not one of those gurus who fully understand=
 the
> fbcon
> console layer in all details ... so please check that this does not
> break anything else.
>=20

I think I see the problem.  Can you try this instead?

Tony

PS: Do you still need the previous patch?  The one that adjusts
p->vrows?

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index eda237e..587b70e 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -727,13 +727,18 @@ fb_pan_display(struct fb_info *info, str
 {
         int xoffset =3D var->xoffset;
         int yoffset =3D var->yoffset;
-        int err;
+        int err, yres;
=20
-        if (!info->fbops->fb_pan_display || xoffset < 0 || yoffset < 0 |=
|
-	    xoffset + info->var.xres > info->var.xres_virtual ||
-            yoffset + info->var.yres > info->var.yres_virtual)
-                return -EINVAL;
+	if (var->vmode & FB_VMODE_YWRAP)
+		yres =3D 0;
+	else
+		yres =3D info->var.yres;
=20
+        if (!info->fbops->fb_pan_display || xoffset < 0 || yoffset < 0 |=
|
+	    var->yoffset + yres > info->var.yres_virtual ||
+	    var->xoffset + info->var.xres > info->var.xres_virtual)
+		return -EINVAL;
+=09
 	if ((err =3D info->fbops->fb_pan_display(var, info)))
 		return err;
=20


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
