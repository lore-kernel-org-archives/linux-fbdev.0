From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: [PATCH] fbdev updates.
Date: Thu, 4 Jul 2002 21:05:40 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207042051150.4852-100000@www.transvirtual.com>
References: <20020704000354.B4733@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QKM5-0003Tv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 04 Jul 2002 21:06:01 -0700
In-Reply-To: <20020704000354.B4733@flint.arm.linux.org.uk>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> 1. It would appear to break sa1100 inverse colourmap stuff.  There are LCD
>    panels out there where it is a rather fundamental requirement to write
>    the palette with "inverted" colourmap values.

Okay. Fixed.

> 2. I've no idea why you moved "lccr0" and "lccr3" in sa1100fb.h - this
>    looks like noise to me.

Ah the idea of a par and using generic struct fb_info. A few reasons. One
I noticed people having fields inside their struct xxxfb_info that was
already there in the generic struct fb_info. By making a strick rule I
hope to avoid that ugly mess. The second reason is eventually I like to
combine DRI and the fbdev layer. This was both interfaces could use the
same struct xxx_par. That is a 2.7 thing but I like to prepare now for
this. For the SA1100 this is not really needed but I still like to enforce
this rule and we still can take advantage of the nice generic functions in
fbgen.c.

> 3. I think you replaced "fbi" too many times:
> 	+/* Fake monspecs to fill in infonfo structure */

Fixed.

> 4. You're also merging in cpufreq changes from my tree in this patch;
>    however I was going to send these to Linus along with the cpufreq
>    submission so no problem.

Just what was in sa1100fb.c. I grabbed that version of the driver from
your tree sinc ethe stuff in Linus tree didn't compile at the time.

> 5. I strongly disagree with your apparant decision to make the cpufreq
>    part of the generic framebuffer core (by apparantly adding the notifier
>    block to the core fb_info structure).  Firstly, you've broken sa1100fb.c
>    by not including the relevant definition in fb_info (ok, so cpufreq
>    stuff isn't in Linus' tree yet).  Secondly, it isn't something that all
>    framebuffers require; its only required on SoC devices where the hardware
>    designers have been stingy.  As such, we should NOT penalise the x86
>    people by adding random useless garbage to structures that they're never
>    going to use.

I completely agree. I'm going to remove that. Originally I thought about
making it generic for everyone because I have seen other platforms
(Mips Au1000 with Epson 1385 framebuffers) do something similar. Then I
realized not everyone needs it and also it is possible that devices with
more than one framebuffer might use the same pixclock frequency. Dumb but
I have seen alot of cards share the accel engine and/or CRTC registers
between two different framebuffers on the same piece of hardware. So it
belongs in par.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Caffeinated soap. No kidding.
http://thinkgeek.com/sf
