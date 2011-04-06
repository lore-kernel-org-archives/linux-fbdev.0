From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Apr 2011 17:01:59 +0000
Subject: Re: [PATCH v3] s3fb: add DDC support
Message-Id: <20110406170155.GF11820@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201104032236.18936.linux@rainbow-software.org> <20110404083316.GB9431@localhost> <20110404084200.GD28208@linux-sh.org> <201104041125.36404.linux@rainbow-software.org>
In-Reply-To: <201104041125.36404.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Ondrej Zajicek <santiago@crfreenet.org>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Mon, Apr 04, 2011 at 11:25:36AM +0200, Ondrej Zary wrote:
> On Monday 04 April 2011, Paul Mundt wrote:
> > On Mon, Apr 04, 2011 at 10:33:16AM +0200, Ondrej Zajicek wrote:
> > > On Sun, Apr 03, 2011 at 10:36:15PM +0200, Ondrej Zary wrote:
> > > > Add I2C support for the DDC bus and also default mode initialization by
> > > > reading monitor EDID to the s3fb driver.
> > > >
> > > > Tested on Trio64V+ (2 cards), Trio64V2/DX, Virge (3 cards),
> > > > Virge/DX (3 cards), Virge/GX2, Trio3D/2X (4 cards), Trio3D.
> > > >
> > > > Will probably not work on Trio32 - my 2 cards have DDC support in BIOS
> > > > that looks different from the other cards but the DDC pins on the VGA
> > > > connector are not connected.
> > > >
> > > > Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> > >
> > > Acked-by: Ondrej Zajicek <santiago@crfreenet.org>
> >
> > Is there much reason to leave this optional? Or are you simply waiting
> > for testing feedback from Trio32 users before default-enabling it?
> >
> > It would generally be nice to avoid these sorts of config options for a
> > specific driver if it already is quite capable of handling the
> > unsupported cases and has a reasonable fallback on defaults via the error
> > path.
> 
> If the config option is not desired, I'll remove it, I don't like it either. 
> Just did it like some other fb drivers do. The only reason why someone would 
> want to disable DDC is probably to have I2C-less kernel.
> 
Oh, that's right, i2c is one of those pain in the ass subsystems that
refuses to provide a stubbed implementation of the API for i2c disabled
systems. Lets just stick with the first version for now.
