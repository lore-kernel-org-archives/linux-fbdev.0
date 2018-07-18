From: Adam Borowski <kilobyte@angband.pl>
Date: Wed, 18 Jul 2018 03:03:23 +0000
Subject: [PATCH 2/6] vt: add console flag "unblinking"
Message-Id: <20180718030327.579-2-kilobyte@angband.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
 <20180718030327.579-1-kilobyte@angband.pl>
In-Reply-To: <20180718030327.579-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Adam Borowski <kilobyte@angband.pl>

Marks consoles that interpret the blink bit by showing bright background
instead.  Doesn't matter if the console can't do either.

For now, turn it on for fbcon when in color mode.  Vgacon can also do so
but requires setting appropriate VGA register (bit 3 of AMCR).  I don't
know other consoles: newport looks like it shows bright bg, sti can't do
either, mda appears to blink, etc -- but confirmation would be needed.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/tty/vt/vt.c              | 1 +
 drivers/video/fbdev/core/fbcon.c | 1 +
 include/linux/console_struct.h   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 846dfedb657d..45057bbf6f74 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -998,6 +998,7 @@ static void visual_init(struct vc_data *vc, int num, int init)
 	vc->vc_hi_font_mask = 0;
 	vc->vc_complement_mask = 0;
 	vc->vc_can_do_color = 0;
+	vc->vc_unblinking = 0;
 	vc->vc_panic_force_write = false;
 	vc->vc_cur_blink_ms = DEFAULT_CURSOR_BLINK_MS;
 	vc->vc_sw->con_init(vc, init);
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index c910e74d46ff..4c67254f1ec4 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1092,6 +1092,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 
 	vc->vc_panic_force_write = !!(info->flags & FBINFO_CAN_FORCE_OUTPUT);
 	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
+	vc->vc_unblinking = vc->vc_can_do_color;
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
 	if (charcnt = 256) {
 		vc->vc_hi_font_mask = 0;
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index fea64f2692a0..f94b28a6bd2d 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -122,6 +122,7 @@ struct vc_data {
 	unsigned int	vc_ques		: 1;
 	unsigned int	vc_need_wrap	: 1;
 	unsigned int	vc_can_do_color	: 1;
+	unsigned int	vc_unblinking   : 1;	/* shows bright bg for blink */
 	unsigned int	vc_report_mouse : 2;
 	unsigned char	vc_utf		: 1;	/* Unicode UTF-8 encoding */
 	unsigned char	vc_utf_count;
-- 
2.18.0

