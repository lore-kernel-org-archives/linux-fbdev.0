From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] fbdev updates.
Date: Fri, 5 Jul 2002 09:44:35 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020705094435.A23355@flint.arm.linux.org.uk>
References: <20020704000354.B4733@flint.arm.linux.org.uk> <Pine.LNX.4.44.0207042051150.4852-100000@www.transvirtual.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QOht-0001LK-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 05 Jul 2002 01:44:50 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207042051150.4852-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Thu, Jul 04, 2002 at 09:05:40PM -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Jul 04, 2002 at 09:05:40PM -0700, James Simmons wrote:
> > 2. I've no idea why you moved "lccr0" and "lccr3" in sa1100fb.h - this
> >    looks like noise to me.
> 
> Ah the idea of a par and using generic struct fb_info. A few reasons. One
> I noticed people having fields inside their struct xxxfb_info that was
> already there in the generic struct fb_info. By making a strick rule I
> hope to avoid that ugly mess. The second reason is eventually I like to
> combine DRI and the fbdev layer. This was both interfaces could use the
> same struct xxx_par. That is a 2.7 thing but I like to prepare now for
> this. For the SA1100 this is not really needed but I still like to enforce
> this rule and we still can take advantage of the nice generic functions in
> fbgen.c.

First, I detest the idea of "fix", "var", "par" and "info".  Specifically
the "par" crap.  Intensely.  "par" and "info" should be combined IMO,
which my framebuffer drivers do.

Secondly, I think you're completely confused above.  lccr0 and lccr3 have
nothing to do with some "generic struct fb_info".  They hold the base
register values for two of the SA1100 control registers.

Thirdly, you didn't delete them.  You _moved_ them within the structure.
They therefore served zero functional purpose.

Fourthly, nothing but the sa1100fb driver has any business accessing the
elements around these two both before and after the move.

In total, the change serves ZERO purpose and is therefore noise.

> > 5. I strongly disagree with your apparant decision to make the cpufreq
> >    part of the generic framebuffer core (by apparantly adding the notifier
> >    block to the core fb_info structure).  Firstly, you've broken sa1100fb.c
> >    by not including the relevant definition in fb_info (ok, so cpufreq
> >    stuff isn't in Linus' tree yet).  Secondly, it isn't something that all
> >    framebuffers require; its only required on SoC devices where the hardware
> >    designers have been stingy.  As such, we should NOT penalise the x86
> >    people by adding random useless garbage to structures that they're never
> >    going to use.
> 
> I completely agree. I'm going to remove that. Originally I thought about
> making it generic for everyone because I have seen other platforms
> (Mips Au1000 with Epson 1385 framebuffers) do something similar. Then I
> realized not everyone needs it and also it is possible that devices with
> more than one framebuffer might use the same pixclock frequency.

Ehh?  That's got nothing to do with cpufreq.  The reason we have the
cpufreq interface in sa1100fb is that the base clock rate for the LCD
controller on this chip is derived from the CPU core clock.  You change
the core clock, you have to reprogram the pixel clock divisor.

> Dumb but
> I have seen alot of cards share the accel engine and/or CRTC registers
> between two different framebuffers on the same piece of hardware. So it
> belongs in par.

Again, I think this is another misplaced reason; that's irrelevant to
cpufreq.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
