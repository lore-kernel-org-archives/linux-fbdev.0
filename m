From: Sedat Dilek <sedat.dilek@googlemail.com>
Date: Mon, 03 Jan 2011 01:31:29 +0000
Subject: [PATCH] gx1fb: Fix section mismatch derived from gx1fb_driver variable
Message-Id: <1294018289-3911-1-git-send-email-sedat.dilek@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sedat Dilek <sedat.dilek@gmail.com>

From my build.log:

WARNING: drivers/video/geode/gx1fb.o(.data+0x54): Section mismatch in reference from the variable gx1fb_driver to the function .init.text:gx1fb_probe()
The variable gx1fb_driver references
the function __init gx1fb_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

This patch fixes the warning.

Tested with linux-next (next-20101231)

Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 drivers/video/geode/gx1fb_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/geode/gx1fb_core.c b/drivers/video/geode/gx1fb_core.c
index c6b554f..9fdb115 100644
--- a/drivers/video/geode/gx1fb_core.c
+++ b/drivers/video/geode/gx1fb_core.c
@@ -437,7 +437,7 @@ static struct pci_device_id gx1fb_id_table[] = {
 
 MODULE_DEVICE_TABLE(pci, gx1fb_id_table);
 
-static struct pci_driver gx1fb_driver = {
+static struct pci_driver gx1fb_driver __refdata = {
 	.name		= "gx1fb",
 	.id_table	= gx1fb_id_table,
 	.probe		= gx1fb_probe,
-- 
1.7.4.rc0

