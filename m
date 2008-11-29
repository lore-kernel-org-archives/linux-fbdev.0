From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Sun, 30 Nov 2008 07:33:50 +0800
Message-ID: <45a44e480811291533ve0218dcvf07666064cb94d47@mail.gmail.com>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com>
	 <45a44e480811252151q54580e07xfa73d69596fbfaac@mail.gmail.com>
	 <20081127200102.GB20443@uranus.ravnborg.org>
	 <200811291448.52483.david-b@pacbell.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <200811291448.52483.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-embedded-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: David Brownell <david-b@pacbell.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, Eric Miao <eric.y.miao@gmail.com>, Eric Miao <eric.miao@marvell.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-embedded@vger.kernel.org

Jean emailed me saying he didn't want to be CCed.

On Sun, Nov 30, 2008 at 6:48 AM, David Brownell <david-b@pacbell.net> wrote:
> On Thursday 27 November 2008, Sam Ravnborg wrote:
>> > > So my "is it generic enough" question is more at the level of "Are
>> > > there enough Linux systems that need this sort of thing to justify
>> > > generic support?".  I happen not to have come across the need for
>> > > such ganged access from Linux (yet).  Whereas I've yet to use non-x86
>> > > Linux systems that don't need to manipulate individual GPIO pins...
>> >
>> > I have come across the following scenarios where a bus set of gpio is useful:
>> > - Broadsheet E-Ink controller (uses 16-bit data bus over GPIO)
>> >   framebuffer device (this patch is for this)
>> > - Apollo/Hecuba E-Ink controller (uses 8-bit data bus over GPIO)
>> >   framebuffer device
>> > - 8-bit parallel IO matrix LCD controllers, such as the Samsung KS108,
>> >   also Hitachi, etc
>
> All of those can also be handled with traditional parallel data
> busses too, of course.  Are you saying you've seen these used
> with Linux systems?  Enough to justify generic support?

Assuming I've understood you correctly about generic support, yes. I
used the 3 above with Linux arm systems that were interfaced to them
via gpio. The matrix displays had just 128x64 so the 8x gpio_set_value
penalty wasn't a biggie. The E-Ink displays range from 800x600 to
1200x826 so the 16x gpio_set_value became a bottleneck. In terms of
generic support, the Broadsheet display controller is also used on
i.MX31 and SC2410/2440 boards so those platform drivers (assuming
those good folks submit them, (i've only written and submitted
am300epd.c)) should also benefit.

Thanks,
jaya
