From: Saidgani Musaev <cpu808694@gmail.com>
Date: Sat, 25 Jun 2016 08:59:11 +0000
Subject: [PATCH] Drivers: video: vgastate: fixed a coding style issue
Message-Id: <1466845151-5764-1-git-send-email-cpu808694@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Saidgani <cpu808694@gmail.com>

From: Saidgani <cpu808694@gmail.com>

fixed a coding style issue
---
 drivers/video/vgastate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/vgastate.c b/drivers/video/vgastate.c
index 548c751..eb70e5d 100644
--- a/drivers/video/vgastate.c
+++ b/drivers/video/vgastate.c
@@ -31,7 +31,8 @@ struct regstate {
 	__u8 misc;
 };
 
-static inline unsigned char vga_rcrtcs(void __iomem *regbase, unsigned short iobase,
+static inline unsigned char vga_rcrtcs(void __iomem *regbase,
+				       unsigned short iobase,
 				       unsigned char reg)
 {
 	vga_w(regbase, iobase + 0x4, reg);
@@ -454,8 +455,9 @@ int save_vga(struct vgastate *state)
 	}
 	return 0;
 }
+EXPORT_SYMBOL(save_vga);
 
-int restore_vga (struct vgastate *state)
+int restore_vga(struct vgastate *state)
 {
 	if (state->vidstate = NULL)
 		return 1;
@@ -480,8 +482,6 @@ int restore_vga (struct vgastate *state)
 	vga_cleanup(state);
 	return 0;
 }
-
-EXPORT_SYMBOL(save_vga);
 EXPORT_SYMBOL(restore_vga);
 
 MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
-- 
1.9.1

