From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 06 Jan 2015 13:24:10 +0000
Subject: [PATCH] fbdev: savage: remove unused variable
Message-Id: <1420549930-16607-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

vga_in8() was storing the return value in tmp, but that return value
was never used again. so it should be safe to remove those variables.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

just one doubt:
vga_in8() is calling savage_in8() which is a readb().
so in effect we are reading one byte from
(par->mmio.vbase + 0x8000 + 0x3da) and then discarding that value.
so if we are discarding that value then why we are reading it?

 drivers/video/fbdev/savage/savagefb.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/savage/savagefb.h b/drivers/video/fbdev/savage/savagefb.h
index dcaab90..8ff4ab1 100644
--- a/drivers/video/fbdev/savage/savagefb.h
+++ b/drivers/video/fbdev/savage/savagefb.h
@@ -351,32 +351,26 @@ static inline void VGAwSEQ(u8 index, u8 val, struct savagefb_par *par)
 
 static inline void VGAenablePalette(struct savagefb_par *par)
 {
-	u8 tmp;
-
-	tmp = vga_in8(0x3da, par);
+	vga_in8(0x3da, par);
 	vga_out8(0x3c0, 0x00, par);
 	par->paletteEnabled = 1;
 }
 
 static inline void VGAdisablePalette(struct savagefb_par *par)
 {
-	u8 tmp;
-
-	tmp = vga_in8(0x3da, par);
+	vga_in8(0x3da, par);
 	vga_out8(0x3c0, 0x20, par);
 	par->paletteEnabled = 0;
 }
 
 static inline void VGAwATTR(u8 index, u8 value, struct savagefb_par *par)
 {
-	u8 tmp;
-
 	if (par->paletteEnabled)
 		index &= ~0x20;
 	else
 		index |= 0x20;
 
-	tmp = vga_in8(0x3da, par);
+	vga_in8(0x3da, par);
 	vga_out8(0x3c0, index, par);
 	vga_out8 (0x3c0, value, par);
 }
-- 
1.8.1.2

