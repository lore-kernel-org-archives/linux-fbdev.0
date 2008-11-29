From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Sat, 29 Nov 2008 14:48:51 -0800
Message-ID: <200811291448.52483.david-b@pacbell.net>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com> <45a44e480811252151q54580e07xfa73d69596fbfaac@mail.gmail.com> <20081127200102.GB20443@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <20081127200102.GB20443@uranus.ravnborg.org>
Content-Disposition: inline
Sender: linux-embedded-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Sam Ravnborg <sam@ravnborg.org>, Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, Jean Delvare <khali@linux-fr.org>, Eric Miao <eric.miao@marvell.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-embedded@vger.kernel.org

On Thursday 27 November 2008, Sam Ravnborg wrote:
> > > So my "is it generic enough" question is more at the level of "Ar=
e
> > > there enough Linux systems that need this sort of thing to justif=
y
> > > generic support?". =A0I happen not to have come across the need f=
or
> > > such ganged access from Linux (yet). =A0Whereas I've yet to use n=
on-x86
> > > Linux systems that don't need to manipulate individual GPIO pins.=
=2E.
> >=20
> > I have come across the following scenarios where a bus set of gpio =
is useful:
> > - Broadsheet E-Ink controller (uses 16-bit data bus over GPIO)
> >   framebuffer device (this patch is for this)
> > - Apollo/Hecuba E-Ink controller (uses 8-bit data bus over GPIO)
> >   framebuffer device
> > - 8-bit parallel IO matrix LCD controllers, such as the Samsung KS1=
08,
> >   also Hitachi, etc

All of those can also be handled with traditional parallel data
busses too, of course.  Are you saying you've seen these used
with Linux systems?  Enough to justify generic support?

I've certainly seen how some of those LCD controllers, graphical
or character based, work with microcontrollers.  They're very
widely available too ... so I can imagine various uClinux systems
have one hooked up.  Most of the Linux system hookups I've happened
across use USB or serial links (e.g. the crystalfontz.com stuff)
since modern PCs are severely GPIO-deprived.

Another example where ganged access might help is keypad matrices.


> We have such a system at work. And we need fast acces to the gpio pin=
s
> when updating the LCD.
> I have not written/looked to deep at the code I just recall it was
> a bit messy and not something I would be proud of submitting to any M=
L.

Often times such messiness is more because the code never got
cleaned up, because it's kind of a one-off to support particular
boards.

You could say that the gpiolib implementation framework got its
start, in part, as a way to unclutter some kernel trees that
had way too much one-off stuff like that.  ;)

- Dave
