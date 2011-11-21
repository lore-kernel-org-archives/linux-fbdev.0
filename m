From: Joonyoung Shim <jy0922.shim@samsung.com>
Date: Mon, 21 Nov 2011 06:03:31 +0000
Subject: [PATCH] video: Fix return value of fb_notifier_call_chain
Message-Id: <1321855411-13730-1-git-send-email-jy0922.shim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The return value of blocking_notifier_call_chain isn't errno value, it
is just notify return value. The ret of fb_notifier_call_chain should is
restored to error value from notify return value using
notifier_to_errno().

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/video/fb_notify.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fb_notify.c b/drivers/video/fb_notify.c
index 74c2da5..49a64a3 100644
--- a/drivers/video/fb_notify.c
+++ b/drivers/video/fb_notify.c
@@ -42,6 +42,8 @@ EXPORT_SYMBOL(fb_unregister_client);
  */
 int fb_notifier_call_chain(unsigned long val, void *v)
 {
-	return blocking_notifier_call_chain(&fb_notifier_list, val, v);
+	int ret = blocking_notifier_call_chain(&fb_notifier_list, val, v);
+
+	return notifier_to_errno(ret);
 }
 EXPORT_SYMBOL_GPL(fb_notifier_call_chain);
-- 
1.7.5.4

