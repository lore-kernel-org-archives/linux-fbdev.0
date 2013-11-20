From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 20 Nov 2013 06:20:28 +0000
Subject: Re: [PATCH v2] video: add OpenCores VGA/LCD framebuffer driver
Message-Id: <000701cee5b8$9b61e3b0$d225ab10$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1384920820-18740-1-git-send-email-stefan.kristiansson@saunalahti.fi>
In-Reply-To: <1384920820-18740-1-git-send-email-stefan.kristiansson@saunalahti.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Stefan Kristiansson' <stefan.kristiansson@saunalahti.fi>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Jean-Christophe PLAGNIOL-VILLARD' <plagnioj@jcrosoft.com>, 'Jingoo Han' <jg1.han@samsung.com>

On Wednesday, November 20, 2013 1:14 PM, Stefan Kristiansson wrote:
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
> ---
>  drivers/video/Kconfig  |  17 ++
>  drivers/video/Makefile |   1 +
>  drivers/video/ocfb.c   | 479 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 497 insertions(+)
>  create mode 100644 drivers/video/ocfb.c
> 

Hi Stefan Kristiansson,

I added trivial comments as below.

[.....]

> --- /dev/null
> +++ b/drivers/video/ocfb.c

[.....]

> +static int ocfb_probe(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +	struct ocfb_dev *fbdev;
> +	struct ocfb_par *par = &ocfb_par_priv;
> +	struct resource *res;
> +	struct resource *mmio;
> +	int fbsize;
> +
> +	fbdev = kzalloc(sizeof(*fbdev), GFP_KERNEL);

Please use devm_kzalloc() instead of kzalloc().
In this case, kfree() can be removed from ocfb_probe()
and ocfb_remove(). Thus, it will make the code smaller.

[.....]

> +
> +#ifdef MODULE

I don't think that '#ifdef MODULE' is necessary.
Is there any reason?

Best regards,
Jingoo Han

> +MODULE_AUTHOR("Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>");
> +MODULE_DESCRIPTION("OpenCores VGA/LCD 2.0 frame buffer driver");
> +MODULE_LICENSE("GPL v2");
> +module_param(mode_option, charp, 0);
> +MODULE_PARM_DESC(mode_option, "Video mode ('<xres>x<yres>[-<bpp>][@refresh]')");
> +#endif
> --
> 1.8.3.2

