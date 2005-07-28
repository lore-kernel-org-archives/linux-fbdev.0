From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] fbdev: colormap fixes
Date: Thu, 28 Jul 2005 15:31:44 -0400
Message-ID: <9e473391050728123150931cbd@mail.gmail.com>
References: <200507280031.j6S0V3L3016861@hera.kernel.org>
	 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be>
	 <9e473391050728074573e40038@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyE6k-000102-BT
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 12:31:54 -0700
Received: from wproxy.gmail.com ([64.233.184.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DyE6j-0002vg-1h
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 12:31:54 -0700
Received: by wproxy.gmail.com with SMTP id 36so468887wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Jul 2005 12:31:45 -0700 (PDT)
In-Reply-To: <9e473391050728074573e40038@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Do we want to apply this patch now to get rid of the buffer overflow hole?
Then we can take our time and work out a better solution.

--=20
Jon Smirl
jonsmirl@gmail.com

Fix a buffer overflow vunerabilty in previous cmap patch
signed-off-by: Jon Smirl <jonsmirl@gmail.com>

diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -244,15 +244,15 @@ static ssize_t show_virtual(struct class
=20
 /* Format for cmap is "%02x%c%4x%4x%4x\n" */
 /* %02x entry %c transp %4x red %4x blue %4x green \n */
-/* 255 rows at 16 chars equals 4096 */
-/* PAGE_SIZE can be 4096 or larger */
+/* 256 rows at 16 chars equals 4096, the normal page size */
+/* the code will automatically adjust for different page sizes */
 static ssize_t store_cmap(struct class_device *class_device, const char *b=
uf,
 =09=09=09  size_t count)
 {
 =09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
 =09int rc, i, start, length, transp =3D 0;
=20
-=09if ((count > 4096) || ((count % 16) !=3D 0) || (PAGE_SIZE < 4096))
+=09if ((count > PAGE_SIZE) || ((count % 16) !=3D 0))
 =09=09return -EINVAL;
=20
 =09if (!fb_info->fbops->fb_setcolreg && !fb_info->fbops->fb_setcmap)
@@ -317,18 +317,18 @@ static ssize_t show_cmap(struct class_de
 =09   !fb_info->cmap.green)
 =09=09return -EINVAL;
=20
-=09if (PAGE_SIZE < 4096)
+=09if (fb_info->cmap.len > PAGE_SIZE / 16)
 =09=09return -EINVAL;
=20
 =09/* don't mess with the format, the buffer is PAGE_SIZE */
-=09/* 255 entries at 16 chars per line equals 4096 =3D PAGE_SIZE */
+=09/* 256 entries at 16 chars per line equals 4096 =3D PAGE_SIZE */
 =09for (i =3D 0; i < fb_info->cmap.len; i++) {
-=09=09sprintf(&buf[ i * 16], "%02x%c%4x%4x%4x\n", i + fb_info->cmap.start,
+=09=09snprintf(&buf[ i * 16], PAGE_SIZE - i * 16, "%02x%c%4x%4x%4x\n", i
+ fb_info->cmap.start,
 =09=09=09((fb_info->cmap.transp && fb_info->cmap.transp[i]) ? '*' : ' '),
 =09=09=09fb_info->cmap.red[i], fb_info->cmap.blue[i],
 =09=09=09fb_info->cmap.green[i]);
 =09}
-=09return 4096;
+=09return 16 * fb_info->cmap.len;
 }
=20
 static ssize_t store_blank(struct class_device *class_device, const char *=
 buf,


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
