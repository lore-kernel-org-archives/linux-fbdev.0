From: Axel Lin <axel.lin@gmail.com>
Date: Sat, 29 Jan 2011 09:33:48 +0000
Subject: [PATCH 1/2] video: hpfb: use resource_size()
Message-Id: <1296293628.13797.2.camel@phoenix>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Phil Blundell <philb@gnu.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org

The size calculation is done incorrectly here because it should include
both the start and end (end - start + 1).

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/video/hpfb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/hpfb.c b/drivers/video/hpfb.c
index c8e280f..ebf8495 100644
--- a/drivers/video/hpfb.c
+++ b/drivers/video/hpfb.c
@@ -321,11 +321,11 @@ static int __devinit hpfb_dio_probe(struct dio_dev * d, const struct dio_device_
 	unsigned long paddr, vaddr;
 
 	paddr = d->resource.start;
-	if (!request_mem_region(d->resource.start, d->resource.end - d->resource.start, d->name))
+	if (!request_mem_region(d->resource.start, resource_size(&d->resource), d->name))
                 return -EBUSY;
 
 	if (d->scode >= DIOII_SCBASE) {
-		vaddr = (unsigned long)ioremap(paddr, d->resource.end - d->resource.start);
+		vaddr = (unsigned long)ioremap(paddr, resource_size(&d->resource));
 	} else {
 		vaddr = paddr + DIO_VIRADDRBASE;
 	}
@@ -344,7 +344,7 @@ static void __devexit hpfb_remove_one(struct dio_dev *d)
 	unregister_framebuffer(&fb_info);
 	if (d->scode >= DIOII_SCBASE)
 		iounmap((void *)fb_regs);
-        release_mem_region(d->resource.start, d->resource.end - d->resource.start);
+	release_mem_region(d->resource.start, resource_size(&d->resource));
 }
 
 static struct dio_device_id hpfb_dio_tbl[] = {
-- 
1.7.0.4



