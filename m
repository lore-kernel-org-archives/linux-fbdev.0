From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 31 Jul 2010 21:42:42 +0000
Subject: Re: [PATCH 3/3] cyber2000fb: add I2C support
Message-Id: <20100731214242.GB3633@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201007312255.51139.linux@rainbow-software.org>
In-Reply-To: <201007312255.51139.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Sat, Jul 31, 2010 at 10:55:49PM +0200, Ondrej Zary wrote:
> Add I2C support for the DDC bus to cyber2000fb driver. This is only bus
> support, driver does not use EDID.
> Tested on two different CyberPro 2000 cards with i2cdetect and decode-edid.

I'm debating a bit about this.

One thing I'm concerned about is switching the DCLK registers to DCC
mode without any protection against mode changes co-inciding with
I2C activity.  On a SMP machine, it's possible for both to happen
simultaneously.

Secondly, please name these I2C bits with 'ddc' in the name - the
CyberPro appear to have more than one I2C bus on them (or can have)
such as for driving SAA7111 video decoders.
