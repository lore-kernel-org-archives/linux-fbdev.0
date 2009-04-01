From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: Xilinx framebuffer
Date: Wed, 1 Apr 2009 19:41:38 +0200
Message-ID: <20090401194138.63d629a1.krzysztof.h1@poczta.fm>
References: <20090327105153.g55s75ug0gc8skww@correoweb.uvigo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1Lp5ME-0006Pt-PV
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Apr 2009 18:40:14 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Lp5MD-0006KV-BN for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Apr 2009 18:40:14 +0000
In-Reply-To: <20090327105153.g55s75ug0gc8skww@correoweb.uvigo.es>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: pcolodron@uvigo.es
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, 27 Mar 2009 10:51:53 +0100
pcolodron@uvigo.es wrote:

> Hi Krzysztof,
> 
> First of all, thanks for replying so fast, I was starting to think  
> that nobody could help with this...
> 
> Due to my unexperience in this field I will have to ask you some basic  
> questions. What do you mean when you say 'device definition file'? I  
> have been reading some things about platform devices and drivers but I  
> still don't know where can I find the file which defines the features  
> of my platform device.
> 

Probably you have to define the file for your platform device. Look
how it is done for ARM sa1100 platforms:

There is a common part of definition for such a platform called
arch/arm/mach-sa1100/generic.c

Inside the file there is defined a table for the sa1100fb frame buffer
(platform device):

static struct platform_device sa11x0fb_device = {
    .name       = "sa11x0-fb",
    .id     = -1,
    .dev = {
        .coherent_dma_mask = 0xffffffff,
    },
    .num_resources  = ARRAY_SIZE(sa11x0fb_resources),
    .resource   = sa11x0fb_resources,
};

The field name is used to find a platform driver so it should
be exactly the same as the name the driver is registered with
("xilinxfb" for the xilinxfb driver).

The structure is later added to table of platform devices:

static struct platform_device *sa11x0_devices[] __initdata = {
    &sa11x0udc_device,
    &sa11x0uart1_device,
    &sa11x0uart3_device,
    &sa11x0mcp_device,
    &sa11x0ssp_device,
    &sa11x0pcmcia_device,
    &sa11x0fb_device,
    &sa11x0mtd_device,
    &sa11x0rtc_device,
};

The later structure is used to register platform devices with

platform_add_devices(sa11x0_devices, ARRAY_SIZE(sa11x0_devices));

This line calls sa1100fb_probe() function indirectly. This is what is missing
in your xilinxfb handling - the probe function is not called.

> Could be the problem that I am not configuring properly the parameters  
> REG_FB_ADDR and REG_CTRL? 

No. It can be problem after the probe function is called.

> As far as I know, these values are the  
> addresses of the control registers of my TFT controller. In my case,  
> the values are 0x86e00000 and 0x86e00004. Inside the first register,  
> the starting address of the framebuffer can be found (which is  
> 0x8FC00000).

It should be set through resources settings of the platform device
table (see above)

> Is this right or should I define the parameter  
> REG_FB_ADDR as the physical address of the framebuffer directly  
> (0x8FC00000)?
> 

No.

There is one more thing for the xilinxfb driver. You have to set platform_data
field of the platform device. The xilinxfb expects this field to be a pointer to
the struct xilinxfb_platform_data. See the xilinxfb sources for this structure
definition. You should fill its fields before calling the platform_add_device(s).

Kind regards,
Krzysztof


----------------------------------------------------------------------
Twoj znajomy na stronie glownej portalu? Wkrec go! ;) 
Sprawdz >>> http://link.interia.pl/f20f2


------------------------------------------------------------------------------
