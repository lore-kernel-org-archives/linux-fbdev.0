From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Thu, 16 Jun 2011 07:20:33 +0000
Subject: Re: [PATCH] video: Add GRVGA framebuffer device driver
Message-Id: <4DF9AEC1.8050808@gaisler.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308128180-14645-1-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1308128180-14645-1-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Konrad,


Konrad Rzeszutek Wilk wrote:

>> +#define GRVGA_REGLOAD(a)	    (__raw_readl(&(a)))
>> +#define GRVGA_REGSAVE(a, v)         (__raw_writel(v, &(a)))
> 
> writel?
> 


I use __raw since I want native endianess. On a big endian system
writel/readl byte swap since they are for little endian (PCI).


>> +struct grvga_regs {
>> +	u32 status; 		/* 0x00 */
>> +	u32 video_length; 	/* 0x04 */
>> +	u32 front_porch;	/* 0x08 */
>> +	u32 sync_length;	/* 0x0C */
>> +	u32 line_length;	/* 0x10 */
>> +	u32 fb_pos;		/* 0x14 */
>> +	u32 clk_vector[4];	/* 0x18 */
>> +	u32 clut;	        /* 0x20 */
>> +};
> 
> Would it make sense to add __packed__ here? It seems that you
> really depend on this ordering.
> 

I depend on the ordering, but that is guaranteed by the compiler without __packed__. 
Attribute __packed__ is dangerous here since it tells the compiler that it is ok
to do byte accesses.


>> +static struct fb_ops grvga_ops = {
>> +	.owner          = THIS_MODULE,
>> +	.fb_check_var   = grvga_check_var,
>> +	.fb_set_par	= grvga_set_par,
>> +	.fb_setcolreg   = grvga_setcolreg,
>> +	.fb_pan_display = grvga_pan_display,
>> +	.fb_fillrect	= cfb_fillrect,
>> +	.fb_copyarea	= cfb_copyarea,
>> +	.fb_imageblit	= cfb_imageblit
>> +};
> 
> Could you move this struct down and remove the declarations earlier?

Yes sure.


>> +	}
>> +	if (i != -1)
>> +		par->clk_sel = i;
> 
> How would i possibly become -1?


Refactoring error .. thanks!


>> +static int grvga_set_par(struct fb_info *info)
>> +{
>> +
>> +	int func = 0;
> 
> You probably want that to be u32.

Sure why not.


> No default case?

Will add ...


>> +		physical_start = __pa(virtual_start);
> 
> Yikes. That is one big assumption. You don't want to use the PCI/DMA API
> to map it? I thought that on SPARCs the Bus addresses are different
> from the physical addresses?

Yeah I should map it for cleanliness sake. It does not matter on this architecture (LEON) though.


>> +
>> +	if (info) {
>> +		unregister_framebuffer(info);
>> +		fb_dealloc_cmap(&info->cmap);
>> +		of_iounmap(&device->resource[0], par->regs,
>> +			   resource_size(&device->resource[0]));
>> +		framebuffer_release(info);
>> +		dev_set_drvdata(&device->dev, NULL);
> 
> Shouldn't that be much earlier? Like right after unregister_framebuffer?
> 

You mean I should set driver_data = NULL ASAP after unregistering the framebuffer?
Does it really matter? Please enlighten me.


Thanks a lot for your feedback.

Best regards,
Kristoffer Glembo
