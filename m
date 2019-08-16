From: Denis Efremov <efremov@linux.com>
Date: Fri, 16 Aug 2019 09:24:34 +0000
Subject: [PATCH v2 07/10] efifb: Loop using PCI_STD_NUM_BARS
Message-Id: <20190816092437.31846-8-efremov@linux.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190816092437.31846-1-efremov@linux.com>
In-Reply-To: <20190816092437.31846-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Denis Efremov <efremov@linux.com>, Peter Jones <pjones@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

Refactor loops to use 'i < PCI_STD_NUM_BARS' instead of
'i <= PCI_STD_RESOURCE_END'.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
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
