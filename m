From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] nvidiafb: Fix error path
Date: Sun, 11 Dec 2005 15:13:30 +0800
Message-ID: <439BD19A.1020109@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ElLS6-00075g-Hs
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Dec 2005 23:16:58 -0800
Received: from zproxy.gmail.com ([64.233.162.203])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ElLS4-00032Z-Ou
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Dec 2005 23:16:58 -0800
Received: by zproxy.gmail.com with SMTP id 40so1219747nzk
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 10 Dec 2005 23:16:56 -0800 (PST)
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

- The recent changes that involved code reordering invalidated the
  error pathway.  Fix.
- Whitespace changes

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/nvidia/nvidia.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index b350cd7..be61467 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1568,15 +1568,6 @@ static int __devinit nvidiafb_probe(stru
 		goto err_out_request;
 	}
 
-	printk(KERN_INFO PFX "nVidia device/chipset %X\n", par->Chipset);
-
-	if (par->Architecture == 0) {
-		printk(KERN_ERR PFX "unknown NV_ARCH\n");
-		goto err_out_free_base0;
-	}
-
-	sprintf(nvidiafb_fix.id, "NV%x", (pd->device & 0x0ff0) >> 4);
-
 	par->FlatPanel = flatpanel;
 	if (flatpanel == 1)
 		printk(KERN_INFO PFX "flatpanel support enabled\n");
@@ -1603,7 +1594,16 @@ static int __devinit nvidiafb_probe(stru
 	}
 
 	par->Chipset = nvidia_get_chipset(info);
+	printk(KERN_INFO PFX "nVidia device/chipset %X\n", par->Chipset);
 	par->Architecture = nvidia_get_arch(info);
+
+	if (par->Architecture == 0) {
+		printk(KERN_ERR PFX "unknown NV_ARCH\n");
+		goto err_out_arch;
+	}
+
+	sprintf(nvidiafb_fix.id, "NV%x", (pd->device & 0x0ff0) >> 4);
+
 	NVCommonSetup(info);
 
 	par->FbAddress = nvidiafb_fix.smem_start;
@@ -1679,21 +1679,22 @@ static int __devinit nvidiafb_probe(stru
 	NVTRACE_LEAVE();
 	return 0;
 
-      err_out_iounmap_fb:
+err_out_iounmap_fb:
 	iounmap(info->screen_base);
-      err_out_free_base1:
+err_out_free_base1:
 	fb_destroy_modedb(info->monspecs.modedb);
 	nvidia_delete_i2c_busses(par);
+err_out_arch:
 	iounmap(par->REGS);
-      err_out_free_base0:
+err_out_free_base0:
 	pci_release_regions(pd);
-      err_out_request:
+err_out_request:
 	pci_disable_device(pd);
-      err_out_enable:
+err_out_enable:
 	kfree(info->pixmap.addr);
-      err_out_kfree:
+err_out_kfree:
 	framebuffer_release(info);
-      err_out:
+err_out:
 	return -ENODEV;
 }
 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
