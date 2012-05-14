From: tartler@cs.fau.de
Date: Mon, 14 May 2012 16:31:51 +0000
Subject: [PATCH] mbxfb: unbreak compilation with CONFIG_FB_MBX_DEBUG
Message-Id: <1337013111-7732-1-git-send-email-tartler@cs.fau.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Eric Miao <eric.y.miao@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: vamos-dev@lists.cs.fau.de, Reinhard Tartler <siretart@tauware.de>, Reinhard Tartler <tartler@cs.fau.de>

From: Reinhard Tartler <siretart@tauware.de>

This patch adds missing function prototypes.

Signed-off-by: Reinhard Tartler <tartler@cs.fau.de>
---
 drivers/video/mbx/mbxfb.c |    3 +++
 1 file changed, 3 insertions(+)

This patch was found with tools developed in the VAMOS project:
http://www4.cs.fau.de/Research/VAMOS/

TBH, I'm not sure if this is the correct solution. However, I'd
appreciate if someone could confirm that this is a real bug.


diff --git a/drivers/video/mbx/mbxfb.c b/drivers/video/mbx/mbxfb.c
index 6ce3416..c2200ec 100644
--- a/drivers/video/mbx/mbxfb.c
+++ b/drivers/video/mbx/mbxfb.c
@@ -878,6 +878,9 @@ static int mbxfb_resume(struct platform_device *dev)
 #ifndef CONFIG_FB_MBX_DEBUG
 #define mbxfb_debugfs_init(x)	do {} while(0)
 #define mbxfb_debugfs_remove(x)	do {} while(0)
+#else
+void mbxfb_debugfs_init(struct fb_info *fbi);
+void mbxfb_debugfs_remove(struct fb_info *fbi);
 #endif
 
 #define res_size(_r) (((_r)->end - (_r)->start) + 1)
-- 
1.7.9.5

