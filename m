From: Denis Efremov <efremov@linux.com>
Date: Sun, 11 Aug 2019 15:08:02 +0000
Subject: [PATCH 6/7] efifb: Use PCI_STD_NUM_BARS in loops instead of PCI_STD_RESOURCE_END
Message-Id: <20190811150802.2418-7-efremov@linux.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190811150802.2418-1-efremov@linux.com>
In-Reply-To: <20190811150802.2418-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Denis Efremov <efremov@linux.com>, Peter Jones <pjones@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

This patch refactors the loop condition scheme from
'i <= PCI_STD_RESOURCE_END' to 'i < PCI_STD_NUM_BARS'.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/video/fbdev/efifb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 04a22663b4fb..6c72b825e92a 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -668,7 +668,7 @@ static void efifb_fixup_resources(struct pci_dev *dev)
 	if (!base)
 		return;
 
-	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		struct resource *res = &dev->resource[i];
 
 		if (!(res->flags & IORESOURCE_MEM))
-- 
2.21.0
