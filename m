From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Questions about fbdriver integration
Date: Sun, 25 Nov 2007 09:49:31 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711250947380.21779@anakin>
References: <20071124214325.GD3183@pruts.nl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwDBJ-0007T2-TQ for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 00:49:38 -0800
Received: from hoboe1bl1.telenet-ops.be ([195.130.137.72])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IwDBI-0007rH-Ap
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 00:49:37 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hoboe1bl1.telenet-ops.be (Postfix) with SMTP id 3CFA5D4026
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Nov 2007 09:49:32 +0100 (CET)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by hoboe1bl1.telenet-ops.be (Postfix) with ESMTP id 1F3CAD401C
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Nov 2007 09:49:32 +0100 (CET)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id lAP8nVAo002794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Nov 2007 09:49:31 +0100
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id lAP8nVEg002791
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Nov 2007 09:49:31 +0100
In-Reply-To: <20071124214325.GD3183@pruts.nl>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Sat, 24 Nov 2007, Ico Doornekamp wrote:
> I have just finished writing a framebuffer driver for a LCD display
> connected to our embedded system (monochrome, 128x64, GPIO driven).
> It's very similar to the hecubafb driver, and uses deferred IO. I've
> included some of the drivers properties at the end of this mail.  Things
> works fine when displaying images by doing write()s to /dev/fb0, so this
> part seems to be ok.
> 
> I hope some of the regulars on this list can clear up some issues
> I've run into when using this driver:
> 
> - My next step as to redirect the linux console to this framebuffer
>   device. I've configured the kernel for framebuffer console, and when
>   loading the fbcon module, the message 
>     
>      Console: switching to mono frame buffer device 16x4" 
>      
>   appears, and
> 
>      cat /sys/class/vtconsole/vtcon1/name -> (M) frame buffer device
>      cat /sys/class/vtconsole/vtcon1/bind -> 1
>   
>   This seems just fine to me, but however, no output appears on the
>   display: just a blank screen. 
> 
>   It seems that the console is doing *something*, since my driver gets
>   triggered by the deferred IO every 200msec (blinking cursor?), problem
>   is that the data arriving in my driver is all zeroes!

Fbcon writes to the memory at fb_info.screen_base.

> - The other question is more a userspace issue: I was hoping to use the
>   xorg fbdev server on my dislay, but unfortunately this does not seem
>   to support 1 bit depth displays :
> 
>     (EE) FBDEV(0): unsupported number of bits per pixel: 1
> 
>   Is there a way to make X work on 1-bit fb devices, or am I out of luck
>   here ?

The old XF86_FBDev (from XFree86 3.x) definitely works with monochrome.
I expect (but never tried) KDrive also to support it.

It's a pity many frame buffer organizations were dropped in Xorg.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
