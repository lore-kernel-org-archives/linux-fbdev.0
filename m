From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Date: Mon, 13 Jan 2014 06:19:11 +0000
Subject: Re: [PATCH v5] video: add OpenCores VGA/LCD framebuffer driver
Message-Id: <20140113061910.GA28149@chokladfabriken.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389384793-4710-1-git-send-email-stefan.kristiansson@saunalahti.fi>
 <000301cf0ffe$4054e8d0$c0feba70$%han@samsung.com>
In-Reply-To: <000301cf0ffe$4054e8d0$c0feba70$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Mon, Jan 13, 2014 at 10:24:49AM +0900, Jingoo Han wrote:
> On Saturday, January 11, 2014 5:13 AM, Stefan Kristiansson wrote:
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/errno.h>
> > +#include <linux/string.h>
> > +#include <linux/slab.h>
> > +#include <linux/delay.h>
> > +#include <linux/mm.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/fb.h>
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/of.h>
> 
> Would you re-order these headers alphabetically?
> It enhances the readability.
> 

OK

> [.....]
> 
> > +struct ocfb_dev {
> > +	struct fb_info info;
> > +	void __iomem *regs;
> > +	/* flag indicating whether the regs are little endian accessed */
> > +	int little_endian;
> > +	/* Physical and virtual addresses of framebuffer */
> > +	phys_addr_t fb_phys;
> > +	void __iomem *fb_virt;
> > +	u32 pseudo_palette[PALETTE_SIZE];
> > +};
> 
> Here, 'fb_virt' is already defined as 'void __iomem *'.
> 
> [.....]
> 
> > +	fbdev->info.fix.smem_start = fbdev->fb_phys;
> > +	fbdev->info.screen_base = (void __iomem *)fbdev->fb_virt;
> 
> Please remove unnecessary casting as below, because 'fb_virt' is already
> defined as 'void __iomem *'.
> 
> +	fbdev->info.screen_base = fbdev->fb_virt;
> 
> > +	fbdev->info.pseudo_palette = fbdev->pseudo_palette;
> > +
> > +	/* Clear framebuffer */
> > +	memset_io((void __iomem *)fbdev->fb_virt, 0, fbsize);
> 
> Same here.
> 
> +	memset_io(fbdev->fb_virt, 0, fbsize);
> 

Nice catch, will do.

Stefan
