From: Pawel Osciak <p.osciak@samsung.com>
Subject: [PATCH 2/4] [ARM] s3c-fb: Include fixes
Date: Thu, 09 Jul 2009 17:08:57 +0200
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC076E71C7EC@bssrvexch01.BS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-language: en-US
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>
Cc: "adaplas@gmail.com" <adaplas@gmail.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Pawel Osciak <p.osciak@samsung.com>

Corrected defines for FRAMESEL1 framebuffer register.


Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Pawel Osciak <p.osciak@samsung.com>



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


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
