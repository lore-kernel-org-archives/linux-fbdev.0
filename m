From: Ondrej Zary <linux@rainbow-software.org>
Date: Sun, 03 Aug 2014 16:13:10 +0000
Subject: Re: Question on s3fb DDC support
Message-Id: <201408031813.11000.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140803144236.0494b47a@endymion.delvare>
In-Reply-To: <20140803144236.0494b47a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sunday 03 August 2014 18:03:31 Jean Delvare wrote:
> Hi Geert,
>
> On Sun, 3 Aug 2014 16:47:17 +0200, Geert Uytterhoeven wrote:
> > On Sun, Aug 3, 2014 at 2:42 PM, Jean Delvare <jdelvare@suse.de> wrote:
> > > I am looking at the DDC / I2C implementation in that driver and I'm not
> > > sure I understand how it works. Specifically I am wondering about bit
> > > DDC_DRIVE_EN. It is set unconditionally in s3fb_ddc_setscl() and
> > > s3fb_ddc_setsda() and never cleared explicitly. If this bit is a
> > > regular bit then I don't understand why it is not just set at driver
> > > initialization time. Or is this bit self-clearing and/or not-sticking?
> > >
> > > The reason why I am asking is that I don't think the code in these
> > > functions is completely correct. For the I2C protocol, 1 is the natural
> > > state of both lines and the devices on the bus should only ever pull
> > > the lines low to force a 0 state. They should never force a 1 state, as
> > > this breaks some protocol features (specifically arbitration and clock
> > > stretching.) My interpretation of the current code is that the lines
> > > are forced to both 0 and 1 by the master, which is not correct. But as
> > > I don't know how DDC_DRIVE_EN works, I'm not sure, and if it's indeed
> > > broken [1], I'm also not sure how to fix it.
> > >
> > > So if you could clarify how bit DDC_DRIVE_EN works, that would be
> > > great.
> >
> > http://www.vgamuseum.info/images/stories/doc/s3/virge.pdf, p. 24-11:
> >
> > Bit 0 SCW - Serial Clock Write
> > 0 = Pin 205 is driven low
> > 1 = Pin 205 is tri-stated
> > Pin 205 carries the DDC/I 2 C clock, depending on the operational
> > mode. When pin 205
> > is tri-stated, other devices may drive this line. The actual state of
> > the pin is read via
> > bit 2 of this register.
> > Bit 1 SDW - Serial Data Write
> > 0 = Pin 206 is driven low
> > 1 = Pin 206 is tri-stated
> > Pin 206 carries the DDC/I 2 C data, depending on the operational mode.
> > When pin 206
> > is tri-stated, other devices may drive this line. The actual state of
> > the pin is read via
> > bit 3 of this register.
> > Bit 2 SCR - Serial Clock Read (Read Only)
> > 0 = Pin 205 is low
> > 1 = Pin 205 is tri-stated (no device is driving this line)
> > Bit 3 SDR - Serial Data Read (Read Only)
> > 0 = Pin 206 is low
> > 1 = Pin 206 is tri-stated (no device is driving this line)
> > Bit 4 SPE - Serial Port Enable
> > 0 = Use of bits 1-0 of this register disabled
> > 1 = Use of bits 1-0 of this register enabled
> >
> > Still doesn't explain well the real meaning of bit 4, but it does confirm
> > that writing a 1 to bit 0 or bit 1 doesn't drive the line high.
>
> Very nice, thanks for the documentation. So the driver code looks
> correct and I can move on to the remaining two suspect drivers (intelfb
> and i740fb.)

The i740fb code is also my work - and done the same way without any docs.

-- 
Ondrej Zary
