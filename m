From: Jonathan Corbet <corbet@lwn.net>
Date: Thu, 28 Oct 2010 18:51:49 +0000
Subject: Re: [PATCH 2/2] viafb: Add OLPC XO-1.5 port configs
Message-Id: <20101028125149.14d53504@bike.lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921153726.21D609D401B@zog.reactivated.net>
In-Reply-To: <20100921153726.21D609D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, 27 Oct 2010 16:08:54 +0100
Daniel Drake <dsd@laptop.org> wrote:

> Linux currently has port 0x2C as VIA_MODE_I2C in via-core.c.
> During initialization, via-gpio.c iterates over all ports and ignores
> the ones that are not VIA_MODE_GPIO.
> So 0x2c is ignored by via-gpio since it is marked as I2C. As you point
> out, the GPIOs we need are behind 0x2c, so they are never
> probed/enabled.
> 
> Florian, the via-camera driver is in linux-next and the maintainer
> indicates it'll go to Linus within a day or 2.
> This is the last issue preventing the driver from working on XO-1.5.
> Do you have any thoughts on our next steps?

...and now it's in mainline at last.  That took rather longer than I
had expected.

I had always figured that the default settings for those ports would
not suit everybody; it was just a matter of how they could be
customized.  Options would seem to be:

 - OLPC carries a small patch which configures the port properly.

 - A set of configuration options is added allowing the port type to be
   set when the kernel is configured.

 - The ports could be changed from the default configuration with a
   boot-time command-line option.

That last option might be what works best for OLPC; those systems seem
to need several lines of special boot options anyway.  It wouldn't be
that hard to hack up...anybody got a better idea?

(Of course, option 4 is "OLPC doesn't repurpose i2c ports in strange
ways, but I figured it's a bit late for that one :)

jon
