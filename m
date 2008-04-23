From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: basic FB development questions
Date: Wed, 23 Apr 2008 11:01:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804231058370.15290@anakin>
References: <200804230050.31349.cuse@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JoarZ-0007Ei-LI for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Apr 2008 02:02:01 -0700
Received: from monty.telenet-ops.be ([195.130.132.56])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JoarY-0007d2-Jf
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Apr 2008 02:02:01 -0700
In-Reply-To: <200804230050.31349.cuse@users.sourceforge.net>
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
To: Christian Schoenebeck <cuse@users.sourceforge.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 23 Apr 2008, Christian Schoenebeck wrote:
> First of all, AFAIK most FB drivers are based upon memory mapped IO, right? 
> But in my case the graphics are forwarded via calls of Linux's USB subsystem. 
> Which FB approach would suggest in this case? Something like the virtual 
> framebuffer driver with some kind of static allocated buffer? If yes, what 
> kind of function would I have to implement to trigger the screen sync between 
> that modified buffer and the hardware (that is sending the buffer's data via 
> USB to the device)? Or should I implement mmap? I mean: I know everything 
> about the USB side to recognize the device and sending data etc., I just 
> don't know how to establish a FB callback or something to "flush" the 
> suggested graphics buffer.

Documentation/fb/deferred_io.txt

> In the "fb_var_screeninfo" struct there are the following members which I'm 
> not sure about their precise purpose:
> 
> 	* "pixclock": is that the average speed (in ps) with which one pixel of the
> 	  screen is changed?

It's the inverse of the dot clock (in Hz).

> 	* "left_margin", "right_margin", "upper_margin", "lower_margin":
> 	  I'm confused about these members, I first thought that would be some kind
> 	  of reference margin (in pixels), but the header file says those are timing
> 	  values?
> 
> 	* "hsync_len", "vsync_len":
> 	  what's that exactly and is it a timing or pixel value?
> 
> If there are basic docs about FB terms etc, please let me know!

Documentation/fb/framebuffer.txt, section 5. Video Mode Timings.

But if your screen is 100% digital, they may not matter at all, and
zeroes are OK for the margins and sync lengths.

IIRC, fbset doesn't like pixclock being zero, so you should fill in
something.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
