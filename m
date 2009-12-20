From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 20 Dec 2009 17:16:45 +0000
Subject: [PATCH 1/5] viafb: deprecate private ioctls
Message-Id: <1261329409-3518-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

viafb: deprecate private ioctls

This patch prints a warning when viafb ioctls are called. Those
should not be used as their exact meaning is sometimes unknown and
they in parts duplicate functionality present in the framebuffer
interface.
There is no known user of these ioctls.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/viafbdev.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index d8df17a..ce07b5e 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -477,6 +477,7 @@ static int viafb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 	u32 gpu32;
 
 	DEBUG_MSG(KERN_INFO "viafb_ioctl: 0x%X !!\n", cmd);
+	printk(KERN_WARNING "viafb_ioctl: Please avoid this interface as it is unstable and might change or vanish at any time!\n");
 	memset(&u, 0, sizeof(u));
 
 	switch (cmd) {
-- 
1.6.3.2

