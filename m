From: Henry Nestler <henry.nestler@gmail.com>
Date: Sun, 20 Feb 2011 20:50:56 +0000
Subject: Fwd: Re: [PATCH] fbcon: Bugfix soft cursor detection in Tile Blitting
Message-Id: <4D617EB0.3070705@henry.nestler.mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use mask 0x10 for "soft cursor" detection on in function tile_cursor.
(Tile Blitting Operation in framebuffer console).

The old mask 0x01 for vc_cursor_type detects CUR_NONE, CUR_LOWER_THIRD
and every second mode value as "software cursor". This hides the cursor
for these modes (cursor.mode = 0). But, only CUR_NONE or "software cursor"
should hide the cursor.
See also 0x10 in functions add_softcursor, bit_cursor and cw_cursor.
---
Kernel version 2.6.38-rc5

 drivers/video/console/tileblit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/tileblit.c b/drivers/video/console/tileblit.c
index 0056a41..15e8e1a 100644
--- a/drivers/video/console/tileblit.c
+++ b/drivers/video/console/tileblit.c
@@ -83,7 +83,7 @@ static void tile_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 			int softback_lines, int fg, int bg)
 {
 	struct fb_tilecursor cursor;
-	int use_sw = (vc->vc_cursor_type & 0x01);
+	int use_sw = (vc->vc_cursor_type & 0x10);
 
 	cursor.sx = vc->vc_x;
 	cursor.sy = vc->vc_y;

