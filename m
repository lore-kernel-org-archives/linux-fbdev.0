From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 13 Jan 2014 01:24:49 +0000
Subject: Re: [PATCH v5] video: add OpenCores VGA/LCD framebuffer driver
Message-Id: <000301cf0ffe$4054e8d0$c0feba70$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389384793-4710-1-git-send-email-stefan.kristiansson@saunalahti.fi>
In-Reply-To: <1389384793-4710-1-git-send-email-stefan.kristiansson@saunalahti.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Stefan Kristiansson' <stefan.kristiansson@saunalahti.fi>
Cc: 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Saturday, January 11, 2014 5:13 AM, Stefan Kristiansson wrote:
> 
> This adds support for the VGA/LCD core available from OpenCores:
> http://opencores.org/project,vga_lcd
> 
> The driver have been tested together with both OpenRISC and
> ARM (socfpga) processors.
> 
> Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> ---
> Changes in v2:
> - Add Microblaze as an example user and fix a typo in Xilinx Zynq
> 
> Changes in v3:
> - Use devm_kzalloc instead of kzalloc
> - Remove superflous MODULE #ifdef
> 
> Changes in v4:
> - Remove 'default n' in Kconfig
> - Simplify ioremap/request_mem_region by using devm_ioremap_resource
> - Remove release_mem_region
> 
> Changes in v5:
> - Remove static structs to support multiple devices
> ---
>  drivers/video/Kconfig  |  16 ++
>  drivers/video/Makefile |   1 +
>  drivers/video/ocfb.c   | 440 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 457 insertions(+)
>  create mode 100644 drivers/video/ocfb.c

It looks good.
However, I added some minor comments. :-)
Sorry for late response.

[.....]

> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/mm.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/fb.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>

Would you re-order these headers alphabetically?
It enhances the readability.

[.....]

> +struct ocfb_dev {
> +	struct fb_info info;
> +	void __iomem *regs;
> +	/* flag indicating whether the regs are little endian accessed */
> +	int little_endian;
> +	/* Physical and virtual addresses of framebuffer */
> +	phys_addr_t fb_phys;
> +	void __iomem *fb_virt;
> +	u32 pseudo_palette[PALETTE_SIZE];
> +};

Here, 'fb_virt' is already defined as 'void __iomem *'.

[.....]

> +	fbdev->info.fix.smem_start = fbdev->fb_phys;
> +	fbdev->info.screen_base = (void __iomem *)fbdev->fb_virt;

Please remove unnecessary casting as below, because 'fb_virt' is already
defined as 'void __iomem *'.

+	fbdev->info.screen_base = fbdev->fb_virt;

> +	fbdev->info.pseudo_palette = fbdev->pseudo_palette;
> +
> +	/* Clear framebuffer */
> +	memset_io((void __iomem *)fbdev->fb_virt, 0, fbsize);

Same here.

+	memset_io(fbdev->fb_virt, 0, fbsize);

Best regards,
Jingoo Han

