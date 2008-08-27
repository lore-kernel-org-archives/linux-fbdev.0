From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: Bug in atmel_lcdfb_set_par
Date: Wed, 27 Aug 2008 12:38:47 +0200
Message-ID: <20080827123847.5171609d@hskinnemo-gx745.norway.atmel.com>
References: <652951.99866.qm@web51603.mail.re2.yahoo.com>
	<48B5237A.6010000@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYIRC-0008EG-56 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 03:39:42 -0700
Received: from smtpeu1.atmel.com ([195.65.72.27] helo=bagnes.atmel.com)
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1KYIRA-00021a-Ao
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 03:39:42 -0700
In-Reply-To: <48B5237A.6010000@yahoo.es>
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
To: Hein_Tibosch <hein_tibosch@yahoo.es>
Cc: linux-fbdev-devel@lists.sourceforge.net, kernel@avr32linux.org, rice_burners_suck@yahoo.com

[added linux-fbdev-devel and the maintainer to Cc]

Hein_Tibosch <hein_tibosch@yahoo.es> wrote:
> Nathaniel G H wrote:
> > Hi all,
> >
> > I encountered a bug in atmel_lcdfb_set_par(), in drivers/video/atmel_lcdfb.c. The function incorrectly sets BYPASS (bit 0 of LCDCON1) when the required pixel clock frequency is half that of the LCDC core clock.
> >
> > LCDCON1 contains a 9-bit field called CLKVAL, which is used to divide the LCDC core clock to obtain the pixel clock. A value of 0 means divide by 2. The BYPASS can be set if division is undesired. Quoth the data sheet, page 843:
> >
> > 	Pixel_clock = LCDC_Core_Clock / ((CLKVAL + 1) * 2)
> >
> > The bug made it impossible to divide in half. The code snippet below shows the fix: Changing <= to < in the conditional statement.
> >
> > 	clk_value_khz = clk_get_rate(sinfo->lcdc_clk) / 1000;
> >
> > 	value = DIV_ROUND_UP(clk_value_khz, PICOS2KHZ(info->var.pixclock));
> > 	value = (value / 2) - 1;
> >   
> 
> I wonder why it should be rounded up? If I try to get a V-freq of 60, I mean "at least" 60 Hz

Hmm...good point. What's the proper way of rounding these things? Down?
Nearest value?

Is there any way to check it against max/min values for the monitor?

> > 	dev_dbg(info->device, "* programming CLKVAL = 0x%08lx\n", value);
> >
> > 	if (value < 0) { /* was <= by mistake */
> > 
> 
> I think so too, value==0 would give a proper divider

Indeed.

> I wonder about the following:
> 
> My GTF or CVT calculates that I need a pixel clock of 61.25 MHz.
> As I have PLL1 dedicated for the LCD, I give it a frequency of 62 MHz.
> Now atmel_lcdfb complains that "61250 KHz pixel clock is too fast".
> Ok, as I'm using 24 bpp, I'll give it 3 times more: 184 MHz to PLL1.
> atmel_lcdfb is satisfied but finds a divisor of 4, making a poor pixel-clock of 46 MHz.

Hmm...the rate of PLL1 really shouldn't matter. It is supposed to
refuse any setting that would use more than half the RAM bandwidth or
something, which is determined by the HSB/AHB clock.

The reason it didn't complain is probably because the pixel clock rate
ended up much lower.

We could of course remove that limitation, but I think it makes sense
-- if you break that limit, you'll probably see lots of underruns, and
your system will seem pretty slow in general.

On the other hand, if you have a fast, dedicated RAM, the limitation
doesn't make much sense.

> I can also round it DOWN and get an effective divisor of 2, but then my monitor will complain about VSYNC which is much too high
> 
> What to do?

Use the original PLL1 rate, but increase the HSB rate and/or reduce the
bpp.

Haavard

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
