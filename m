From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Fri, 19 Nov 2010 21:58:43 +0000
Subject: [PATCH 1/9] sisfb: delete obsolete PCI ROM bug workaround
Message-Id: <1290203931-25188-2-git-send-email-aaro.koskinen@iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1290203931-25188-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1290203931-25188-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: thomas@winischhofer.net, aaro.koskinen@iki.fi

Delete a workaround for a PCI ROM bug that has been fixed ages ago by
the commit 761a3ac08c63718dacde12aaf0ec6d6760e8c2b7.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
---
 drivers/video/sis/sis_main.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index 3dde12b..1073b70 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -4114,14 +4114,6 @@ sisfb_find_rom(struct pci_dev *pdev)
 			if(sisfb_check_rom(rom_base, ivideo)) {
 
 				if((myrombase = vmalloc(65536))) {
-
-					/* Work around bug in pci/rom.c: Folks forgot to check
-					 * whether the size retrieved from the BIOS image eventually
-					 * is larger than the mapped size
-					 */
-					if(pci_resource_len(pdev, PCI_ROM_RESOURCE) < romsize)
-						romsize = pci_resource_len(pdev, PCI_ROM_RESOURCE);
-
 					memcpy_fromio(myrombase, rom_base,
 							(romsize > 65536) ? 65536 : romsize);
 				}
-- 
1.5.6.5

