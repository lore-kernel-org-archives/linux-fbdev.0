From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] radeonfb: If no video memory, exit with error [repost]
Date: Tue, 26 Oct 2004 16:03:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200410261603.24434.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_smsfB+Zm1X4evqP"
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261505AbUJZWDt@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>, ajoshi@shell.unixbox.com, linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org

--Boundary-00=_smsfB+Zm1X4evqP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Posted this last week (10/21) but haven't seen any response.
Would you consider this for the next -mm?  Also attached in
case kmail mangles the whitespace.


[PATCH] radeonfb: If no video memory, exit with error

Nothing good will happen if we try to ioremap and use a zero-sized
frame buffer.  I observed this problem on an ia64 sx1000 box, where
the BIOS doesn't run the option ROM.  If we try to continue, radeonfb
just gets hopelessly confused because the card isn't initialized
correctly.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/video/aty/radeon_base.c 1.32 vs edited =====
--- 1.32/drivers/video/aty/radeon_base.c 2004-10-19 03:40:34 -06:00
+++ edited/drivers/video/aty/radeon_base.c 2004-10-21 11:50:51 -06:00
@@ -2186,7 +2186,9 @@
           rinfo->video_ram = 8192 * 1024;
           break;
          default:
-          break;
+   printk (KERN_ERR "radeonfb: no video RAM reported\n");
+   ret = -ENXIO;
+   goto err_unmap_rom;
   }
  }
 

--Boundary-00=_smsfB+Zm1X4evqP
Content-Type: text/x-diff;
  charset="us-ascii";
  name="radeonfb-no-vram.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="radeonfb-no-vram.patch"

[PATCH] radeonfb: If no video memory, exit with error

Nothing good will happen if we try to ioremap and use a zero-sized
frame buffer.  I observed this problem on an ia64 sx1000 box, where
the BIOS doesn't run the option ROM.  If we try to continue, radeonfb
just gets hopelessly confused because the card isn't initialized
correctly.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/video/aty/radeon_base.c 1.32 vs edited =====
--- 1.32/drivers/video/aty/radeon_base.c	2004-10-19 03:40:34 -06:00
+++ edited/drivers/video/aty/radeon_base.c	2004-10-21 11:50:51 -06:00
@@ -2186,7 +2186,9 @@
 	       		rinfo->video_ram = 8192 * 1024;
 	       		break;
 	       	default:
-	       		break;
+			printk (KERN_ERR "radeonfb: no video RAM reported\n");
+			ret = -ENXIO;
+			goto err_unmap_rom;
 		}
 	}
 

--Boundary-00=_smsfB+Zm1X4evqP--
