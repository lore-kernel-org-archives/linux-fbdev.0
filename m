From: John Tapsell <johnflux@gmail.com>
Date: Tue, 17 Sep 2013 22:29:11 +0000
Subject: [PATCH] fbcon: fix deadlock in fbcon_generic_blank()
Message-Id: <CAHQ6N+q13YeM60S_QfRF8Bh+Vc_7yHhCMSABQ=GOtOe5V0EXow@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Dave Airlie <airlied@redhat.com>, linux-fbdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

Do not lock fb_info when calling sending the FB_EVENT_CONBLANK
event.

In fbmem.c, the semantics are that we acquire the lock_fb_info first,
and then console_lock.  However when fbcon.c fbcon_generic_blank() is
called, the console lock could already be held.  Locking fb_info can
thus cause a deadlock.

fbmem.c sends the FB_EVENT_BLANK without locking lock_fb_info first, so
this change introduces similar behaviour.

Signed-off-by: John Tapsell <johnflux@gmail.com>

---
 drivers/video/console/fbcon.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 6b4fb5c..8546441 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -2333,13 +2333,9 @@ static void fbcon_generic_blank(struct vc_data
*vc, struct fb_info *info,
         vc->vc_video_erase_char = oldc;
     }

-
-    if (!lock_fb_info(info))
-        return;
     event.info = info;
     event.data = &blank;
     fb_notifier_call_chain(FB_EVENT_CONBLANK, &event);
-    unlock_fb_info(info);
 }

 static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
-- 
1.8.1.2
