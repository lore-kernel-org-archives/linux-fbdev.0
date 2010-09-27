From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 27 Sep 2010 04:55:16 +0000
Subject: Re: [PATCH 2/2] viafb: Add OLPC XO-1.5 port configs
Message-Id: <4CA023B4.6020909@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921153726.21D609D401B@zog.reactivated.net>
In-Reply-To: <20100921153726.21D609D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Jon,

Jonathan Corbet schrieb:
> Sorry if I'm slow...*you* try giving talks in Germany and Japan in the
> same week and we'll see how responsive you are...:)
> 
> On Sun, 26 Sep 2010 17:50:41 +0200
> Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
> 
>> You're right, we may not only change the entry. The device code also needs to be 
>> changed. The situation is like this:
>> 0x2c are essentially two GPIO ports but those can be used to emulate one I2C 
>> port. At the moment it is only used as I2C port with a little hack in the I2C 
>> code. I believe it would be good to change it to always be a GPIO port (as that 
>> is what it really is, at least for all documented IGPs) and emulate I2C on top 
>> of that if needed. Sadly VIAs emulation (using 2 pins) differs from the generic 
>> one in i2c-gpio.c (using 1 pin), so we can't reuse that but the emulation code 
>> shouldn't be much code anyway.
> 
> When I first set up the GPIO/I2C code, I tried to configure it "the way
> it's always been," in the hope of not breaking anything.  I'd always
> figured that people would want to change things, which is why the code
> is done the way it is.  Of course, I never got around to implementing
> the configuration-time (or even runtime) selection mechanism.  But I
> did always figure that OLPC would need a non-standard configuration.
> 
> Florian, I'm not sure what you're saying about changing how the ports
> are used.  All of the ports are essentially the same, regardless of
> what they are called; you either have two GPIOs, or you have one for
> i2c data, the other for the clock.  There are some minor differences in
> how the ports are programmed, but it's pretty much insignificant.

Jon, do you claim that 0x26 and 0x31 are essentially the same as the the GPIO ports?
I am no specialist on this but this is how I understand the GPIO pins work:
Each pin has one status, data and output enable bit. As long as output enable is
set (not set to 0) the pin is actively driven high or low depending on what is
in the data bit. Reading the status bit while output enable is set is pretty
senseless as we either read what we write or (on bus collision) the result is
undefined. Reading when output enable is not set works as expected.
In contrast I2C is defined with a bus voltage and we have only the possibility
to drive the pins low or tristated. When tristated we can read the bus (high if
no other/slave devices drives it low).
After having a look at the relevant openchrome code (ViaI2C3):
http://openchrome.org/trac/browser/trunk/src/via_i2c.c
as well as VIAs X-Server (as far as I can decipher it) and assuming that this 
code was tested I am confident that our code is broken (for example we never set 
output enable back to 0). So I think we should just enable GPIO on that port as 
I2C on it looks very broken anyway.
I plan to test whether a correct implementation can be done on top of GPIO. 
That's probably just for the get_* functions set the direction to input,
read the bit and return (maybe setting up an open drain as described in gpio.txt 
before all this), for set_* functions set the direction to output with
the desired value and return.
The only problem I have is that I probably do not have a way to actually test 
whether the end result works, but maybe I'm lucky and suddenly a device will be 
detected that currently is not.


Thanks,

Florian Tobias Schandinat
