From: Lars Svensson <lars1.svensson@sonymobile.com>
Date: Wed, 07 Oct 2015 07:20:14 +0000
Subject: [PATCH v3 3/3] staging: fbtft: access screen buffer directly
Message-Id: <1444202414-21271-3-git-send-email-lars1.svensson@sonymobile.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444202414-21271-1-git-send-email-lars1.svensson@sonymobile.com>
In-Reply-To: <1444202414-21271-1-git-send-email-lars1.svensson@sonymobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: thomas.petazzoni@free-electrons.com, noralf@tronnes.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com, Lars Svensson <lars1.svensson@sonymobile.com>

In fbtft-bus.c:fbtft_write_vmem16_bus9(), ioread8() is used for
accessing the provided screen array. Since screen_buffer actually
points to an ordinary buffer, instead access it directly.

Signed-off-by: Lars Svensson <lars1.svensson@sonymobile.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index f5a36a4..04efe90 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -184,7 +184,7 @@ EXPORT_SYMBOL(fbtft_write_vmem16_bus8);
 /* 16 bit pixel over 9-bit SPI bus: dc + high byte, dc + low byte */
 int fbtft_write_vmem16_bus9(struct fbtft_par *par, size_t offset, size_t len)
 {
-	u8 __iomem *vmem8;
+	u8 *vmem8;
 	u16 *txbuf16 = par->txbuf.buf;
 	size_t remain;
 	size_t to_copy;
@@ -212,12 +212,12 @@ int fbtft_write_vmem16_bus9(struct fbtft_par *par, size_t offset, size_t len)
 
 #ifdef __LITTLE_ENDIAN
 		for (i = 0; i < to_copy; i += 2) {
-			txbuf16[i]     = 0x0100 | ioread8(vmem8 + i + 1);
-			txbuf16[i + 1] = 0x0100 | ioread8(vmem8 + i);
+			txbuf16[i]     = 0x0100 | vmem8[i + 1];
+			txbuf16[i + 1] = 0x0100 | vmem8[i];
 		}
 #else
 		for (i = 0; i < to_copy; i++)
-			txbuf16[i]   = 0x0100 | ioread8(vmem8 + i);
+			txbuf16[i]   = 0x0100 | vmem8[i];
 #endif
 		vmem8 = vmem8 + to_copy;
 		ret = par->fbtftops.write(par, par->txbuf.buf, to_copy*2);
-- 
2.4.2

