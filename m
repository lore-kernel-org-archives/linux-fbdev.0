From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 07 Apr 2011 17:01:51 +0000
Subject: Re: [PATCH v3] s3fb: add DDC support
Message-Id: <20110407170151.GE8052@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201104032236.18936.linux@rainbow-software.org>
In-Reply-To: <201104032236.18936.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Ondrej Zajicek <santiago@crfreenet.org>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Sun, Apr 03, 2011 at 10:36:15PM +0200, Ondrej Zary wrote:
> Add I2C support for the DDC bus and also default mode initialization by
> reading monitor EDID to the s3fb driver.
> 
> Tested on Trio64V+ (2 cards), Trio64V2/DX, Virge (3 cards),
> Virge/DX (3 cards), Virge/GX2, Trio3D/2X (4 cards), Trio3D.
> 
> Will probably not work on Trio32 - my 2 cards have DDC support in BIOS that
> looks different from the other cards but the DDC pins on the VGA connector
> are not connected.
> 
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> 
This no longer builds with the latest i2c changes merged, please respin
this against the current kernel and resubmit.
