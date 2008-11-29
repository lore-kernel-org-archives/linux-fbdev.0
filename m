From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 2.6.27 1/1] gpiolib: add support for
	batch set of pins
Date: Sat, 29 Nov 2008 14:54:15 -0800
Message-ID: <200811291454.17110.david-b@pacbell.net>
References: <12276535632759-git-send-email-jayakumar.lkml@gmail.com>
	<200811252015.57870.david-b@pacbell.net>
	<45a44e480811252151q54580e07xfa73d69596fbfaac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <david-b@pacbell.net>) id 1L6YiZ-00037w-GI
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 29 Nov 2008 22:55:15 +0000
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1L6YiV-0002mQ-FN for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 29 Nov 2008 22:55:15 +0000
In-Reply-To: <45a44e480811252151q54580e07xfa73d69596fbfaac@mail.gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, linux-embedded@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Ben Gardner <bgardner@wabtec.com>, Eric Miao <eric.miao@marvell.com>, Philipp Zabel <philipp.zabel@gmail.com>, Jean Delvare <khali@linux-fr.org>, linux-fbdev-devel@lists.sourceforge.net, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.arm.linux.org.uk, Russell King <rmk@arm.linux.org.uk>

On Tuesday 25 November 2008, Jaya Kumar wrote:
> In the area of framebuffers for lower end display devices, I find this
> to be quite common.

I'd have said "display modules" myself, although I don't
currently have any Linux systems using them.  Some of
those modules use SPI, since it tends support DMA for
downloading the image data ... although admittedly those
are not the very lowest end devices.


> I have also seen this in systems such as 8-bit A2D devices, also with
> various coprocessor solutions where a smaller CPU like a msp430 or
> HC05 would clock data to the host using 8-bit gpio data.

When I hear "coprocessor" I think more like Video DSPs.  ;)

And for microcontrollers (msp430, avr8, etc) hooking up,
I've usually seen them use a serial bus (I2C, SPI, etc).

But it's also true that when data transfer rates matter,
it's faster to talk to microcontrollers using a parallel
bus than such a serial bus.  The Linux SOC it's talking
to can probably clock SPI an order of magnitude faster
than the microcontroller tolerates.  And the reason you
want a dedicated microcontroller is for predictable
(a.k.a. "realtime") monitoring tasks, which they can't
do if they're spending all their time talking to Linux.

Sounds like you're working with a bunch of semicustom
monitoring/control designs?


If you want to pursue this, I'd like to get the gpio_chip
proposal in place first:  bitmask read and write, without
forcing an "all bits are contiguous" policy.  Lightweight.

Maybe it should suffice to have a gpio_chip support the
bitmask ops, instead of just bit-at-a-time ones... so it'd
be practical to incorporate this by itself, given patches
to convert a couple gpio_chip implementations.

Then separately two more things:

 - A gpio_* interface proposal for higher-level bitmask calls.
   This is worth some discussion; the calls should clearly
   be optional (not everything will implement them), and I
   can't help but suspect <linux/bitmap.h> interfaces should
   interoperate smoothly.

 - A gpiolib based implementation, using those new gpio_chip
   methods as accelerators if they're present.  This should
   probably also be optional, even at the Kconfig level; many
   systems won't need to spend memory on these calls.

Right now you seem to have smooshed together those three
things, which probably helped get your sample driver going
faster but isn't a very good way to move forward.  Don't
assume gpiolib when defining the interface.

- Dave

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
