From: Jonathan Corbet <corbet@lwn.net>
Date: Wed, 06 Oct 2010 21:15:13 +0000
Subject: Re: [PATCH 2/2] viafb: Add OLPC XO-1.5 port configs
Message-Id: <20101006151513.6a06f6f4@bike.lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921153726.21D609D401B@zog.reactivated.net>
In-Reply-To: <20100921153726.21D609D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Slow response, sorry.  Happily, I'm actually done crossing oceans for a
little bit...

On Mon, 27 Sep 2010 06:55:16 +0200
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> Jon, do you claim that 0x26 and 0x31 are essentially the same as the the GPIO ports?

From a programming point of view, yes.  There may be some electrical
differences.

> After having a look at the relevant openchrome code (ViaI2C3):
> http://openchrome.org/trac/browser/trunk/src/via_i2c.c
> as well as VIAs X-Server (as far as I can decipher it) and assuming that this 
> code was tested I am confident that our code is broken (for example we never set 
> output enable back to 0). So I think we should just enable GPIO on that port as 
> I2C on it looks very broken anyway.

I'm confused...you're talking about 26/31 still?

I2c works fine on 0x31; that's how the via-camera driver talks to the
sensor.

> I plan to test whether a correct implementation can be done on top of GPIO. 

You could do that, but, if you look at what's there, that's essentially
what's done now - it's a bitbanging driver.  So I'm not quite sure what
you would change.

Sorry if I'm being slow.

jon
