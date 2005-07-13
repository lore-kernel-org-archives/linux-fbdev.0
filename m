From: Jon Smirl <jonsmirl@gmail.com>
Subject: Third repost: cmap_sysfs.patch
Date: Wed, 13 Jul 2005 18:28:22 -0400
Message-ID: <9e473391050713152841a97021@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dspjl-0006AG-JH
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 13 Jul 2005 15:29:53 -0700
Received: from wproxy.gmail.com ([64.233.184.201])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DspjJ-0005Cv-DN
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 13 Jul 2005 15:29:53 -0700
Received: by wproxy.gmail.com with SMTP id 69so291448wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 13 Jul 2005 15:29:17 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

Can we get this into the kernel?

--=20
Jon Smirl
jonsmirl@gmail.com

#Color maps have up to 256 entries. 4096/256 allows for 16 characters per l=
ine.
#The format for a cmap entry is "%02x%c%4x%4x%4x\n"
#%02x entry %c transp %4x red %4x blue %4x green
#You can read the color_map with cat fb0/color_map.
#Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -242,10 +242,68 @@ static ssize_t show_virtual(struct class
 =09=09=09fb_info->var.yres_virtual);
 }
=20
-static ssize_t store_cmap(struct class_device *class_device, const char * =
buf,
+/* Format for cmap is "%02x%c%4x%4x%4x\n" */
+/* %02x entry %c transp %4x red %4x blue %4x green \n */
+/* 255 rows at 16 chars equals 4096 */
+/* PAGE_SIZE can be 4096 or larger */
+static ssize_t store_cmap(struct class_device *class_device, const char *b=
uf,
 =09=09=09  size_t count)
 {
-//=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class=
_device);
+=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_d=
evice);
+=09int rc, i, start, length, transp =3D 0;
+
+=09if ((count > 4096) || ((count % 16) !=3D 0) || (PAGE_SIZE < 4096))
+=09=09return -EINVAL;
+
+=09if (!fb_info->fbops->fb_setcolreg && !fb_info->fbops->fb_setcmap)
+=09=09return -EINVAL;
+
+=09sscanf(buf, "%02x", &start);
+=09length =3D count / 16;
+
+=09for (i =3D 0; i < length; i++)
+=09=09if (buf[i * 16 + 2] !=3D ' ')
+=09=09=09transp =3D 1;
+
+=09/* If we can batch, do it */
+=09if (fb_info->fbops->fb_setcmap && length > 1) {
+=09=09struct fb_cmap umap;
+
+=09=09memset(&umap, 0, sizeof(umap));
+=09=09if ((rc =3D fb_alloc_cmap(&umap, length, transp)))
+=09=09=09return rc;
+
+=09=09umap.start =3D start;
+=09=09for (i =3D 0; i < length; i++) {
+=09=09=09sscanf(&buf[i * 16 +  3], "%4hx", &umap.red[i]);
+=09=09=09sscanf(&buf[i * 16 +  7], "%4hx", &umap.blue[i]);
+=09=09=09sscanf(&buf[i * 16 + 11], "%4hx", &umap.green[i]);
+=09=09=09if (transp)
+=09=09=09=09umap.transp[i] =3D (buf[i * 16 +  2] !=3D ' ');
+=09=09}
+=09=09rc =3D fb_info->fbops->fb_setcmap(&umap, fb_info);
+=09=09fb_copy_cmap(&umap, &fb_info->cmap);
+=09=09fb_dealloc_cmap(&umap);
+
+=09=09return rc;
+=09}
+=09for (i =3D 0; i < length; i++) {
+=09=09u16 red, blue, green, tsp;
+
+=09=09sscanf(&buf[i * 16 +  3], "%4hx", &red);
+=09=09sscanf(&buf[i * 16 +  7], "%4hx", &blue);
+=09=09sscanf(&buf[i * 16 + 11], "%4hx", &green);
+=09=09tsp =3D (buf[i * 16 +  2] !=3D ' ');
+=09=09if ((rc =3D fb_info->fbops->fb_setcolreg(start++,
+=09=09=09=09      red, green, blue, tsp, fb_info)))
+=09=09=09return rc;
+
+=09=09fb_info->cmap.red[i] =3D red;
+=09=09fb_info->cmap.blue[i] =3D blue;
+=09=09fb_info->cmap.green[i] =3D green;
+=09=09if (transp)
+=09=09=09fb_info->cmap.transp[i] =3D tsp;
+=09}
 =09return 0;
 }
=20
@@ -253,20 +311,24 @@ static ssize_t show_cmap(struct class_de
 {
 =09struct fb_info *fb_info =3D
 =09=09(struct fb_info *)class_get_devdata(class_device);
-=09unsigned int offset =3D 0, i;
-
+=09unsigned int i;
+=09
 =09if (!fb_info->cmap.red || !fb_info->cmap.blue ||
-=09    !fb_info->cmap.green || !fb_info->cmap.transp)
+=09   !fb_info->cmap.green)
 =09=09return -EINVAL;
-
+=09
+=09if (PAGE_SIZE < 4096)
+=09=09return -EINVAL;
+=09
+=09/* don't mess with the format, the buffer is PAGE_SIZE */
+=09/* 255 entries at 16 chars per line equals 4096 =3D PAGE_SIZE */
 =09for (i =3D 0; i < fb_info->cmap.len; i++) {
-=09=09offset +=3D snprintf(buf, PAGE_SIZE - offset,
-=09=09=09=09   "%d,%d,%d,%d,%d\n", i + fb_info->cmap.start,
-=09=09=09=09   fb_info->cmap.red[i], fb_info->cmap.blue[i],
-=09=09=09=09   fb_info->cmap.green[i],
-=09=09=09=09   fb_info->cmap.transp[i]);
+=09=09sprintf(&buf[ i * 16], "%02x%c%4x%4x%4x\n", i + fb_info->cmap.start,
+=09=09=09((fb_info->cmap.transp && fb_info->cmap.transp[i]) ? '*' : ' '),
+=09=09=09fb_info->cmap.red[i], fb_info->cmap.blue[i],
+=09=09=09fb_info->cmap.green[i]);
 =09}
-=09return offset;
+=09return 4096;
 }
=20
 static ssize_t store_blank(struct class_device *class_device, const char *=
 buf,


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
