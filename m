From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 02 Dec 2013 23:28:33 +0000
Subject: [PATCH 32/39] video: remove DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <003501ceefb6$37ba5dd0$a72f1970$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <001501ceefb1$69c96820$3d5c3860$%han@samsung.com>
In-Reply-To: <001501ceefb1$69c96820$3d5c3860$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

Don't use DEFINE_PCI_DEVICE_TABLE macro, because this macro
is not preferred.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/hyperv_fb.c |    2 +-
 drivers/video/i740fb.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/hyperv_fb.c b/drivers/video/hyperv_fb.c
index 130708f..8254ed7 100644
--- a/drivers/video/hyperv_fb.c
+++ b/drivers/video/hyperv_fb.c
@@ -800,7 +800,7 @@ static int hvfb_remove(struct hv_device *hdev)
 }
 
 
-static DEFINE_PCI_DEVICE_TABLE(pci_stub_id_table) = {
+static const struct pci_device_id pci_stub_id_table[] = {
 	{
 		.vendor      = PCI_VENDOR_ID_MICROSOFT,
 		.device      = PCI_DEVICE_ID_HYPERV_VIDEO,
diff --git a/drivers/video/i740fb.c b/drivers/video/i740fb.c
index ca7c9df..a2b4204 100644
--- a/drivers/video/i740fb.c
+++ b/drivers/video/i740fb.c
@@ -1260,7 +1260,7 @@ fail:
 #define I740_ID_PCI 0x00d1
 #define I740_ID_AGP 0x7800
 
-static DEFINE_PCI_DEVICE_TABLE(i740fb_id_table) = {
+static const struct pci_device_id i740fb_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, I740_ID_PCI) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, I740_ID_AGP) },
 	{ 0 }
-- 
1.7.10.4


