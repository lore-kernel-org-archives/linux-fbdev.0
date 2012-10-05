From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 05 Oct 2012 14:55:26 +0000
Subject: [PATCH 12/16] video: mark nuc900fb_map_video_memory as __devinit
Message-Id: <1349448930-23976-13-git-send-email-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1349448930-23976-1-git-send-email-arnd@arndb.de>
In-Reply-To: <1349448930-23976-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

nuc900fb_map_video_memory is called by an devinit function
that may be called at run-time, but the function itself is
marked __init and will be discarded after boot.

To avoid calling into a function that may have been overwritten,
mark nuc900fb_map_video_memory itself as __devinit.

Without this patch, building nuc950_defconfig results in:

WARNING: drivers/video/built-in.o(.devinit.text+0x26c): Section mismatch in reference from the function nuc900fb_probe() to the function .init.text:nuc900fb_map_video_memory()
The function __devinit nuc900fb_probe() references
a function __init nuc900fb_map_video_memory().
If nuc900fb_map_video_memory is only used by nuc900fb_probe then
annotate nuc900fb_map_video_memory with a matching annotation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Wan ZongShun <mcuos.com@gmail.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/nuc900fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/nuc900fb.c b/drivers/video/nuc900fb.c
index e10f551..b31b12b 100644
--- a/drivers/video/nuc900fb.c
+++ b/drivers/video/nuc900fb.c
@@ -387,7 +387,7 @@ static int nuc900fb_init_registers(struct fb_info *info)
  *    The buffer should be a non-cached, non-buffered, memory region
  *    to allow palette and pixel writes without flushing the cache.
  */
-static int __init nuc900fb_map_video_memory(struct fb_info *info)
+static int __devinit nuc900fb_map_video_memory(struct fb_info *info)
 {
 	struct nuc900fb_info *fbi = info->par;
 	dma_addr_t map_dma;
-- 
1.7.10

