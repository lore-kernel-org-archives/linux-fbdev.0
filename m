From: Scot Doyle <lkml14@scotdoyle.com>
Date: Tue, 04 Aug 2015 12:33:32 +0000
Subject: [PATCH] fbcon: unconditionally initialize cursor blink interval
Message-Id: <alpine.DEB.2.11.1508041215100.1151@local>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

A sun7i-a20-olinuxino-micro fails to boot when kernel parameter
vt.global_cursor_default=0. The value is copied to vc->vc_deccm
causing the initialization of ops->cur_blink_jiffies to be skipped.
Unconditionally initialize it.

Reported-and-tested-by: Jonathan Liu <net147@gmail.com>
Signed-off-by: Scot Doyle <lkml14@scotdoyle.com>
---
 drivers/video/console/fbcon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 658c34b..1aaf893 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -1306,10 +1306,11 @@ static void fbcon_cursor(struct vc_data *vc, int mode)
 	int y;
  	int c = scr_readw((u16 *) vc->vc_pos);
 
+	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
+
 	if (fbcon_is_inactive(vc, info) || vc->vc_deccm != 1)
 		return;
 
-	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
 	if (vc->vc_cursor_type & 0x10)
 		fbcon_del_cursor_timer(info);
 	else
-- 
2.1.4

