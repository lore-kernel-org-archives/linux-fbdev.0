From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 04 Apr 2011 08:42:03 +0000
Subject: Re: [PATCH v3] s3fb: add DDC support
Message-Id: <20110404084200.GD28208@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201104032236.18936.linux@rainbow-software.org> <20110404083316.GB9431@localhost>
In-Reply-To: <20110404083316.GB9431@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zajicek <santiago@crfreenet.org>
Cc: Ondrej Zary <linux@rainbow-software.org>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Mon, Apr 04, 2011 at 10:33:16AM +0200, Ondrej Zajicek wrote:
> On Sun, Apr 03, 2011 at 10:36:15PM +0200, Ondrej Zary wrote:
> > Add I2C support for the DDC bus and also default mode initialization by
> > reading monitor EDID to the s3fb driver.
> > 
> > Tested on Trio64V+ (2 cards), Trio64V2/DX, Virge (3 cards),
> > Virge/DX (3 cards), Virge/GX2, Trio3D/2X (4 cards), Trio3D.
> > 
> > Will probably not work on Trio32 - my 2 cards have DDC support in BIOS that
> > looks different from the other cards but the DDC pins on the VGA connector
> > are not connected.
> > 
> > Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> 
> Acked-by: Ondrej Zajicek <santiago@crfreenet.org>
> 
Is there much reason to leave this optional? Or are you simply waiting
for testing feedback from Trio32 users before default-enabling it?

It would generally be nice to avoid these sorts of config options for a
specific driver if it already is quite capable of handling the
unsupported cases and has a reasonable fallback on defaults via the error
path.
