From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: How to implement rotation for framebuffer?
Date: Fri, 4 Apr 2008 12:34:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804041230490.24006@anakin>
References: <c656a4d20804040202g370948e2pa4d70b1f693df2cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JhjFN-0006YJ-E1 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 03:34:13 -0700
Received: from wilson.telenet-ops.be ([195.130.132.42])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JhjFL-0004Ak-Ph
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 03:34:13 -0700
In-Reply-To: <c656a4d20804040202g370948e2pa4d70b1f693df2cd@mail.gmail.com>
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
To: arun c <arun.edarath@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, 4 Apr 2008, arun c wrote:
> I am working on 2430SDP. SDP has omap2430 as the processor and it's
> display controller supports rotation of framebuffer in hardware.
> 
> I will explain the hardware rotation in brief.
> 
> 1) One Physical framebuffer is allocated in memory
> 2) This physical address ( as well as width and height) is programmed in the
>     VRFB Module (the hardware rotation engine, it stands for virtual rotated
>     frame buffer)
> 3)Then VRFB gives you 4 addresses ( virtual addresses which are
> transparent to applications)
>     VBA0      --> Address for 0 degree rotation
>     VBA90    --> Address for 90 degree rotation
>     VBA180  --> Address for 180 degree rotation
>     VBA270  --> Address for 270 degree rotation
> 
> Rotation is achieved like this
> Assume you want 90 degree rotation
> 
> Processor writes all picture data to VBA90 space and lcd reads all
> data from VBA0 space
> 
> For this kind of implementation i need to change fb_fix_screeninfo
> members (smem_start ,smem_len) and fb_info member( screen_base)
> dynamically according to degree of rotation.

Yep, that's correct.

> Please anybody suggest me  good ways to implement this kind of
> rotation in my driver or point me to some code so that i can refer and
> implement the same.

Very simple: any change of struct fb_var_screeninfo may cause a change
of fb_fix_screeninfo.

Hence if an application requests to change the rotation angle by
changing fb_var_screeninfo.rotate and issuing an FBIOPUT_VSCREENINFO
ioctl, you update your fb_fix_screeninfo and fb_info.screen_base.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
