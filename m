From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Fri, 20 Dec 2013 14:24:20 +0000
Subject: [PATCH] video/logo: don't look for the logo after system boot
Message-Id: <1387549460-18501-1-git-send-email-bigeasy@linutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

If the primary GPU driver has been loaded _after_ system as a module
then this logo memory is no longer valid.
Managed to crash the system by booting a box without a GPU and then
hotpluggin => BOOM.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/video/logo/logo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index 080c35b..a26bb16 100644
--- a/drivers/video/logo/logo.c
+++ b/drivers/video/logo/logo.c
@@ -36,6 +36,9 @@ const struct linux_logo * __init_refok fb_find_logo(int depth)
 	if (nologo)
 		return NULL;
 
+	if (system_state != SYSTEM_BOOTING)
+		return NULL;
+
 	if (depth >= 1) {
 #ifdef CONFIG_LOGO_LINUX_MONO
 		/* Generic Linux logo */
-- 
1.8.4.3

