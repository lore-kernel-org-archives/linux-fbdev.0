From: Tony Lindgren <tony@atomide.com>
Subject: Re: Siemens sx1: merge framebuffer support
Date: Tue, 21 Nov 2006 16:47:25 +0000
Message-ID: <20061121164723.GB8193@atomide.com>
References: <20061118181607.GA15275@elf.ucw.cz> <20061120190404.GD4597@atomide.com> <ce55079f0611202306l3cd57e48t68fe28e7e076d39a@mail.gmail.com> <Pine.LNX.4.64.0611211503190.32103@pentafluge.infradead.org> <3a5b1be00611210734k79c81305q7b229139c2b17ef6@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1031210AbWKUQtj@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3a5b1be00611210734k79c81305q7b229139c2b17ef6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Imre Deak <imre.deak@solidboot.com>, Komal Shah <komal.shah802003@gmail.com>
Cc: James Simmons <jsimmons@infradead.org>, Vladimir <vovan888@gmail.com>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi,

* Komal Shah <komal.shah802003@gmail.com> [061121 15:35]:
> On 11/21/06, James Simmons <jsimmons@infradead.org> wrote:
> >
> >Can you post the framebufer driver to the framebuffer list. We like to do
> >peer review. Thank you :-)

It would be nice to get the framebuffer integrated. I think it would be
best if Imre submitted the patches as it's mostly his work.

Imre, do you have time to send the patches to framebuffer list? If not,
I can send them.

> >On Tue, 21 Nov 2006, Vladimir wrote:
> >
> >> 2006/11/20, Tony Lindgren <tony@atomide.com>:
> >> > * Pavel Machek <pavel@ucw.cz> [061118 18:16]:
> >> > > From: Vladimir Ananiev <vovan888@gmail.com>
> >> > >
> >> > > Framebuffer support for Siemens SX1; this is second big patch. (Third
> >> > > one will be mixer/sound support). Support is simple / pretty minimal,
> >> > > but seems to work okay (and is somehow important for a cell phone 
> >:-).
> >> >
> >> > Pushed to linux-omap. I guess you're planning to send the missing
> >> > Kconfig + Makefile patch for this?
> >> >
> >> > Also, it would be better to use omap_mcbsp_xmit_word() or
> >> > omap_mcsbsp_spi_master_xmit_word_poll() instead of OMAP_MCBSP_WRITE as
> >> > it does not do any checking that it worked. The aic23 and tsc2101
> >> > audio in linux-omap tree in general has the same problem.
> >> >
> >> > Regards,
> >> >
> >> > Tony
> >> >
> >>
> >> Hmm. McBSP3 in SX1 is used in "GPIO mode". The only line used is CLKX,
> >> so I think OMAP_MCBSP_WRITE would be enough. Am I wrong ?
> >> -
> 
> Again, framebuffer support patch is based on the omap framebuffer
> driver, which is not yet submitted to upstream/fbdevel list. sx1
> framebuffer support just fill up the hooks required by -omap fb driver
> framework.

Yes, but the framebuffer code is in pretty much ready to be sent
upstream :)

Regards,

Tony
