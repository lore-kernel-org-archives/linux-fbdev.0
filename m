From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sun, 14 Sep 2014 17:35:48 +0000
Subject: [PATCH] video: fbdev: sis: sis_main.c:  Cleaning up missing null-terminate in conjunction with strnc
Message-Id: <1410716148-16243-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Winischhofer <thomas@winischhofer.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Replacing strncpy with strlcpy to avoid strings that lacks null terminate.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/sis/sis_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index 3f12a2d..1f4c216 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -5830,7 +5830,7 @@ static int sisfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			ivideo->cardnumber++;
 	}
 
-	strncpy(ivideo->myid, chipinfo->chip_name, 30);
+	strlcpy(ivideo->myid, chipinfo->chip_name, sizeof(ivideo->myid));
 
 	ivideo->warncount = 0;
 	ivideo->chip_id = pdev->device;
-- 
1.7.10.4

