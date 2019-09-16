From: Denis Efremov <efremov@linux.com>
Date: Mon, 16 Sep 2019 20:41:47 +0000
Subject: [PATCH v3 15/26] efifb: Loop using PCI_STD_NUM_BARS
Message-Id: <20190916204158.6889-16-efremov@linux.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190916204158.6889-1-efremov@linux.com>
In-Reply-To: <20190916204158.6889-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Peter Jones <pjones@redhat.com>

Refactor loops to use idiomatic C style and avoid the fencepost error
of using "i < PCI_STD_RESOURCE_END" when "i <= PCI_STD_RESOURCE_END"
is required, e.g., commit 2f686f1d9bee ("PCI: Correct PCI_STD_RESOURCE_END
usage").

To iterate through all possible BARs, loop conditions changed to the
*number* of BARs "i < PCI_STD_NUM_BARS", instead of the index of the last
valid BAR "i <= PCI_STD_RESOURCE_END".

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Peter Jones <pjones@redhat.com>
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
