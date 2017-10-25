From: Max Staudt <mstaudt@suse.de>
Date: Wed, 25 Oct 2017 12:45:53 +0000
Subject: [RFC 05/14] bootsplash: Disable splash on oops
Message-Id: <20171025124602.28292-6-mstaudt@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171025124602.28292-1-mstaudt@suse.de>
In-Reply-To: <20171025124602.28292-1-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: mstaudt@suse.de, tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, linux-kernel@vger.kernel.org

Signed-off-by: Max Staudt <mstaudt@suse.de>
Reviewed-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/video/fbdev/core/fbcon.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 4ac1a33be418..cbe8a4480037 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1333,6 +1333,15 @@ static void fbcon_cursor(struct vc_data *vc, int mode)
 	int y;
  	int c = scr_readw((u16 *) vc->vc_pos);
 
+	/* Disable the splash here so we don't have to hook into
+	 * vt_console_print() in drivers/tty/vt/vt.c
+	 *
+	 * We'd disable the splash just before the call to
+	 * hide_cursor() anyway, so this spot is just fine.
+	 */
+	if (oops_in_progress)
+		bootsplash_disable();
+
 	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
 
 	if (fbcon_is_inactive(vc, info) || vc->vc_deccm != 1)
-- 
2.12.3

