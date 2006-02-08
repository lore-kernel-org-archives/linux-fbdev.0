From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/2] nvidiafb: Add support for Geforce4 MX 4000
Date: Wed, 08 Feb 2006 09:01:15 +0800
Message-ID: <43E942DB.1090401@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F6div-0007FM-17
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Feb 2006 17:02:21 -0800
Received: from pproxy.gmail.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1F6diu-0004wR-LJ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Feb 2006 17:02:21 -0800
Received: by pproxy.gmail.com with SMTP id z59so745612pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Feb 2006 17:02:16 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Add support for Geforce4 MX 4000 (0x185)

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/nvidia/nvidia.c |    2 ++
 include/linux/pci_ids.h       |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index dbcb896..a7c4e5e 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -138,6 +138,8 @@ static struct pci_device_id nvidiafb_pci
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_420_8X,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_4000,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_448_GO,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_488_GO,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 8a2eca6..20d3b5b 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1088,6 +1088,7 @@
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_440_8X 0x0181
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_440SE_8X 0x0182
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_420_8X 0x0183
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_4000   0x0185
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE4_448_GO    0x0186
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE4_488_GO    0x0187
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_580_XGL    0x0188




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
