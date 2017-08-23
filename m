From: Himanshu Jha <himanshujha199640@gmail.com>
Date: Wed, 23 Aug 2017 17:42:40 +0000
Subject: [PATCH v2] fbdev: vgastate: fix line over 80 character and remove unnecessary space
Message-Id: <1503509440-17279-1-git-send-email-himanshujha199640@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Himanshu Jha <himanshujha199640@gmail.com>

Fixes the following checkpatch warnings:

WARNING: line over 80 characters
WARNING: space prohibited between function name and open parenthesis '('
WARNING: EXPORT_SYMBOL(foo); should immediately follow its
function/variable

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/video/vgastate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/vgastate.c b/drivers/video/vgastate.c
index 548c751..b17d8e0 100644
--- a/drivers/video/vgastate.c
+++ b/drivers/video/vgastate.c
@@ -31,8 +31,9 @@ struct regstate {
 	__u8 misc;
 };
 
-static inline unsigned char vga_rcrtcs(void __iomem *regbase, unsigned short iobase,
-				       unsigned char reg)
+static inline unsigned char vga_rcrtcs(void __iomem *regbase,
+					unsigned short iobase,
+					unsigned char reg)
 {
 	vga_w(regbase, iobase + 0x4, reg);
 	return vga_r(regbase, iobase + 0x5);
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
2.7.4

