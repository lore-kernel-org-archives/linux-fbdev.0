From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 00:04:20 +0000
Subject: [PATCH 3/3] console: Expand dummy functions for CFI
Message-Id: <1519689860-7421-4-git-send-email-keescook@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1519689860-7421-1-git-send-email-keescook@chromium.org>
In-Reply-To: <1519689860-7421-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Thomas Winischhofer <thomas@winischhofer.net>, linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

This expands the no-op dummy functions into full prototypes to avoid
indirect call mismatches when running under Control Flow Integrity
checking, like with Clang's -fsanitize=CFi.

Co-Developed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/usb/misc/sisusbvga/sisusb_con.c | 67 +++++++++++++++++++++++++----=
---
 drivers/video/console/dummycon.c        | 69 +++++++++++++++++++++++++----=
----
 drivers/video/console/newport_con.c     | 10 ++---
 drivers/video/console/vgacon.c          | 20 +++++-----
 drivers/video/fbdev/core/fbcon.c        |  3 +-
 5 files changed, 121 insertions(+), 48 deletions(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sis=
usbvga/sisusb_con.c
index 998df891bdde..a0d6e0af957c 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -1217,7 +1217,7 @@ sisusbcon_do_font_op(struct sisusb_usb_data *sisusb, =
int set, int slot,
 /* Interface routine */
 static int
 sisusbcon_font_set(struct vc_data *c, struct console_font *font,
-							unsigned flags)
+		   unsigned int flags)
 {
 	struct sisusb_usb_data *sisusb;
 	unsigned charcount =3D font->charcount;
@@ -1338,28 +1338,65 @@ static void sisusbdummycon_init(struct vc_data *vc,=
 int init)
 	vc_resize(vc, 80, 25);
 }
=20
-static int sisusbdummycon_dummy(void)
+static void sisusbdummycon_deinit(struct vc_data *vc) { }
+static void sisusbdummycon_clear(struct vc_data *vc, int sy, int sx,
+				 int height, int width) { }
+static void sisusbdummycon_putc(struct vc_data *vc, int c, int ypos,
+				int xpos) { }
+static void sisusbdummycon_putcs(struct vc_data *vc, const unsigned short =
*s,
+				 int count, int ypos, int xpos) { }
+static void sisusbdummycon_cursor(struct vc_data *vc, int mode) { }
+
+static bool sisusbdummycon_scroll(struct vc_data *vc, unsigned int top,
+				  unsigned int bottom, enum con_scroll dir,
+				  unsigned int lines)
 {
-    return 0;
+	return false;
 }
=20
-#define SISUSBCONDUMMY	(void *)sisusbdummycon_dummy
+static int sisusbdummycon_switch(struct vc_data *vc)
+{
+	return 0;
+}
+
+static int sisusbdummycon_blank(struct vc_data *vc, int blank, int mode_sw=
itch)
+{
+	return 0;
+}
+
+static int sisusbdummycon_font_set(struct vc_data *vc,
+				   struct console_font *font,
+				   unsigned int flags)
+{
+	return 0;
+}
+
+static int sisusbdummycon_font_default(struct vc_data *vc,
+				       struct console_font *font, char *name)
+{
+	return 0;
+}
+
+static int sisusbdummycon_font_copy(struct vc_data *vc, int con)
+{
+	return 0;
+}
=20
 static const struct consw sisusb_dummy_con =3D {
 	.owner =3D		THIS_MODULE,
 	.con_startup =3D		sisusbdummycon_startup,
 	.con_init =3D		sisusbdummycon_init,
-	.con_deinit =3D		SISUSBCONDUMMY,
-	.con_clear =3D		SISUSBCONDUMMY,
-	.con_putc =3D		SISUSBCONDUMMY,
-	.con_putcs =3D		SISUSBCONDUMMY,
-	.con_cursor =3D		SISUSBCONDUMMY,
-	.con_scroll =3D		SISUSBCONDUMMY,
-	.con_switch =3D		SISUSBCONDUMMY,
-	.con_blank =3D		SISUSBCONDUMMY,
-	.con_font_set =3D		SISUSBCONDUMMY,
-	.con_font_default =3D	SISUSBCONDUMMY,
-	.con_font_copy =3D	SISUSBCONDUMMY,
+	.con_deinit =3D		sisusbdummycon_deinit,
+	.con_clear =3D		sisusbdummycon_clear,
+	.con_putc =3D		sisusbdummycon_putc,
+	.con_putcs =3D		sisusbdummycon_putcs,
+	.con_cursor =3D		sisusbdummycon_cursor,
+	.con_scroll =3D		sisusbdummycon_scroll,
+	.con_switch =3D		sisusbdummycon_switch,
+	.con_blank =3D		sisusbdummycon_blank,
+	.con_font_set =3D		sisusbdummycon_font_set,
+	.con_font_default =3D	sisusbdummycon_font_default,
+	.con_font_copy =3D	sisusbdummycon_font_copy,
 };
=20
 int
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummy=
con.c
index b90ef96e43d6..f2eafe2ed980 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -41,12 +41,47 @@ static void dummycon_init(struct vc_data *vc, int init)
 	vc_resize(vc, DUMMY_COLUMNS, DUMMY_ROWS);
 }
=20
-static int dummycon_dummy(void)
+static void dummycon_deinit(struct vc_data *vc) { }
+static void dummycon_clear(struct vc_data *vc, int sy, int sx, int height,
+			   int width) { }
+static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos) {=
 }
+static void dummycon_putcs(struct vc_data *vc, const unsigned short *s,
+			   int count, int ypos, int xpos) { }
+static void dummycon_cursor(struct vc_data *vc, int mode) { }
+
+static bool dummycon_scroll(struct vc_data *vc, unsigned int top,
+			    unsigned int bottom, enum con_scroll dir,
+			    unsigned int lines)
+{
+	return false;
+}
+
+static int dummycon_switch(struct vc_data *vc)
 {
-    return 0;
+	return 0;
 }
=20
-#define DUMMY	(void *)dummycon_dummy
+static int dummycon_blank(struct vc_data *vc, int blank, int mode_switch)
+{
+	return 0;
+}
+
+static int dummycon_font_set(struct vc_data *vc, struct console_font *font,
+			     unsigned int flags)
+{
+	return 0;
+}
+
+static int dummycon_font_default(struct vc_data *vc,
+				 struct console_font *font, char *name)
+{
+	return 0;
+}
+
+static int dummycon_font_copy(struct vc_data *vc, int con)
+{
+	return 0;
+}
=20
 /*
  *  The console `switch' structure for the dummy console
@@ -55,19 +90,19 @@ static int dummycon_dummy(void)
  */
=20
 const struct consw dummy_con =3D {
-    .owner =3D		THIS_MODULE,
-    .con_startup =3D	dummycon_startup,
-    .con_init =3D		dummycon_init,
-    .con_deinit =3D	DUMMY,
-    .con_clear =3D	DUMMY,
-    .con_putc =3D		DUMMY,
-    .con_putcs =3D	DUMMY,
-    .con_cursor =3D	DUMMY,
-    .con_scroll =3D	DUMMY,
-    .con_switch =3D	DUMMY,
-    .con_blank =3D	DUMMY,
-    .con_font_set =3D	DUMMY,
-    .con_font_default =3D	DUMMY,
-    .con_font_copy =3D	DUMMY,
+	.owner =3D		THIS_MODULE,
+	.con_startup =3D	dummycon_startup,
+	.con_init =3D		dummycon_init,
+	.con_deinit =3D	dummycon_deinit,
+	.con_clear =3D	dummycon_clear,
+	.con_putc =3D		dummycon_putc,
+	.con_putcs =3D	dummycon_putcs,
+	.con_cursor =3D	dummycon_cursor,
+	.con_scroll =3D	dummycon_scroll,
+	.con_switch =3D	dummycon_switch,
+	.con_blank =3D	dummycon_blank,
+	.con_font_set =3D	dummycon_font_set,
+	.con_font_default =3D	dummycon_font_default,
+	.con_font_copy =3D	dummycon_font_copy,
 };
 EXPORT_SYMBOL_GPL(dummy_con);
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/ne=
wport_con.c
index 42d02a206059..6897bd0fc00e 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -673,14 +673,14 @@ static bool newport_scroll(struct vc_data *vc, unsign=
ed int t, unsigned int b,
 	return true;
 }
=20
-static int newport_dummy(struct vc_data *c)
+static int newport_set_origin(struct vc_data *vc)
 {
 	return 0;
 }
=20
-#define DUMMY (void *) newport_dummy
+static void newport_save_screen(struct vc_data *vc) { }
=20
-const struct consw newport_con =3D {
+static const struct consw newport_con =3D {
 	.owner		  =3D THIS_MODULE,
 	.con_startup	  =3D newport_startup,
 	.con_init	  =3D newport_init,
@@ -694,8 +694,8 @@ const struct consw newport_con =3D {
 	.con_blank	  =3D newport_blank,
 	.con_font_set	  =3D newport_font_set,
 	.con_font_default =3D newport_font_default,
-	.con_set_origin	  =3D DUMMY,
-	.con_save_screen  =3D DUMMY
+	.con_set_origin	  =3D newport_set_origin,
+	.con_save_screen  =3D newport_save_screen
 };
=20
 static int newport_probe(struct gio_device *dev,
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index a17ba1465815..f09e17b60e45 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -1272,7 +1272,8 @@ static int vgacon_adjust_height(struct vc_data *vc, u=
nsigned fontheight)
 	return 0;
 }
=20
-static int vgacon_font_set(struct vc_data *c, struct console_font *font, u=
nsigned flags)
+static int vgacon_font_set(struct vc_data *c, struct console_font *font,
+			   unsigned int flags)
 {
 	unsigned charcount =3D font->charcount;
 	int rc;
@@ -1407,21 +1408,20 @@ static bool vgacon_scroll(struct vc_data *c, unsign=
ed int t, unsigned int b,
  *  The console `switch' structure for the VGA based console
  */
=20
-static int vgacon_dummy(struct vc_data *c)
-{
-	return 0;
-}
-
-#define DUMMY (void *) vgacon_dummy
+static void vgacon_clear(struct vc_data *vc, int sy, int sx, int height,
+			 int width) { }
+static void vgacon_putc(struct vc_data *vc, int c, int ypos, int xpos) { }
+static void vgacon_putcs(struct vc_data *vc, const unsigned short *s,
+			 int count, int ypos, int xpos) { }
=20
 const struct consw vga_con =3D {
 	.owner =3D THIS_MODULE,
 	.con_startup =3D vgacon_startup,
 	.con_init =3D vgacon_init,
 	.con_deinit =3D vgacon_deinit,
-	.con_clear =3D DUMMY,
-	.con_putc =3D DUMMY,
-	.con_putcs =3D DUMMY,
+	.con_clear =3D vgacon_clear,
+	.con_putc =3D vgacon_putc,
+	.con_putcs =3D vgacon_putcs,
 	.con_cursor =3D vgacon_cursor,
 	.con_scroll =3D vgacon_scroll,
 	.con_switch =3D vgacon_switch,
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fb=
con.c
index 5baf7bc054e1..3e330e0f56ed 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2595,7 +2595,8 @@ static int fbcon_copy_font(struct vc_data *vc, int co=
n)
  *  is ever implemented.
  */
=20
-static int fbcon_set_font(struct vc_data *vc, struct console_font *font, u=
nsigned flags)
+static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
+			  unsigned int flags)
 {
 	struct fb_info *info =3D registered_fb[con2fb_map[vc->vc_num]];
 	unsigned charcount =3D font->charcount;
--=20
2.7.4

