From: Cedric Le Goater <clg@fr.ibm.com>
Date: Wed, 14 May 2014 14:01:17 +0000
Subject: Re: [PATCH] offb: Fix little-endian support
Message-Id: <5373772D.9060807@fr.ibm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1400073709-15012-1-git-send-email-tiwai@suse.de>
In-Reply-To: <1400073709-15012-1-git-send-email-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Takashi Iwai <tiwai@suse.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Iwai-san,

On 05/14/2014 03:21 PM, Takashi Iwai wrote:
> Although the color palette was corrected for little endian by the
> commit  [e1edf18b: offb: Add palette hack for little endian], the
> graphics mode is still shown in psychedelic colors. =20

Are you referring to the linux logo colors ? If so, could you please
try the patch below, it should be a fix.

> For fixing this
> properly, we rather need to correct the RGB offsets depending on
> endianess.
>=20
> Since the RGB base offsets are corrected, we don't need the hack for
> pallette color entries.  This patch reverts that, too.

Are you testing using qemu -vga std -vnc :x ? If so, did you try changing=20
the depth to 8,15,16,32 ?  I think the patch might be breaking big endian=20
too.

Now, I am far from being an expert on frame buffers. It would be glad=20
to have some insights on that topic.=20

Thanks,

C.=20


[PATCH] fb: fix logo palette entries for little endian

The offb_cmap_byteswap() routine helps byteswapping the color map
entries when required. This patch externalizes and renames the helper=20
routine to adjust the pseudo palette of the logo when running on=20
little endian.

Signed-off-by: C=E9dric Le Goater <clg@fr.ibm.com>
---
 drivers/video/fbmem.c |    6 ++++--
 drivers/video/offb.c  |   11 +----------
 include/linux/fb.h    |    8 ++++++++
 3 files changed, 13 insertions(+), 12 deletions(-)

Index: linux.git/drivers/video/fbmem.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux.git.orig/drivers/video/fbmem.c
+++ linux.git/drivers/video/fbmem.c
@@ -252,7 +252,8 @@ static void  fb_set_logo_truepalette(str
 	blueshift  =3D info->var.blue.offset  - (8 - info->var.blue.length);
=20
 	for ( i =3D 0; i < logo->clutsize; i++) {
-		palette[i+32] =3D (safe_shift((clut[0] & redmask), redshift) |
+		palette[i+32] =3D fb_cmap_byteswap(info,
+				 safe_shift((clut[0] & redmask), redshift) |
 				 safe_shift((clut[1] & greenmask), greenshift) |
 				 safe_shift((clut[2] & bluemask), blueshift));
 		clut +=3D 3;
@@ -271,7 +272,8 @@ static void fb_set_logo_directpalette(st
 	blueshift =3D info->var.blue.offset;
=20
 	for (i =3D 32; i < 32 + logo->clutsize; i++)
-		palette[i] =3D i << redshift | i << greenshift | i << blueshift;
+		palette[i] =3D fb_cmap_byteswap(info, i << redshift |
+					i << greenshift | i << blueshift);
 }
=20
 static void fb_set_logo(struct fb_info *info,
Index: linux.git/drivers/video/offb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux.git.orig/drivers/video/offb.c
+++ linux.git/drivers/video/offb.c
@@ -91,15 +91,6 @@ extern boot_infos_t *boot_infos;
 #define AVIVO_DC_LUTB_WHITE_OFFSET_GREEN        0x6cd4
 #define AVIVO_DC_LUTB_WHITE_OFFSET_RED          0x6cd8
=20
-#define FB_RIGHT_POS(p, bpp)         (fb_be_math(p) ? 0 : (32 - (bpp)))
-
-static inline u32 offb_cmap_byteswap(struct fb_info *info, u32 value)
-{
-	u32 bpp =3D info->var.bits_per_pixel;
-
-	return cpu_to_be32(value) >> FB_RIGHT_POS(info, bpp);
-}
-
     /*
      *  Set a single color register. The values supplied are already
      *  rounded down to the hardware's capabilities (according to the
@@ -129,7 +120,7 @@ static int offb_setcolreg(u_int regno, u
 			mask <<=3D info->var.transp.offset;
 			value |=3D mask;
 		}
-		pal[regno] =3D offb_cmap_byteswap(info, value);
+		pal[regno] =3D fb_cmap_byteswap(info, value);
 		return 0;
 	}
=20
Index: linux.git/include/linux/fb.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux.git.orig/include/linux/fb.h
+++ linux.git/include/linux/fb.h
@@ -582,6 +582,7 @@ static inline struct apertures_struct *a
=20
 #endif
=20
+#define FB_RIGHT_POS(p, bpp)         (fb_be_math(p) ? 0 : (32 - (bpp)))
 #define FB_LEFT_POS(p, bpp)          (fb_be_math(p) ? (32 - (bpp)) : 0)
 #define FB_SHIFT_HIGH(p, val, bits)  (fb_be_math(p) ? (val) >> (bits) : \
 						      (val) << (bits))
@@ -681,6 +682,13 @@ static inline bool fb_be_math(struct fb_
 #endif /* CONFIG_FB_FOREIGN_ENDIAN */
 }
=20
+static inline u32 fb_cmap_byteswap(struct fb_info *info, u32 value)
+{
+	u32 bpp =3D info->var.bits_per_pixel;
+
+	return cpu_to_be32(value) >> FB_RIGHT_POS(info, bpp);
+}
+
 /* drivers/video/fbsysfs.c */
 extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);
 extern void framebuffer_release(struct fb_info *info);

