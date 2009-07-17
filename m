From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: Re: [PATCH v2 2/2] ep93xx video driver
Date: Fri, 17 Jul 2009 14:19:56 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901AC2033@mi8nycmail19.Mi8.com>
References: <4A60D6F3.5060906@bluewatersys.com>
	<4A60DDBA.2020007@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hartleys@visionengravers.com>) id 1MRs2N-0006wD-QF
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Jul 2009 18:20:03 +0000
Received: from exprod6og104.obsmtp.com ([64.18.1.187])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MRs2M-000222-PO for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Jul 2009 18:20:03 +0000
Content-class: urn:content-classes:message
In-Reply-To: <4A60DDBA.2020007@bluewatersys.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ryan Mallon <ryan@bluewatersys.com>, arm kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net, d.venzano@motronica.com

On Friday, July 17, 2009 1:23 PM, Ryan Mallon wrote:
> EP93xx video driver support
>
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
>
> ---

[snip]

> diff --git a/drivers/video/ep93xx_fb.c b/drivers/video/ep93xx_fb.c
> new file mode 100644
> index 0000000..129ba4b
> --- /dev/null
> +++ b/drivers/video/ep93xx_fb.c

[snip]

> +
> +static inline unsigned int ep93xxfb_readl(struct ep93xx_fbi *fbi,
> +					  unsigned int off)
> +{
> +	return __raw_readl(fbi->mmio_base + off);
> +}
> +
> +static inline void ep93xxfb_writel(struct ep93xx_fbi *fbi, unsigned int val, 
> +				   unsigned int off)
> +{

Please move the 'unsigned in val,' down with the 'unsigned int off'.

I know it's < 80 chars but it makes the inline function consistent with the
others.  And it's a bit clearer to read.

> +	__raw_writel(val, fbi->mmio_base + off);
> +}
> +
> +/*
> + * Write to one of the locked raster registers.
> + */
> +static inline void ep93xxfb_out_locked(struct ep93xx_fbi *fbi,
> +				       unsigned int val, unsigned int reg)
> +{
> +	/*
> +	 * We don't need a lock or delay here since the raster register
> +	 * block will remain unlocked until the next access.
> +	 */
> +	ep93xxfb_writel(fbi, 0xaa, EP93XXFB_SWLOCK);
> +	ep93xxfb_writel(fbi, val, reg);
> +}
> +

[snip]

> +static int __init ep93xxfb_alloc_videomem(struct fb_info *info)
> +{
> +	struct ep93xx_fbi *fbi = info->par;
> +	char __iomem *virt_addr;
> +	dma_addr_t phys_addr;
> +	unsigned int fb_size;
> +
> +	fb_size = ep93xxfb_calc_fbsize(fbi->mach_info);
> +	virt_addr = dma_alloc_writecombine(info->dev, fb_size,
> +					   &phys_addr, GFP_KERNEL);
> +	if (!virt_addr)
> +		return -ENOMEM;
> +	
> +	/*
> +	 * There is a bug in the ep93xx framebuffer which causes problems
> +	 * if bit 27 of the physical address is set.
> +	 * See: http://marc.info/?l=linux-arm-kernel&m=110061245502000&w=2
> +	 * There does not seem to be any offical errata for this, but I
> +	 * have confirmed the problem exists on my hardware (ep9315) at
> +	 * least.
> +	 */
> +	if (check_screenpage_bug && phys_addr & (1 << 27)) {
> +		dev_err(info->dev, "ep93xx framebuffer bug. phys addr (0x%x) "
> +			"has bit 27 set: cannot init framebuffer\n", 
> +			phys_addr);
> +		
> +		dma_free_coherent(info->dev, fb_size, virt_addr, phys_addr);
> +		return -ENOMEM;
> +	}
> +
> +	info->fix.smem_start = phys_addr;
> +	info->fix.smem_len = fb_size;
> +	info->screen_base = virt_addr;
> +
> +	return 0;
> +}

Were you able to test the SROMLL bit?  If that "fixes" the bit 27 bug maybe
this should be added to the comment.  As far as I can tell, if the SROMLL bit
is set it is impossbile to have an SDRAM physical address that would have
bit 27 set.  With it cleared there are a number of memory configurations that
might have it set.

Regards,
Hartley

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
