From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 1/2]Freescale i.MX framebuffer driver
Date: Fri, 18 Mar 2005 22:14:30 +0800
Message-ID: <200503182214.30492.adaplas@hotpop.com>
References: <20050317173624.GA29286@metis.extern.pengutronix.de> <200503180344.58891.adaplas@hotpop.com> <20050318113912.GA18354@metis.extern.pengutronix.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DCIFI-000510-Gi
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Mar 2005 06:14:36 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DCIFF-00081N-CX
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Mar 2005 06:14:36 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 6A347FD648F
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Mar 2005 14:14:23 +0000 (UTC)
In-Reply-To: <20050318113912.GA18354@metis.extern.pengutronix.de>
Content-Disposition: inline
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
To: Sascha Hauer <s.hauer@pengutronix.de>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

On Friday 18 March 2005 19:39, Sascha Hauer wrote:

[snip]

> +static int
> +imxfb_setpalettereg(u_int regno, u_int red, u_int green, u_int blue,
> +		       u_int trans, struct fb_info *info)
> +{
> +	struct imxfb_info *fbi = (struct imxfb_info *)info;

Use struct imxfb_info *fbi = info->par;

[snip]

> +
> +	pr_debug("var->bits_per_pixel=%d\n", var->bits_per_pixel);
> +	switch (var->bits_per_pixel) {
> +	case 16:
> +		rgbidx = RGB_16;
> +		break;
> +	case 8:
> +		rgbidx = RGB_8;
> +		break;
> +	default:
> +		return -EINVAL;

Don't trust users.  Might as well round off var->bits_per_pixel to
8 or 16 instead of failing.

[snip]

> +/*
> + * imxfb_blank():
> + *	Blank the display by setting all palette values to zero.  Note, the
> + * 	12 and 16 bpp modes don't really use the palette, so this will not
> + *      blank the display in all modes.
> + */
> +static int imxfb_blank(int blank, struct fb_info *info)
> +{
> +	struct imxfb_info *fbi = info->par;
> +	int i;
> +
> +	pr_debug("imxfb_blank: blank=%d\n", blank);
> +
> +	switch (blank) {
> +	case VESA_POWERDOWN:
> +	case VESA_VSYNC_SUSPEND:
> +	case VESA_HSYNC_SUSPEND:
> +		if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR ||
> +		    info->fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR)
> +			for (i = 0; i < fbi->palette_size; i++)
> +				imxfb_setpalettereg(i, 0, 0, 0, 0, info);
> +		imxfb_disable_controller(fbi);
> +		break;
> +
> +	case VESA_NO_BLANKING:
> +		if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR ||
> +		    info->fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR)
> +			fb_set_cmap(&info->cmap, info);
> +		imxfb_enable_controller(fbi);
> +	}

Use FB_BLANK_* constants instead of VESA_*.  They are interpreted
differently by fbcon.

[snip]

> +
> +	strcpy(info->fix.id, IMX_NAME);

strncpy may be safer, just in case you decide to use a longer string.
fix->id is only 16 bytes long.

I don't care which one you want.

[snip]

> +	if(!inf) {
> +		dev_err(dev,"No platform_data available\n");
> +		return -ENOMEM;
> +	}
> +
> +	info = framebuffer_alloc(sizeof(struct imxfb_info), dev);

Check if framebuffer_alloc is successful.

> +	info->device = dev;

No need to set info->device, framebuffer_alloc() will do it for you.

[snip]

> +
> +failed:
> +	dev_set_drvdata(dev, NULL);
> +	if (info)
> +		framebuffer_release(info);
> +	release_resource(res);
> +	return ret;

Fix the failure path.  kfree all kmallocs, dealloc_cmap(), etc.

> +}
> +
> +static int imxfb_remove(struct device *dev)
> +{
> +	struct fb_info *info = dev_get_drvdata(dev);
> +
> +	/* disable LCD controller */
> +	LCDC_RMCR &= ~RMCR_LCDC_EN;
> +
> +	unregister_framebuffer(info);
> +
> +	kfree(info->pseudo_palette);
> +	framebuffer_release(info);
> +

include dealloc_cmap here, at least.

> +	dev_set_drvdata(dev, NULL);
> +
> +	return 0;
> +}
> +
> +void  imxfb_shutdown(struct device * dev)
> +{
> +	/* disable LCD Controller */
> +	LCDC_RMCR &= ~RMCR_LCDC_EN;
> +}
> +
> +static struct device_driver imxfb_driver = {
> +	.name		= "imx-fb",
> +	.bus		= &platform_bus_type,
> +	.probe		= imxfb_probe,
> +	.suspend	= imxfb_suspend,
> +	.resume		= imxfb_resume,
> +	.remove		= imxfb_remove,
> +	.shutdown	= imxfb_shutdown,
> +};
> +
> +int __init imxfb_init(void)
> +{

It's ugliness, but you might want to include

if (fb_get_options("imxfb", NULL))
	return -ENODEV 

here so your driver can listen to generic video options, ie
video=imxfb:off.

[snip]

> +#define RGB_16	(0)
> +#define RGB_8	(1)
> +#define NR_RGB	2
> +
> +struct imxfb_info {
> +	struct fb_info		*fb;

If done properly, you don't need struct fb_info inside
struct imxfb_info.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
