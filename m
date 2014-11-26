From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 26 Nov 2014 22:07:24 +0000
Subject: [PATCH 2/3] video: fbdev: s3fb: suppress build warning
Message-Id: <1417039645-5313-2-git-send-email-prabhakar.csengg@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417039645-5313-1-git-send-email-prabhakar.csengg@gmail.com>
In-Reply-To: <1417039645-5313-1-git-send-email-prabhakar.csengg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

this patch fixes following build warning:
drivers/video/fbdev/s3fb.c: In function ‘s3_pci_probe’:
drivers/video/fbdev/s3fb.c:1185:23: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  par->state.vgabase = (void __iomem *) vga_res.start;
                       ^
Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 drivers/video/fbdev/s3fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
index c43b969..f0ae61a 100644
--- a/drivers/video/fbdev/s3fb.c
+++ b/drivers/video/fbdev/s3fb.c
@@ -1182,7 +1182,7 @@ static int s3_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	pcibios_bus_to_resource(dev->bus, &vga_res, &bus_reg);
 
-	par->state.vgabase = (void __iomem *) vga_res.start;
+	par->state.vgabase = (void __iomem *) (unsigned long) vga_res.start;
 
 	/* Unlock regs */
 	cr38 = vga_rcrt(par->state.vgabase, 0x38);
-- 
1.9.1

