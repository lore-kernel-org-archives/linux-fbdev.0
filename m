From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [RFC PATCH 2/2] ep93xx framebuffer driver
Date: Wed, 27 May 2009 15:04:52 +1200
Message-ID: <4A1CADD4.7000006@bluewatersys.com>
References: <4A1A2ABD.8000104@bluewatersys.com>
	<4A1A2DB7.1050500@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE1909017FF7FC@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ryan@bluewatersys.com>) id 1M99Qs-00018O-Or
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 May 2009 03:03:58 +0000
Received: from 130.120.124.202.static.snap.net.nz ([202.124.120.130]
	helo=hayes.bluewaternz.com)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M99Qj-0001RG-VY
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 May 2009 03:03:53 +0000
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909017FF7FC@mi8nycmail19.Mi8.com>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, arm kernel <linux-arm-kernel@lists.arm.linux.org.uk>

H Hartley Sweeten wrote:
> On Sunday, May 24, 2009 10:34 PM, Ryan Mallon wrote:
>> This patch adds support for the ep93xx framebuffer. Patch is against
>> arm ep93xx branch.
>>
>> Can anybody with ep93xx hardware please test, specifically with regard
>> to the physical address bit 27 bug. My hardware has the bug, but I'm
>> not sure about other ep93xx chips.
> 
> I have not seen the address bit 27 bug on my custom hardware with
> EP9307 Rev E0 silicon.

Have you had the driver allocate a physical memory address which has bit
27 set? I'm basically wondering whether to enable the check by default
or not. If the problem only exists on a few ep93xx chips then it may be
better to leave the check off by default.

>> +
>> +static struct platform_device ep93xx_fb_device = {
>> +	.name			= "ep93xxfb",
>> +	.id			= 0,
> 
> Since there can only be one framebuffer device how about using
> .id = -1?  This will change the clk dev_id to "ep93xxfb".  Also,
> maybe change the name to "ep93xx-fb", that's how the usb host is
> named.

Will fix both.

> 
>> +	.dev.platform_data	= &ep93xxfb_data,
>> +	.dev.coherent_dma_mask	= 0xf7ffffff,
> 
> I think this is supposed to be
> 
> 	.dev.coherent_dma_mask	= DMA_BIT_MASK(32),
> 
> Or is the missing bit due to the address bit 27 bug?

Yeah, its for bit 27. Not sure how to handle this correctly if the check
is a driver option. If you don't have this problem, just change it to
DMA_BIT_MASK(32) for testing.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

       Ryan Mallon                              Unit 5, Amuri Park
       Phone: +64 3 3779127                     404 Barbadoes St
       Fax:   +64 3 3779135                     PO Box 13 889
       Email: ryan@bluewatersys.com             Christchurch, 8013
       Web:   http://www.bluewatersys.com       New Zealand
       Freecall Australia  1800 148 751         USA 1800 261 2934

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
