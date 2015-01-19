From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 19 Jan 2015 08:23:06 +0000
Subject: [PATCH v2 7/7] staging: sm7xxfb: fix alignment
Message-Id: <1421655067-7490-7-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421655067-7490-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1421655067-7490-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org

checkpatch cleanup: alignment should match open parenthesis

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/sm7xxfb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 097747c..2ae9fd0 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -509,7 +509,7 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 				    (i + 0x30) != 0x6a &&
 				    (i + 0x30) != 0x6b)
 					smtc_seqw(i + 0x30,
-						VGAMode[j].Init_SR30_SR75[i]);
+						  VGAMode[j].Init_SR30_SR75[i]);
 
 			/* init SEQ register SR80 - SR93 */
 			for (i = 0; i < SIZE_SR80_SR93; i++)
@@ -720,7 +720,7 @@ static void smtc_unmap_mmio(struct smtcfb_info *sfb)
  */
 
 static int smtc_map_smem(struct smtcfb_info *sfb,
-		struct pci_dev *pdev, u_long smem_len)
+			 struct pci_dev *pdev, u_long smem_len)
 {
 	sfb->fb.fix.smem_start = pci_resource_start(pdev, 0);
 
@@ -764,7 +764,7 @@ static inline void sm7xx_init_hw(void)
 }
 
 static int smtcfb_pci_probe(struct pci_dev *pdev,
-				   const struct pci_device_id *ent)
+			    const struct pci_device_id *ent)
 {
 	struct smtcfb_info *sfb;
 	u_long smem_size = 0x00800000;	/* default 8MB */
-- 
1.8.1.2

