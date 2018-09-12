From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 12 Sep 2018 09:12:35 +0000
Subject: [PATCH] efifb: BGRT: Add nobgrt option
Message-Id: <20180912091235.20473-1-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

In some setups restoring the BGRT logo is undesirable, allow passing
video=EFifb:nobgrt on the kernel commandline to disable it.

Cc: David Herrmann <dh.herrmann@gmail.com>
Reported-by: David Herrmann <dh.herrmann@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/fbdev/efifb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 3946649b85c8..ba906876cc45 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -42,6 +42,7 @@ struct bmp_dib_header {
 	u32 colors_important;
 } __packed;
=20
+static bool use_bgrt =3D true;
 static bool request_mem_succeeded =3D false;
 static u64 mem_flags =3D EFI_MEMORY_WC | EFI_MEMORY_UC;
=20
@@ -160,6 +161,9 @@ static void efifb_show_boot_graphics(struct fb_info *in=
fo)
 	void *bgrt_image =3D NULL;
 	u8 *dst =3D info->screen_base;
=20
+	if (!use_bgrt)
+		return;
+
 	if (!bgrt_tab.image_address) {
 		pr_info("efifb: No BGRT, not showing boot graphics\n");
 		return;
@@ -290,6 +294,8 @@ static int efifb_setup(char *options)
 				screen_info.lfb_width =3D simple_strtoul(this_opt+6, NULL, 0);
 			else if (!strcmp(this_opt, "nowc"))
 				mem_flags &=3D ~EFI_MEMORY_WC;
+			else if (!strcmp(this_opt, "nobgrt"))
+				use_bgrt =3D false;
 		}
 	}
=20
--=20
2.19.0.rc0
