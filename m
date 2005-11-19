From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] include/video/newport.h: "extern inline" -> "static inline"
Date: Sat, 19 Nov 2005 09:08:46 +0100
Message-ID: <20051119080846.GG16060@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750807AbVKSUdT@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/video/newport.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc1-mm2-full/include/video/newport.h.old	2005-11-19 02:34:35.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/include/video/newport.h	2005-11-19 02:35:42.000000000 +0100
@@ -382,7 +382,8 @@
 #define VC2_IREG_CONTROL       0x10
 #define VC2_IREG_CONFIG        0x20
 
-extern __inline__ void newport_vc2_set(struct newport_regs *regs, unsigned char vc2ireg,
+static inline void newport_vc2_set(struct newport_regs *regs,
+				   unsigned char vc2ireg,
 				   unsigned short val)
 {
 	regs->set.dcbmode = (NPORT_DMODE_AVC2 | VC2_REGADDR_INDEX | NPORT_DMODE_W3 |
@@ -390,7 +391,7 @@
 	regs->set.dcbdata0.byword = (vc2ireg << 24) | (val << 8);
 }
 
-extern __inline__ unsigned short newport_vc2_get(struct newport_regs *regs,
+static inline unsigned short newport_vc2_get(struct newport_regs *regs,
 					     unsigned char vc2ireg)
 {
 	regs->set.dcbmode = (NPORT_DMODE_AVC2 | VC2_REGADDR_INDEX | NPORT_DMODE_W1 |
