From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Fri, 19 Nov 2010 21:58:44 +0000
Subject: [PATCH 2/9] sisfb: delete fallback code for pci_map_rom()
Message-Id: <1290203931-25188-3-git-send-email-aaro.koskinen@iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1290203931-25188-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1290203931-25188-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: thomas@winischhofer.net, aaro.koskinen@iki.fi

If pci_map_rom() fails, there is some fallback code that basically
duplicates pci_map_rom() on non-x86 platforms. No point in that.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
---
 drivers/video/sis/sis_main.c |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index 1073b70..7feb699 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -4147,23 +4147,6 @@ sisfb_find_rom(struct pci_dev *pdev)
 
         }
 
-#else
-
-	pci_read_config_dword(pdev, PCI_ROM_ADDRESS, &temp);
-	pci_write_config_dword(pdev, PCI_ROM_ADDRESS,
-			(ivideo->video_base & PCI_ROM_ADDRESS_MASK) | PCI_ROM_ADDRESS_ENABLE);
-
-	rom_base = ioremap(ivideo->video_base, 65536);
-	if(rom_base) {
-		if(sisfb_check_rom(rom_base, ivideo)) {
-			if((myrombase = vmalloc(65536)))
-				memcpy_fromio(myrombase, rom_base, 65536);
-		}
-		iounmap(rom_base);
-	}
-
-	pci_write_config_dword(pdev, PCI_ROM_ADDRESS, temp);
-
 #endif
 
 	return myrombase;
-- 
1.5.6.5

