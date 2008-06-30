From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 1/13] viafb: viafb.modes, viafb.txt
Date: Mon, 30 Jun 2008 12:46:28 +0200
Message-ID: <20080630124628.194b782f@neptune.home>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E7705@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KDGu6-0002Po-FX for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 03:46:38 -0700
Received: from [158.64.110.117] (helo=bonbons.gotdns.org)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KDGu4-0005lY-NV
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 03:46:38 -0700
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E7705@exchtp03.taipei.via.com.tw>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: JosephChan@via.com.tw
Cc: geert@linux-m68k.org, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Mon, 30 June 2008 <JosephChan@via.com.tw> wrote:
> diff -Nur a/Documentation/fb/viafb.txt b/Documentation/fb/viafb.txt
> --- a/Documentation/fb/viafb.txt	1970-01-01 08:00:00.000000000
> +0800 +++ b/Documentation/fb/viafb.txt	2009-01-02 16:28:20.000000000 +0800
> [...]
> +[Using the viafb module]
> +-- -- --------------------
> +    Start viafb with default settings:
> +        #modprobe viafb
> +
> +    Start viafb with with user options:
> +        #modprobe viafb viafb_mode=800x600 via_fb_bpp=16 viafb_refresh=60 
> +                  viafb_active_dev=CRT+DVI viafb_dvi_port=DVP1
> +                  viafb_mode1=1024x768 via_fb_bpp=16 viafb_refresh1=60
> +                  viafb_SAMM_ON=1 
> +
> +    viafb_mode:
> +        640x480 (default)
> +        720x480 
> +        800x600 
> +        1024x768
> +        ......
> +
> +    via_fb_bpp:
> +        8, 16, 32 (default:32)
> +
> +    viafb_refresh:
> +        60, 75, 85, 100, 120 (default:60)
> +
> [...]
Is there a specific reason why some module options start with via_fb_
and others with viafb_?


> +[Building viafb as a built - in driver on Linux kernel 2.6.xx]
> +--------------------------------------------------------------
> +    Step 1: Get kernel source and put them under /usr/src/linux 
> +    Step 2: Copy FBDev to proper location.
> +            # cp -a FBDev /usr/src/linux/drivers/video/via
> +    Step 3: Modify Makefile and Kconfig under /usr/src/linux/drivers/video:
> +        add line to Makefile
> +	        "obj-$(CONFIG_FB_VIA)              += via/"
> +
> +        add below lines to Kconfig
> +           config FB_VIA
> +               tristate "VIA UniChrome (Pro) and Chrome9 display support"
> +               depends on FB && PCI 
> +               select FB_CFB_FILLRECT 
> +               select FB_CFB_COPYAREA
> +               select FB_CFB_IMAGEBLIT 
> +               select FB_SOFT_CURSOR 
> + 
> +           help
> +               This is the frame buffer device driver for Graphics
> +               chips of VIA UniChrome Family(CLE266, PM800 / CN400 / CN300,
> +                                             P4M800CE / P4M800Pro / CN700,
> +                                             VN800 / CX700 / VX700, K8M890,
> +                                             P4M890 / CN896 / P4M900, VX800)
> +               Say Y if you have a VIA UniChrome graphics board. To compile
> +               this driver as a module, choose M here: the module will be
> +               called viafb.
This section can be dropped, the patch series aiming to merge viafb into
mainline tree. (the patch series does this already)

-
Bruno

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
