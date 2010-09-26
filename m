From: Jonathan Corbet <corbet@lwn.net>
Date: Sun, 26 Sep 2010 21:52:07 +0000
Subject: Re: [PATCH 2/2] viafb: Add OLPC XO-1.5 port configs
Message-Id: <20100926155207.0e37d955@tpl.lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921153726.21D609D401B@zog.reactivated.net>
In-Reply-To: <20100921153726.21D609D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Sorry if I'm slow...*you* try giving talks in Germany and Japan in the
same week and we'll see how responsive you are...:)

On Sun, 26 Sep 2010 17:50:41 +0200
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> You're right, we may not only change the entry. The device code also needs to be 
> changed. The situation is like this:
> 0x2c are essentially two GPIO ports but those can be used to emulate one I2C 
> port. At the moment it is only used as I2C port with a little hack in the I2C 
> code. I believe it would be good to change it to always be a GPIO port (as that 
> is what it really is, at least for all documented IGPs) and emulate I2C on top 
> of that if needed. Sadly VIAs emulation (using 2 pins) differs from the generic 
> one in i2c-gpio.c (using 1 pin), so we can't reuse that but the emulation code 
> shouldn't be much code anyway.

When I first set up the GPIO/I2C code, I tried to configure it "the way
it's always been," in the hope of not breaking anything.  I'd always
figured that people would want to change things, which is why the code
is done the way it is.  Of course, I never got around to implementing
the configuration-time (or even runtime) selection mechanism.  But I
did always figure that OLPC would need a non-standard configuration.

Florian, I'm not sure what you're saying about changing how the ports
are used.  All of the ports are essentially the same, regardless of
what they are called; you either have two GPIOs, or you have one for
i2c data, the other for the clock.  There are some minor differences in
how the ports are programmed, but it's pretty much insignificant.

Daniel, 0x2C *has* to be GPIO on the XO - that's the power/reset pair
for the camera sensor.  That's a little non-standard; I think normal
configurations use it for (i2c) communications to the monitor.  So I
think I understand what you're seeing: if the port is i2c, the driver
tries (unsuccessfully) to talk over it, confusing the camera in the
process.  If it's GPIO, those attempts fail immediately and it moves on.

Make sense?

jon
