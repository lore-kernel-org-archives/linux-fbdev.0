From: Ji Zhang <ji.zhang@mediatek.com>
Date: Thu, 30 Nov 2017 08:17:22 +0000
Subject: [PATCH] fbdev: arm64 use __raw I/O memory api
Message-Id: <1512029842-10939-1-git-send-email-ji.zhang@mediatek.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com, Ji Zhang <ji.zhang@mediatek.com>, shadanji@163.com

Since arm64 also has __raw I/O accessors, add __aarch64__ in fb.h.
This is a supplement for commmit
981409b25e2a99409b26daa67293ca1cfd5ea0a0

Signed-off-by: Ji Zhang <ji.zhang@mediatek.com>
---
 include/linux/fb.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index bc24e48..cea8a2c 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -564,7 +564,10 @@ static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
 #define fb_memcpy_fromfb sbus_memcpy_fromio
 #define fb_memcpy_tofb sbus_memcpy_toio
 
-#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) || defined(__hppa__) || defined(__sh__) || defined(__powerpc__) || defined(__avr32__) || defined(__bfin__) || defined(__arm__)
+#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) ||	\
+	defined(__hppa__) || defined(__sh__) || defined(__powerpc__) ||	\
+	defined(__avr32__) || defined(__bfin__) || defined(__arm__) ||	\
+	defined(__aarch64__)
 
 #define fb_readb __raw_readb
 #define fb_readw __raw_readw
-- 
1.9.1

