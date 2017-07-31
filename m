From: David Lechner <david@lechnology.com>
Date: Mon, 31 Jul 2017 19:09:44 +0000
Subject: [PATCH v2 1/2] fbcon: Invert margin colors when terminal is inverted
Message-Id: <1501528185-9976-2-git-send-email-david@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501528185-9976-1-git-send-email-david@lechnology.com>
In-Reply-To: <1501528185-9976-1-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org

This uses white (7) for the margin color when a fbcon terminal is inverted,
e.g. with `setterm -inverse on`.

The motivation for this is screens where the black does not blend into the
screen. For example, using an LCD (not the backlit kind), white text on a
black background is hard to read, so inverting the colors is preferred.
However, if the margins are not also inverted, it leaves ugly black bars
on the right and bottom of the text area.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/video/console/bitblit.c   | 2 +-
 drivers/video/console/fbcon_ccw.c | 2 +-
 drivers/video/console/fbcon_cw.c  | 2 +-
 drivers/video/console/fbcon_ud.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/console/bitblit.c b/drivers/video/console/bitblit.c
index dbfe4ee..13cad9e 100644
--- a/drivers/video/console/bitblit.c
+++ b/drivers/video/console/bitblit.c
@@ -213,7 +213,7 @@ static void bit_clear_margins(struct vc_data *vc, struct fb_info *info,
 	unsigned int bs = info->var.yres - bh;
 	struct fb_fillrect region;
 
-	region.color = 0;
+	region.color = vc->vc_decscnm ? 7 : 0;
 	region.rop = ROP_COPY;
 
 	if (rw && !bottom_only) {
diff --git a/drivers/video/console/fbcon_ccw.c b/drivers/video/console/fbcon_ccw.c
index 5a3cbf6..371f0155 100644
--- a/drivers/video/console/fbcon_ccw.c
+++ b/drivers/video/console/fbcon_ccw.c
@@ -198,7 +198,7 @@ static void ccw_clear_margins(struct vc_data *vc, struct fb_info *info,
 	unsigned int bs = vc->vc_rows*ch;
 	struct fb_fillrect region;
 
-	region.color = 0;
+	region.color = vc->vc_decscnm ? 7 : 0;
 	region.rop = ROP_COPY;
 
 	if (rw && !bottom_only) {
diff --git a/drivers/video/console/fbcon_cw.c b/drivers/video/console/fbcon_cw.c
index e7ee44d..541e66c 100644
--- a/drivers/video/console/fbcon_cw.c
+++ b/drivers/video/console/fbcon_cw.c
@@ -181,7 +181,7 @@ static void cw_clear_margins(struct vc_data *vc, struct fb_info *info,
 	unsigned int rs = info->var.yres - rw;
 	struct fb_fillrect region;
 
-	region.color = 0;
+	region.color = vc->vc_decscnm ? 7 : 0;
 	region.rop = ROP_COPY;
 
 	if (rw && !bottom_only) {
diff --git a/drivers/video/console/fbcon_ud.c b/drivers/video/console/fbcon_ud.c
index 19e3714..61fe137 100644
--- a/drivers/video/console/fbcon_ud.c
+++ b/drivers/video/console/fbcon_ud.c
@@ -228,7 +228,7 @@ static void ud_clear_margins(struct vc_data *vc, struct fb_info *info,
 	unsigned int bh = info->var.yres - (vc->vc_rows*ch);
 	struct fb_fillrect region;
 
-	region.color = 0;
+	region.color = vc->vc_decscnm ? 7 : 0;
 	region.rop = ROP_COPY;
 
 	if (rw && !bottom_only) {
-- 
2.7.4

