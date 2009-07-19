From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH v2 2/2] ep93xx video driver
Date: Sun, 19 Jul 2009 22:46:01 +1200
Message-ID: <4A62F969.2030602@bluewatersys.com>
References: <4A60D6F3.5060906@bluewatersys.com>
	<4A60DDBA.2020007@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901AC2033@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ryan@bluewatersys.com>) id 1MSIfW-00008z-T3
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 18 Jul 2009 22:46:14 +0000
Received: from mail.bluewatersys.com ([202.124.120.130]
	helo=hayes.bluewaternz.com)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MSIfQ-0003lU-AI
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 18 Jul 2009 22:46:14 +0000
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901AC2033@mi8nycmail19.Mi8.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: d.venzano@motronica.com, linux-fbdev-devel@lists.sourceforge.net, arm kernel <linux-arm-kernel@lists.arm.linux.org.uk>

H Hartley Sweeten wrote:
> On Friday, July 17, 2009 1:23 PM, Ryan Mallon wrote:
>   
>> +static int __init ep93xxfb_alloc_videomem(struct fb_info *info)
>> +{
>> +	struct ep93xx_fbi *fbi = info->par;
>> +	char __iomem *virt_addr;
>> +	dma_addr_t phys_addr;
>> +	unsigned int fb_size;
>> +
>> +	fb_size = ep93xxfb_calc_fbsize(fbi->mach_info);
>> +	virt_addr = dma_alloc_writecombine(info->dev, fb_size,
>> +					   &phys_addr, GFP_KERNEL);
>> +	if (!virt_addr)
>> +		return -ENOMEM;
>> +	
>> +	/*
>> +	 * There is a bug in the ep93xx framebuffer which causes problems
>> +	 * if bit 27 of the physical address is set.
>> +	 * See: http://marc.info/?l=linux-arm-kernel&m=110061245502000&w=2
>> +	 * There does not seem to be any offical errata for this, but I
>> +	 * have confirmed the problem exists on my hardware (ep9315) at
>> +	 * least.
>> +	 */
>> +	if (check_screenpage_bug && phys_addr & (1 << 27)) {
>> +		dev_err(info->dev, "ep93xx framebuffer bug. phys addr (0x%x) "
>> +			"has bit 27 set: cannot init framebuffer\n", 
>> +			phys_addr);
>> +		
>> +		dma_free_coherent(info->dev, fb_size, virt_addr, phys_addr);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	info->fix.smem_start = phys_addr;
>> +	info->fix.smem_len = fb_size;
>> +	info->screen_base = virt_addr;
>> +
>> +	return 0;
>> +}
>>     
>
> Were you able to test the SROMLL bit?  If that "fixes" the bit 27 bug maybe
> this should be added to the comment.  As far as I can tell, if the SROMLL bit
> is set it is impossbile to have an SDRAM physical address that would have
> bit 27 set.  With it cleared there are a number of memory configurations that
> might have it set.
>
>   
I tried the different memory layout you suggested, but I got a massive
kernel panic in the memory manager near the end of the boot process. I
haven't looked into it too much yet, one of my workmates seemed to think
that the way our SDRAM is wired up means that we can only use the memory
layout we have.

~Ryan


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
