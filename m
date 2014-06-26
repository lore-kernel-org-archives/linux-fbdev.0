From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Jun 2014 11:29:59 +0000
Subject: [PATCH] fbdev: arm has __raw I/O accessors, use them in fb.h
Message-Id: <1403782199-7998-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Archit Taneja <archit@ti.com>

This removes the sparse warnings on arm platforms:

warning: cast removes address space of expression

Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Russell King <linux@arm.linux.org.uk>
---

This patch was sent a few years ago, but was not applied:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/132387.html

Russell asked if it has any effect on BE ARM platforms. I don't have any BE
systems but I did some study:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/132900.html

Anyone with a BE platform could test this?

 include/linux/fb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index b6bfda99add3..09bb7a18d287 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -553,7 +553,7 @@ static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
 #define fb_memcpy_fromfb sbus_memcpy_fromio
 #define fb_memcpy_tofb sbus_memcpy_toio
 
-#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) || defined(__hppa__) || defined(__sh__) || defined(__powerpc__) || defined(__avr32__) || defined(__bfin__)
+#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) || defined(__hppa__) || defined(__sh__) || defined(__powerpc__) || defined(__avr32__) || defined(__bfin__) || defined(__arm__)
 
 #define fb_readb __raw_readb
 #define fb_readw __raw_readw
-- 
1.9.1

