From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] fbdev: colormap fixes
Date: Thu, 28 Jul 2005 10:45:43 -0400
Message-ID: <9e473391050728074573e40038@mail.gmail.com>
References: <200507280031.j6S0V3L3016861@hera.kernel.org>
	 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dy9du-0003DX-2B
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 07:45:50 -0700
Received: from wproxy.gmail.com ([64.233.184.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Dy9dt-00039y-LB
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 07:45:50 -0700
Received: by wproxy.gmail.com with SMTP id 36so412357wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Jul 2005 07:45:43 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be>
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

Can you review this fix for the issues below? I fixed things to
automatically adjust the number of entries to whatever fits in
PAGE_SIZE.

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



On 7/28/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, 27 Jul 2005, Linux Kernel Mailing List wrote:
> > tree 17014af0ea8b19dae7848736d324499715b7a1a3
> > parent 3ca34fcbfbf8a7cbe99d54ae81c4e28fdc6f4ac6
> > author Jon Smirl <jonsmirl@gmail.com> Thu, 28 Jul 2005 01:46:05 -0700
> > committer Linus Torvalds <torvalds@g5.osdl.org> Thu, 28 Jul 2005 06:26:=
18 -0700
> >
> > [PATCH] fbdev: colormap fixes
> >
> > Color maps have up to 256 entries.  4096/256 allows for 16 characters p=
er
>              ^^^^^^^^^^^^^^^^^^^^^^
> Most (all?) current drivers have this limitation. But there exists hardwa=
re
> with more entries.
>=20
> > line.  The format for a cmap entry is "%02x%c%4x%4x%4x\n" %02x entry %c
> > transp %4x red %4x blue %4x green
> >
> > You can read the color_map with cat fb0/color_map.
> >
> > Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> >
> >  drivers/video/fbsysfs.c |   82 +++++++++++++++++++++++++++++++++++++++=
+++------
> >  1 files changed, 72 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
> > --- a/drivers/video/fbsysfs.c
> > +++ b/drivers/video/fbsysfs.c
> > @@ -242,10 +242,68 @@ static ssize_t show_virtual(struct class
> >                       fb_info->var.yres_virtual);
> >  }
> >
> > -static ssize_t store_cmap(struct class_device *class_device, const cha=
r * buf,
> > +/* Format for cmap is "%02x%c%4x%4x%4x\n" */
> > +/* %02x entry %c transp %4x red %4x blue %4x green \n */
> > +/* 255 rows at 16 chars equals 4096 */
>       ^^^
> 256?
>=20
> > +/* PAGE_SIZE can be 4096 or larger */
> > +static ssize_t store_cmap(struct class_device *class_device, const cha=
r *buf,
> >                         size_t count)
> >  {
> > -//   struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(c=
lass_device);
> > +     struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(c=
lass_device);
> > +     int rc, i, start, length, transp =3D 0;
> > +
> > +     if ((count > 4096) || ((count % 16) !=3D 0) || (PAGE_SIZE < 4096)=
)
> > +             return -EINVAL;
> > +
> > +     if (!fb_info->fbops->fb_setcolreg && !fb_info->fbops->fb_setcmap)
> > +             return -EINVAL;
> > +
> > +     sscanf(buf, "%02x", &start);
> > +     length =3D count / 16;
> > +
> > +     for (i =3D 0; i < length; i++)
> > +             if (buf[i * 16 + 2] !=3D ' ')
> > +                     transp =3D 1;
> > +
> > +     /* If we can batch, do it */
> > +     if (fb_info->fbops->fb_setcmap && length > 1) {
> > +             struct fb_cmap umap;
> > +
> > +             memset(&umap, 0, sizeof(umap));
> > +             if ((rc =3D fb_alloc_cmap(&umap, length, transp)))
> > +                     return rc;
> > +
> > +             umap.start =3D start;
> > +             for (i =3D 0; i < length; i++) {
> > +                     sscanf(&buf[i * 16 +  3], "%4hx", &umap.red[i]);
> > +                     sscanf(&buf[i * 16 +  7], "%4hx", &umap.blue[i]);
> > +                     sscanf(&buf[i * 16 + 11], "%4hx", &umap.green[i])=
;
> > +                     if (transp)
> > +                             umap.transp[i] =3D (buf[i * 16 +  2] !=3D=
 ' ');
> > +             }
> > +             rc =3D fb_info->fbops->fb_setcmap(&umap, fb_info);
> > +             fb_copy_cmap(&umap, &fb_info->cmap);
> > +             fb_dealloc_cmap(&umap);
> > +
> > +             return rc;
> > +     }
> > +     for (i =3D 0; i < length; i++) {
> > +             u16 red, blue, green, tsp;
> > +
> > +             sscanf(&buf[i * 16 +  3], "%4hx", &red);
> > +             sscanf(&buf[i * 16 +  7], "%4hx", &blue);
> > +             sscanf(&buf[i * 16 + 11], "%4hx", &green);
> > +             tsp =3D (buf[i * 16 +  2] !=3D ' ');
> > +             if ((rc =3D fb_info->fbops->fb_setcolreg(start++,
> > +                                   red, green, blue, tsp, fb_info)))
> > +                     return rc;
> > +
> > +             fb_info->cmap.red[i] =3D red;
> > +             fb_info->cmap.blue[i] =3D blue;
> > +             fb_info->cmap.green[i] =3D green;
> > +             if (transp)
> > +                     fb_info->cmap.transp[i] =3D tsp;
> > +     }
> >       return 0;
> >  }
> >
> > @@ -253,20 +311,24 @@ static ssize_t show_cmap(struct class_de
> >  {
> >       struct fb_info *fb_info =3D
> >               (struct fb_info *)class_get_devdata(class_device);
> > -     unsigned int offset =3D 0, i;
> > +     unsigned int i;
> >
> >       if (!fb_info->cmap.red || !fb_info->cmap.blue ||
> > -         !fb_info->cmap.green || !fb_info->cmap.transp)
> > +        !fb_info->cmap.green)
> > +             return -EINVAL;
> > +
> > +     if (PAGE_SIZE < 4096)
> >               return -EINVAL;
> >
> > +     /* don't mess with the format, the buffer is PAGE_SIZE */
> > +     /* 255 entries at 16 chars per line equals 4096 =3D PAGE_SIZE */
>            ^^^
> 256?
>=20
> >       for (i =3D 0; i < fb_info->cmap.len; i++) {
> > -             offset +=3D snprintf(buf, PAGE_SIZE - offset,
> > -                                "%d,%d,%d,%d,%d\n", i + fb_info->cmap.=
start,
> > -                                fb_info->cmap.red[i], fb_info->cmap.bl=
ue[i],
> > -                                fb_info->cmap.green[i],
> > -                                fb_info->cmap.transp[i]);
> > +             sprintf(&buf[ i * 16], "%02x%c%4x%4x%4x\n", i + fb_info->=
cmap.start,
>=20
> Woops, nice buffer overflow if fb_info->cmap.len > 256...
>=20
> > +                     ((fb_info->cmap.transp && fb_info->cmap.transp[i]=
) ? '*' : ' '),
> > +                     fb_info->cmap.red[i], fb_info->cmap.blue[i],
> > +                     fb_info->cmap.green[i]);
> >       }
> > -     return offset;
> > +     return 4096;
>                ^^^^
>=20
> What if fb_info->cmap.len is smaller than 256?
>=20
> >  }
>=20
> Gr{oetje,eeting}s,
>=20
>                                                 Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                                             -- Linus Torv=
alds
>=20


--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
