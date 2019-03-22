From: Yifeng Li <tomli@tomli.me>
Date: Fri, 22 Mar 2019 05:17:53 +0000
Subject: [PATCH v2 1/7] fbdev: sm712fb: use type "u8" for 8-bit I/O.
Message-Id: <20190322051759.15007-2-tomli@tomli.me>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190322051759.15007-1-tomli@tomli.me>
In-Reply-To: <20190322051759.15007-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Yifeng Li <tomli@tomli.me>

This commit converts "unsigned int" and "int" in I/O wrappers
to "u8". It improves readability since it's consistent with
the prototypes of readb() and writeb(). More importantly, it
reduces readers' confusion, since the upcoming 2D acceleration
code will use a different wordsize.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 drivers/video/fbdev/sm712.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/sm712.h b/drivers/video/fbdev/sm712.h
index bb144f038267..89e446db2ac7 100644
--- a/drivers/video/fbdev/sm712.h
+++ b/drivers/video/fbdev/sm712.h
@@ -59,19 +59,19 @@ extern void __iomem *smtc_regbaseaddress;
 #define SIZE_CR30_CR4D      (0x4D - 0x30 + 1)
 #define SIZE_CR90_CRA7      (0xA7 - 0x90 + 1)
 
-static inline void smtc_crtcw(int reg, int val)
+static inline void smtc_crtcw(u8 reg, u8 val)
 {
 	smtc_mmiowb(reg, 0x3d4);
 	smtc_mmiowb(val, 0x3d5);
 }
 
-static inline void smtc_grphw(int reg, int val)
+static inline void smtc_grphw(u8 reg, u8 val)
 {
 	smtc_mmiowb(reg, 0x3ce);
 	smtc_mmiowb(val, 0x3cf);
 }
 
-static inline void smtc_attrw(int reg, int val)
+static inline void smtc_attrw(u8 reg, u8 val)
 {
 	smtc_mmiorb(0x3da);
 	smtc_mmiowb(reg, 0x3c0);
@@ -79,13 +79,13 @@ static inline void smtc_attrw(int reg, int val)
 	smtc_mmiowb(val, 0x3c0);
 }
 
-static inline void smtc_seqw(int reg, int val)
+static inline void smtc_seqw(u8 reg, u8 val)
 {
 	smtc_mmiowb(reg, 0x3c4);
 	smtc_mmiowb(val, 0x3c5);
 }
 
-static inline unsigned int smtc_seqr(int reg)
+static inline u8 smtc_seqr(u8 reg)
 {
 	smtc_mmiowb(reg, 0x3c4);
 	return smtc_mmiorb(0x3c5);
-- 
2.20.1
