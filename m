From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Thu, 16 Jun 2011 08:55:09 +0000
Subject: Re: [PATCH V2] video: Add GRVGA framebuffer device driver
Message-Id: <4DF9C4ED.5000009@gaisler.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308139443-15661-1-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1308139443-15661-1-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Paul,

Paul Mundt wrote:
> On Wed, Jun 15, 2011 at 02:04:03PM +0200, Kristoffer Glembo wrote:
>> +#define GRVGA_REGLOAD(a)	    (__raw_readl(&(a)))
>> +#define GRVGA_REGSAVE(a, v)         (__raw_writel(v, &(a)))
>> +#define GRVGA_REGORIN(a, v)         (GRVGA_REGSAVE(a, (GRVGA_REGLOAD(a) | (v))))
>> +#define GRVGA_REGANDIN(a, v)        (GRVGA_REGSAVE(a, (GRVGA_REGLOAD(a) & (v))))
>> +
> I would recommend just getting rid of these completely, they don't really
> buy you much of anything, other than forcing people to scroll to the top
> to figure out what exactly it's supposed to be doing.

I find it quite convenient when doing a lot of register accesses and especially
a lot of ORing and ANDing (this driver is simple enough to not benefit a lot).
It also makes it very clear that we are accessing a register which I think is good.

Anyway, it should be readable to other people as well and since this driver is 
so simple I can remove it.


> 
>> +#define	GRVGA_FBINFO_DEFAULT	(FBINFO_DEFAULT \
>> +				 | FBINFO_PARTIAL_PAN_OK \
>> +				 | FBINFO_HWACCEL_YPAN)
>> +
> Same with this.

Ok.


>
>> +		var->red   = (struct fb_bitfield) {16, 8, 0};
>> +		var->green = (struct fb_bitfield) {8, 8, 0};
>> +		var->blue  = (struct fb_bitfield) {0, 8, 0};
>> +		var->transp = (struct fb_bitfield) {24, 8, 0};
>> +		break;
> 
> This is also a bit unconventional. var should already be zeroed out, so
> you can just establish the .length values for each one as necessary.

I think this looks better than setting length and offset for each one.


> If you have open firmware available then why do you have a need to have
> this bizarre "custom" command line option for parsing all of the geometry
> information?
 
Our OF typically only contains the address and interrupt of each device (it 
is automatically generated in the boot loader from a ROM area in the chip).


> You would probably benefit from ripping all of this out and stashing it
> in a grvga_setup() function.

Ok.


>> +	par->regs = of_ioremap(&dev->resource[0], 0,
>> +			       resource_size(&dev->resource[0]),
>> +			       "grlib-svgactrl regs");
>> +
>> +	retval = fb_alloc_cmap(&info->cmap, 256, 0);
>> +	if (retval < 0) {
>> +		dev_err(&dev->dev, "failed to allocate mem with fb_alloc_cmap\n");
>> +		retval = -ENOMEM;
>> +		goto err1;
>> +	}
>> +
> Can of_ioremap() fail?

I will add error checking.

>> +
>> +		virtual_start = (unsigned long) __get_free_pages(GFP_ATOMIC | GFP_DMA,
>> +								 get_order(grvga_mem_size));
> 
> GFP_ATOMIC?

Hmm yes that seems very unnecessary, will remove.


>> +		physical_start = __pa(virtual_start);
>> +
>> +		/* Set page reserved so that mmap will work. This is necessary
>> +		 * since we'll be remapping normal memory.
>> +		 */
>> +		for (page = virtual_start;
>> +		     page < PAGE_ALIGN(virtual_start + grvga_mem_size);
>> +		     page += PAGE_SIZE) {
>> +			SetPageReserved(virt_to_page(page));
>> +		}
>> +	}
>> +
> This all looks like a good candidate for dma_alloc_coherent().

That would make the whole framebuffer uncachable and won't reserve the page?


>> +	if (info) {
>> +		unregister_framebuffer(info);
>> +		fb_dealloc_cmap(&info->cmap);
>> +		of_iounmap(&device->resource[0], par->regs,
>> +			   resource_size(&device->resource[0]));
>> +		framebuffer_release(info);
>> +		dev_set_drvdata(&device->dev, NULL);
>> +	}
>> +
> You seem to be missing a release_mem_region() in here.

Indeed.


>> +int __init grvga_init(void)
>> +{
>> +	return platform_driver_register(&grvga_driver);
>> +}
>> +
> static?

It should be, yes.


Thanks,
Kristoffer Glembo


