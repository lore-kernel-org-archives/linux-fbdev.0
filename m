From: H Hartley Sweeten <hartleys@visionengravers.com>
Date: Sat, 11 Jun 2011 00:31:08 +0000
Subject: [PATCH] fb.h: ARM uses __raw_{read/write}
Message-Id: <201106101731.08578.hartleys@visionengravers.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

ARM provides __raw_{read/write}* functions for memory access. These
should be used instead of the default '(*(volatile' stuff to make sure the
memory accesses are typesafe (void __iomem *).

This also fixes a number of sparse warning like:

  warning: cast removes address space of expression

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Russell King <linux@arm.linux.org.uk>

---

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 6a82748..a040e92e 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -937,7 +937,7 @@ static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
 #define fb_memcpy_fromfb sbus_memcpy_fromio
 #define fb_memcpy_tofb sbus_memcpy_toio
 
-#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) || defined(__hppa__) || defined(__sh__) || defined(__powerpc__) || defined(__avr32__) || defined(__bfin__)
+#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) || defined(__hppa__) || defined(__sh__) || defined(__powerpc__) || defined(__avr32__) || defined(__bfin__) || defined(__arm__)
 
 #define fb_readb __raw_readb
 #define fb_readw __raw_readw
