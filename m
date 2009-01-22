From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 2/4 v8] i.MX31: Image Processing
	Unit DMA and IRQ drivers
Date: Thu, 22 Jan 2009 20:04:43 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0901221959100.7935@axis700.grange>
References: <Pine.LNX.4.64.0901081850280.6387@axis700.grange>
	<Pine.LNX.4.64.0901081857170.6387@axis700.grange>
	<4978C01B.8080707@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <g.liakhovetski@gmx.de>) id 1LQ4rP-0006zK-Ab
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jan 2009 19:05:03 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 29vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1LQ4rF-0002Fc-Ul for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jan 2009 19:05:03 +0000
In-Reply-To: <4978C01B.8080707@epfl.ch>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Valentin Longchamp <valentin.longchamp@epfl.ch>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, Dan Williams <dan.j.williams@intel.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

On Thu, 22 Jan 2009, Valentin Longchamp wrote:

> Hi Guennadi,
> 
> I wanted to test this driver on my board. However it does not work for
> me. I have pulled the version that is on async-tx tree so it should be
> up to date and it compiles fine.
> 
> Unfortunately the fb driver cannot register because it cannot request a
> dma channel (there are no dma registered in dmaengive, the list is
> empty). This is because the ipu-core platform_driver is never
> registered. This is supposed to be done thanks to the
> subsys_initcall(ipu_init) as we can see it in the patch (which is then
> going to be linked with the ipu-core device that is registered witth the
> other mx3 device). I never happen to see one of the ipu_probe messages
> (even for failure) with dynamic_printk enabled.

You need the patch 4/4 - platform bindings, which is not in that queue and 
will only be merged in the next kernel version. You can so far pick it up 
here:

http://marc.info/?l=linux-arm-kernel&m=123143901514438&w=2

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
