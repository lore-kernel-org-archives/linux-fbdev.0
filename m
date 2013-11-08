From: Denis Carikli <denis@eukrea.com>
Date: Fri, 08 Nov 2013 13:01:29 +0000
Subject: [PATCHv5][ 1/5] fbdev: Add the lacking FB_SYNC_* for matching the DISPLAY_FLAGS_*
Message-Id: <1383915693-9422-1-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Without that fix, drivers using the fb_videomode_from_videomode
  function will not be able to get certain information because
  some DISPLAY_FLAGS_* have no corresponding FB_SYNC_*.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: devicetree@vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Eric B=C3=A9nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
ChangeLog v4->v5:
- Added Geert Uytterhoeven, Grant Likely and Shawn Guo in the Cc list.
- Moved the definitions to a non-userspace header.
- Corrected the comment of the second define.

ChangeLog v3->v4:
- Fixed the issue with FB_SYNC_PIXDAT_HIGH_ACT value.

ChangeLog v2->v3:
- Added Jean-Christophe PLAGNIOL-VILLARD's ACK.
---
 drivers/video/fbmon.c |    4 ++++
 include/linux/fb.h    |    3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 6103fa6..29a9ed0 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -1402,6 +1402,10 @@ int fb_videomode_from_videomode(const struct videomo=
de *vm,
 		fbmode->sync |=3D FB_SYNC_HOR_HIGH_ACT;
 	if (vm->flags & DISPLAY_FLAGS_VSYNC_HIGH)
 		fbmode->sync |=3D FB_SYNC_VERT_HIGH_ACT;
+	if (vm->flags & DISPLAY_FLAGS_DE_HIGH)
+		fbmode->sync |=3D FB_SYNC_DE_HIGH_ACT;
+	if (vm->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
+		fbmode->sync |=3D FB_SYNC_PIXDAT_HIGH_ACT;
 	if (vm->flags & DISPLAY_FLAGS_INTERLACED)
 		fbmode->vmode |=3D FB_VMODE_INTERLACED;
 	if (vm->flags & DISPLAY_FLAGS_DOUBLESCAN)
diff --git a/include/linux/fb.h b/include/linux/fb.h
index ffac70a..cf2ad5d 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -45,6 +45,9 @@ struct device_node;
 #define FB_SIGNAL_SYNC_ON_GREEN	8
 #define FB_SIGNAL_SERRATION_ON	16
=20
+#define FB_SYNC_DE_HIGH_ACT     64      /* data enable active high flag */
+#define FB_SYNC_PIXDAT_HIGH_ACT 128     /* drive data on positive edge */
+
 #define FB_MISC_PRIM_COLOR	1
 #define FB_MISC_1ST_DETAIL	2	/* First Detailed Timing is preferred */
 struct fb_chroma {
--=20
1.7.9.5

