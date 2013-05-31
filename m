From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 31 May 2013 15:28:45 +0000
Subject: Re: [PATCH v3 7/8] video: xilinxfb: Fix sparse warnings
Message-Id: <1506693.18n3ImgyKs@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1370004925.git.michal.simek@xilinx.com> <51A8A89C.8030404@tabi.org> <51A8B220.6070308@monstr.eu>
In-Reply-To: <51A8B220.6070308@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu
Cc: Timur Tabi <timur@tabi.org>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

On Friday 31 May 2013 16:22:24 Michal Simek wrote:
>         if (pdata->fb_phys) {
>                 drvdata->fb_phys = pdata->fb_phys;
> -               drvdata->fb_virt = ioremap(pdata->fb_phys, fbsize);
> +               drvdata->fb_virt_io = ioremap(pdata->fb_phys, fbsize);
> +
> +               if (!drvdata->fb_virt_io) {
> +                       dev_err(dev, "Could not allocate frame buffer memory\n");
> +                       rc = -ENOMEM;
> +                       if (drvdata->flags & BUS_ACCESS_FLAG)
> +                               goto err_fbmem;
> +                       else
> +                               goto err_region;
> +               }
> +
> +               /* Clear (turn to black) the framebuffer */
> +               memset_io(drvdata->fb_virt_io, 0, fbsize);
>         } else {
> -               drvdata->fb_alloced = 1;
>                 drvdata->fb_virt = dma_alloc_coherent(dev, PAGE_ALIGN(fbsize),
>                                         &drvdata->fb_phys, GFP_KERNEL);
> -       }
> 

I think you also want to use ioremap_wc or dma_alloc_writecombine
here, to get a write-combining mapping, rather than a device mapping
that you would use for MMIO register access.

There is also a builtin assumption in the code above that the DMA
address space pointer (which you pass into REG_FB_ADDR) is the
same as what you pass into drvdata->info.fix.smem_start. That is
not the case in general, but I don't see a good way around it
when pdata->fb_phys is set by the platform to something outside
of system memory. It should probably have a comment next to it.

	Arnd
