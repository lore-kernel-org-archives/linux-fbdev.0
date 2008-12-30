From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for batch set of pins
Date: Tue, 30 Dec 2008 00:20:23 +0000
Message-ID: <20081230002023.GA5309@shareable.org>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com> <45a44e480812270655u10bde0d2mc7f429cf47ed7bc6@mail.gmail.com> <200812281346.56703.rgetz@blackfin.uclinux.org> <200812291156.12230.david-b@pacbell.net>
Mime-Version: 1.0
Return-path: <linux-embedded-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200812291156.12230.david-b@pacbell.net>
Sender: linux-embedded-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Brownell <david-b@pacbell.net>
Cc: Robin Getz <rgetz@blackfin.uclinux.org>, Jaya Kumar <jayakumar.lkml@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Eric Miao <eric.miao@marvell.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-embedded@vger.kernel.org

David Brownell wrote:
> The reason single-bit operations don't provide error paths is twofold.
> First, they started as wrappers for can't-fail register accessors.
> Second, it's extremely unrealisitic to expect much code to handle any
> kind of faults in the middle of bitbanging loops ... or even just in
> classic "set this bit and continue" configuration code.

That's interesting.  I'm not sure it's a good idea not to return an
error code.  The caller can just ignore it if they don't care, and
it's extremely cheap to "return 0" in GPIO drivers which can't error.

If I were bit-banging on GPIOs reached via some peripheral chip (such
a GPIO-fanout chip over I2C/SPI, where that chip is itself feeding a
secondary I2C or similar bit-banging bus), I probably would like to
check for errors and take emergency action if the peripheral chip
isn't responding, or just report to userspace.

This has actually happened on a board I worked with, where the primary
I2C failed due to a plugged in peripheral loading it too much, and a
secondary bit-banging bus was not then reachable.

-- Jamie
