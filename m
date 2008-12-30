From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Mon, 29 Dec 2008 16:43:03 -0800
Message-ID: <200812291643.03798.david-b@pacbell.net>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com> <200812291156.12230.david-b@pacbell.net> <20081230002023.GA5309@shareable.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <20081230002023.GA5309@shareable.org>
Content-Disposition: inline
Sender: linux-embedded-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Jamie Lokier <jamie@shareable.org>
Cc: Robin Getz <rgetz@blackfin.uclinux.org>, Jaya Kumar <jayakumar.lkml@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Eric Miao <eric.miao@marvell.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-embedded@vger.kernel.org

On Monday 29 December 2008, Jamie Lokier wrote:
> David Brownell wrote:
> > The reason single-bit operations don't provide error paths is twofold.
> > First, they started as wrappers for can't-fail register accessors.
> > Second, it's extremely unrealisitic to expect much code to handle any
> > kind of faults in the middle of bitbanging loops ... or even just in
> > classic "set this bit and continue" configuration code.
> 
> That's interesting.  I'm not sure it's a good idea not to return an
> error code.  The caller can just ignore it if they don't care, and
> it's extremely cheap to "return 0" in GPIO drivers which can't error.

I'm not sure either; at this point I *might* consider doing
it differently -- but primarily for the case of external GPIO
chips, e.g. over I2C or SPI -- where errors are realistic.  But
it's been this way for a few years now, and changing stuff
that hasn't been observed to be a problem isn't on my list.

But as I noted:  patches for $SUBJECT don't seem to have any
reason not to report whatever faults they encounter.

Also worth remembering:  when reading a GPIO value, it's not
so easy to "ignore" a tristate (0, 1, error) return value.

 
> If I were bit-banging on GPIOs reached via some peripheral chip (such
> a GPIO-fanout chip over I2C/SPI, where that chip is itself feeding a
> secondary I2C or similar bit-banging bus), I probably would like to
> check for errors and take emergency action if the peripheral chip
> isn't responding, or just report to userspace.

If I had to do that, I'd *certainly* want to bang the hardware
designer over the head with some sort of cluebat or cluebrick.  :(


> This has actually happened on a board I worked with, where the primary
> I2C failed due to a plugged in peripheral loading it too much, and a
> secondary bit-banging bus was not then reachable.

It should now be realistic for I2C device drivers to have
fault recovery logic...

But for a long time, I2c only returned -EPERM so it was
completely hopeless trying to figure out how to "handle"
any problem beyond logging the problem and hoping someone
is watching syslog output.  That's a big part of why most
current I2C drivers have such unfriendly fault handling.

- Dave



> 
> -- Jamie
> 
> 
