From: James Simmons <jsimmons@infradead.org>
Subject: Re: Framebuffers and VC setup (via fbcon.c)
Date: Wed, 10 Mar 2004 18:15:57 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403101806460.24760-100000@phoenix.infradead.org>
References: <20040309143950.GS17857@lug-owl.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B18WZ-0002d8-H4
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Mar 2004 10:33:47 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B18FO-00067h-6y
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Mar 2004 10:16:02 -0800
In-Reply-To: <20040309143950.GS17857@lug-owl.de>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-fbdev-devel@lists.sourceforge.net


> This all happens on a VAX 4000 Model 46. I've already done the FB driver
> (http://cvs.sourceforge.net/viewcvs.py/linux-vax/kernel-2.5/drivers/video/vaxlcgfb.c)
> which basically works - cat'ting a properly prepared image to it
> produces a proper display output.

Wow really cool.
 
> Now I tried to bring CONFIG_VT and CONFIG_FRAMEBUFFER_CONSOLE into the
> game. However, I end up with no working FB console. No penguin image, no
> login prompt. This is because vc->vc_bottom ends up being 0, while it
> should be at around 60.

Wow. Nasty bug.

> Adding some printk()s and initcall_debug, here is what happens:
> 
>   tty_class_init()
>   chr_dev_init()
>     vaxlcgfb_init()
>   tty_init()
>     vty_init()
>       fb_console_init()
> 			"fbcon_startup: mode: VAX LCGfb"
> 			"fbcon_startup: visual: 3"
> 			"fbcon_startup: res: 1280x1024-8"
> 			"Console: switching to frame buffer device"
>   pty_init()
>   fb_console_init()
>   			"Console: switching to frame buffer device"
>   ...
>   vc_init():
>   			currcons=0, rows=64, cols=160, clear=1
> 			then colors 0..15 are set
> 
> Two things look odd to me:
> 
> 	- fb_console_init is called twice. Once from
> 	  tty_init() -> vty_init() -> fb_console_init(), second time
> 	  directly as a "normal" __init / module_init() call.

That is a bug. I have a patch to fix that.

> 	- Despite the fact that (quite late in the boot process)
> 	  vc_init() is called (with correct looking arguments), I think
> 	  it should have been called quite some time earlier. With other
> 	  (PC based) graphic cards, the machine just switches to FB mode
> 	  after the FB driver is initialized. All further output is put
> 	  there. But not here...
> 
> I haven't yet really understood how FB and console code work together,
> so it would be nice to have some hints there :)

    I'm going to have to look at your driver. Normally one of two things 
happen. Some driver have there hardware modes set by firmware and they 
can't be changed. For example VESA fbdev. In this case you lack a 
xxxfb_check_var and xxxfb_set_par function. Then fbcon doesn't attempt to 
change the hardware state but use the current one. 
  The other case is that your driver sets the hardware state. You have a 
set_check_var and a set_par function hook in struct fb_info->fbops. So the 
fbcon layer will call set_par directly for you.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
