From: Finn Thain <fthain@telegraphics.com.au>
Date: Sat, 01 Jun 2019 23:53:47 +0000
Subject: Re: [PATCH AUTOSEL 4.4 44/56] video: imsttfb: fix potential NULL pointer dereferences
Message-Id: <alpine.LNX.2.21.1906020944570.8@nippy.intranet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190601132600.27427-1-sashal@kernel.org> <20190601132600.27427-44-sashal@kernel.org> <20190601161929.GA5028@kroah.com>
In-Reply-To: <20190601161929.GA5028@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kangjie Lu <kjlu@umn.edu>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>, Rob Herring <robh@kernel.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Sat, 1 Jun 2019, Greg Kroah-Hartman wrote:

> On Sat, Jun 01, 2019 at 09:25:48AM -0400, Sasha Levin wrote:

> > From: Kangjie Lu <kjlu@umn.edu>
> > 
> > [ Upstream commit 1d84353d205a953e2381044953b7fa31c8c9702d ]
> > ...
> 
> Why only 4.4.y?  Shouldn't this be queued up for everything or none?
> 
> thanks,
> 
> greg k-h
> 

Also, why not check the result of the other ioremap calls? (I should have 
checked that when this first crossed my inbox...)

From 1d84353d205a953e2381044953b7fa31c8c9702d Mon Sep 17 00:00:00 2001
From: Kangjie Lu <kjlu@umn.edu>
Date: Mon, 1 Apr 2019 17:46:58 +0200
Subject: [PATCH] video: imsttfb: fix potential NULL pointer dereferences

In case ioremap fails, the fix releases resources and returns
-ENOMEM to avoid NULL pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Cc: Aditya Pakki <pakki001@umn.edu>
Cc: Finn Thain <fthain@telegraphics.com.au>
Cc: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[b.zolnierkie: minor patch summary fixup]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 4b9615e4ce74..35bba3c2036d 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1515,6 +1515,11 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	info->fix.smem_start = addr;
 	info->screen_base = (__u8 *)ioremap(addr, par->ramdac = IBM ?
 					    0x400000 : 0x800000);
+	if (!info->screen_base) {
+		release_mem_region(addr, size);
+		framebuffer_release(info);
+		return -ENOMEM;
+	}
 	info->fix.mmio_start = addr + 0x800000;
 	par->dc_regs = ioremap(addr + 0x800000, 0x1000);
 	par->cmap_regs_phys = addr + 0x840000;
