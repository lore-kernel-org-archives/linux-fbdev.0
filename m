From: Pawel Osciak <p.osciak@samsung.com>
Subject: [PATCH v2 1/3] [ARM] s3c-fb: Corrected defines for framesel1 register.
Date: Thu, 03 Sep 2009 14:44:44 +0200
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC0770658049@bssrvexch01.BS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-language: en-US
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>
Cc: Pawel Osciak <p.osciak@samsung.com>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "adaplas@gmail.com" <adaplas@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>


Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Pawel Osciak <p.osciak@samsung.com>

---
 arch/arm/plat-s3c/include/plat/regs-fb.h |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-s3c/include/plat/regs-fb.h b/arch/arm/plat-s3c/include/plat/regs-fb.h
index e9ee599..8048cae 100644
--- a/arch/arm/plat-s3c/include/plat/regs-fb.h
+++ b/arch/arm/plat-s3c/include/plat/regs-fb.h
@@ -291,11 +291,12 @@
 #define VIDINTCON0_FRAMESEL0_ACTIVE		(0x2 << 15)
 #define VIDINTCON0_FRAMESEL0_FRONTPORCH		(0x3 << 15)
 
-#define VIDINTCON0_FRAMESEL1			(1 << 14)
-#define VIDINTCON0_FRAMESEL1_NONE		(0x0 << 14)
-#define VIDINTCON0_FRAMESEL1_BACKPORCH		(0x1 << 14)
-#define VIDINTCON0_FRAMESEL1_VSYNC		(0x2 << 14)
-#define VIDINTCON0_FRAMESEL1_FRONTPORCH		(0x3 << 14)
+#define VIDINTCON0_FRAMESEL1_MASK		(0x3 << 13)
+#define VIDINTCON0_FRAMESEL1_SHIFT		(13)
+#define VIDINTCON0_FRAMESEL1_NONE		(0x0 << 13)
+#define VIDINTCON0_FRAMESEL1_BACKPORCH		(0x1 << 13)
+#define VIDINTCON0_FRAMESEL1_VSYNC		(0x2 << 13)
+#define VIDINTCON0_FRAMESEL1_FRONTPORCH		(0x3 << 13)
 
 #define VIDINTCON0_INT_FRAME			(1 << 12)
 #define VIDINTCON0_FIFIOSEL_MASK		(0x7f << 5)
-- 
1.6.4.2.253.g0b1fac
