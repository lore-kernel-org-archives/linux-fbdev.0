From: Ondrej Zary <linux@rainbow-software.org>
Date: Sun, 20 Feb 2011 18:37:15 +0000
Subject: [PATCH] s3fb: maximize virtual vertical size for fast scrolling
Message-Id: <201102201937.19112.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zajicek <santiago@crfreenet.org>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>

Maximize virtual vertical framebuffer size during init to allow fast scrolling 
(accelerated by panning).

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-2.6.38-rc4-/drivers/video/s3fb.c	2011-02-20 19:11:28.000000000 +0100
+++ linux-2.6.38-rc4/drivers/video/s3fb.c	2011-02-20 19:17:04.000000000 +0100
@@ -1060,6 +1060,14 @@ static int __devinit s3_pci_probe(struct
 		goto err_find_mode;
 	}
 
+	/* maximize virtual vertical size for fast scrolling */
+	info->var.yres_virtual = info->fix.smem_len * 8 /
+			(info->var.bits_per_pixel * info->var.xres_virtual);
+	if (info->var.yres_virtual < info->var.yres) {
+		dev_err(info->device, "virtual vertical size smaller than real\n");
+		goto err_find_mode;
+	}
+
 	rc = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (rc < 0) {
 		dev_err(info->device, "cannot allocate colormap\n");

-- 
Ondrej Zary
