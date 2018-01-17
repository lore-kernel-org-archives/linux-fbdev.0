From: Max Staudt <mstaudt@suse.de>
Date: Wed, 17 Jan 2018 20:54:31 +0000
Subject: [RFC PATCH v3 09/13] fbcon: Disable bootsplash on oops
Message-Id: <20180117205435.2860-10-mstaudt@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180117205435.2860-1-mstaudt@suse.de>
In-Reply-To: <20180117205435.2860-1-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: mstaudt@suse.de, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, philm@manjaro.org, bernhard.rosenkranzer@linaro.org, kernel.max@enpas.org

Signed-off-by: Max Staudt <mstaudt@suse.de>
Reviewed-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/video/fbdev/core/fbcon.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 9a39a6fcfe98..8a9c67e1c5d8 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1343,6 +1343,16 @@ static void fbcon_cursor(struct vc_data *vc, int mode)
 	int y;
  	int c = scr_readw((u16 *) vc->vc_pos);
 
+	/*
+	 * Disable the splash here so we don't have to hook into
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

