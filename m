From: Daniel Drake <dsd@laptop.org>
Date: Sun, 26 Sep 2010 15:57:17 +0000
Subject: Re: [PATCH 2/2] viafb: Add OLPC XO-1.5 port configs
Message-Id: <AANLkTikHrJoBR_kiKfLG0M9Wfb4K-rUR2=0FqGzU1JwJ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921153726.21D609D401B@zog.reactivated.net>
In-Reply-To: <20100921153726.21D609D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 26 September 2010 16:50, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
> You're right, we may not only change the entry. The device code also needs
> to be changed. The situation is like this:
> 0x2c are essentially two GPIO ports but those can be used to emulate one I2C
> port. At the moment it is only used as I2C port with a little hack in the
> I2C code. I believe it would be good to change it to always be a GPIO port
> (as that is what it really is, at least for all documented IGPs) and emulate
> I2C on top of that if needed. Sadly VIAs emulation (using 2 pins) differs
> from the generic one in i2c-gpio.c (using 1 pin), so we can't reuse that but
> the emulation code shouldn't be much code anyway.
> I hope that this change is simple enough to get it right without testing as
> I don't have any device with a I2C device on port 0x2c.
> But I hope we can get a bit faster than 2.5 seconds.

Either way, we need to change it for the XO-1.5 for camera and DCON support.

Would it be possible to take something similar to the patch that I
posted earlier, until the changes you describe above are made?

Thanks,
Daniel
