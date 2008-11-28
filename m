From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Fri, 28 Nov 2008 06:47:18 +0100
Message-ID: <20081128054718.GA24440@uranus.ravnborg.org>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com> <f17812d70811251720u47bec50dt3734f5b2bb0d339@mail.gmail.com> <200811252015.57870.david-b@pacbell.net> <45a44e480811252151q54580e07xfa73d69596fbfaac@mail.gmail.com> <20081127200102.GB20443@uranus.ravnborg.org> <45a44e480811271543t1e564201k71e7697aa472618d@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-embedded-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45a44e480811271543t1e564201k71e7697aa472618d@mail.gmail.com>
Sender: linux-embedded-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, Eric Miao <eric.y.miao@gmail.com>, Eric Miao <eric.miao@marvell.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-embedded@vger.kernel.org

On Fri, Nov 28, 2008 at 07:43:31AM +0800, Jaya Kumar wrote:
> On Fri, Nov 28, 2008 at 4:01 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
> > On Wed, Nov 26, 2008 at 12:51:27AM -0500, Jaya Kumar wrote:
> >> On Tue, Nov 25, 2008 at 11:15 PM, David Brownell <david-b@pacbell.net> wrote:
> >> > On Tuesday 25 November 2008, Eric Miao wrote:
> >> >> Using a bit mask will be more generic if the GPIOs are not contiguous.
> >> >> Yet I still doubt this will be generic enough to be added to gpiolib.
> >> >
> >> > My expectation for this kind of mechanism was that systems who need
> >> > to craft another parallel bus out of GPIO pins would be doing this
> >> > with some system-specific utility functions.
> >> >
> >> > So my "is it generic enough" question is more at the level of "Are
> >> > there enough Linux systems that need this sort of thing to justify
> >> > generic support?".  I happen not to have come across the need for
> >> > such ganged access from Linux (yet).  Whereas I've yet to use non-x86
> >> > Linux systems that don't need to manipulate individual GPIO pins...
> >>
> >> I have come across the following scenarios where a bus set of gpio is useful:
> >> - Broadsheet E-Ink controller (uses 16-bit data bus over GPIO)
> >> framebuffer device (this patch is for this)
> >> - Apollo/Hecuba E-Ink controller (uses 8-bit data bus over GPIO)
> >> framebuffer device
> >> - 8-bit parallel IO matrix LCD controllers, such as the Samsung KS108,
> >> also Hitachi, etc
> >
> > We have such a system at work. And we need fast acces to the gpio pins
> > when updating the LCD.
> > I have not written/looked to deep at the code I just recall it was
> > a bit messy and not something I would be proud of submitting to any ML.
> >
> >        Sam
> >
> 
> Okay. Please help me understand in case I misunderstood. Are you
> saying the code that I posted is too messy? To me, actually I am proud
> of it. :-) But if some parts look messy, I'm happy to work on
> improving it. I will need some advice though and please advise me on
> which parts look messy.

Nope - the code we use at work is too messy. What you posted looks
much better.

	Sam
