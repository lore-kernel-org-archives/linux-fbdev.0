From: Daniel Drake <dsd@laptop.org>
Date: Wed, 27 Oct 2010 15:08:54 +0000
Subject: Re: [PATCH 2/2] viafb: Add OLPC XO-1.5 port configs
Message-Id: <AANLkTi=mypMUYKz183Ox4oM9YVFkAdJVU7jPeEnB47i0@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921153726.21D609D401B@zog.reactivated.net>
In-Reply-To: <20100921153726.21D609D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On 26 September 2010 22:52, Jonathan Corbet <corbet@lwn.net> wrote:
> Daniel, 0x2C *has* to be GPIO on the XO - that's the power/reset pair
> for the camera sensor. =A0That's a little non-standard; I think normal
> configurations use it for (i2c) communications to the monitor. =A0So I
> think I understand what you're seeing: if the port is i2c, the driver
> tries (unsuccessfully) to talk over it, confusing the camera in the
> process. =A0If it's GPIO, those attempts fail immediately and it moves on.

You may be right, but I've identified a more prominent reason why
via-camera fails to initialize:

Linux currently has port 0x2C as VIA_MODE_I2C in via-core.c.
During initialization, via-gpio.c iterates over all ports and ignores
the ones that are not VIA_MODE_GPIO.
So 0x2c is ignored by via-gpio since it is marked as I2C. As you point
out, the GPIOs we need are behind 0x2c, so they are never
probed/enabled.

Florian, the via-camera driver is in linux-next and the maintainer
indicates it'll go to Linus within a day or 2.
This is the last issue preventing the driver from working on XO-1.5.
Do you have any thoughts on our next steps?

Thanks,
Daniel
