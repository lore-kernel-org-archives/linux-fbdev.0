From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: Re: [RFC PATCH 2/2] ep93xx framebuffer driver
Date: Wed, 27 May 2009 12:35:27 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901862D66@mi8nycmail19.Mi8.com>
References: <4A1A2ABD.8000104@bluewatersys.com>
	<4A1A2DB7.1050500@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE1909017FF7FC@mi8nycmail19.Mi8.com>
	<4A1CADD4.7000006@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hartleys@visionengravers.com>) id 1M9M6J-0001KD-2p
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 May 2009 16:35:35 +0000
Received: from exprod6ob114.obsmtp.com ([64.18.1.32] helo=psmtp.com)
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1M9M6G-0002wc-Or for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 May 2009 16:35:35 +0000
Content-class: urn:content-classes:message
In-Reply-To: <4A1CADD4.7000006@bluewatersys.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, arm kernel <linux-arm-kernel@lists.arm.linux.org.uk>

On Tuesday, May 26, 2009 8:05 PM, Ryan Mallon wrote:
>>> This patch adds support for the ep93xx framebuffer. Patch is against
>>> arm ep93xx branch.
>>>
>>> Can anybody with ep93xx hardware please test, specifically with regard
>>> to the physical address bit 27 bug. My hardware has the bug, but I'm
>>> not sure about other ep93xx chips.
>> 
>> I have not seen the address bit 27 bug on my custom hardware with
>> EP9307 Rev E0 silicon.
>
> Have you had the driver allocate a physical memory address which has bit
> 27 set? I'm basically wondering whether to enable the check by default
> or not. If the problem only exists on a few ep93xx chips then it may be
> better to leave the check off by default.

I just thought about it... On my platform it's impossible to allocate a
physical memory address which has bit 27 set.

My board has 64MB SDRAM on SDCE0 and the bootloader is setting the SROMLL
bit when configuring the SDRAM controller.  This results in my SDRAM
getting physically mapped to:

0xc0000000 - 0xc1ffffff
0xc4000000 - 0xc5ffffff

Looking at the various SDRAM address mappings it appears the only way to
get a physical address with bit 27 set is to have SROMLL = 0.  This is
generally not a good idea because the SDRAM gets very segmented with
certain memory configurations.

Refer to the following document for more information:

http://arm.cirrus.com/files/HOWTO/EP93xx%20SDRAM%20Address%20Ranges.pdf

>>> +
>>> +static struct platform_device ep93xx_fb_device = {
>>> +	.name			= "ep93xxfb",
>>> +	.id			= 0,
>> 
>> Since there can only be one framebuffer device how about using
>> .id = -1?  This will change the clk dev_id to "ep93xxfb".  Also,
>> maybe change the name to "ep93xx-fb", that's how the usb host is
>> named.
>
> Will fix both.

Ok.  You might need to change the name in the driver also.

>>> +	.dev.platform_data	= &ep93xxfb_data,
>>> +	.dev.coherent_dma_mask	= 0xf7ffffff,
>> 
>> I think this is supposed to be
>> 
>> 	.dev.coherent_dma_mask	= DMA_BIT_MASK(32),
>> 
>> Or is the missing bit due to the address bit 27 bug?
>
> Yeah, its for bit 27. Not sure how to handle this correctly if the check
> is a driver option. If you don't have this problem, just change it to
> DMA_BIT_MASK(32) for testing.

I have been using DMA_BIT_MASK(32) for quite a while with no problems.

Isn't there also supposed to be a:

	.dev.dma_mask	= &ep93xx_fb_device.dev.coherent_dma_mask,

in the platform_device struct?  Look at the ep93xx_ohci_device for reference.

Regards,
Hartley

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
