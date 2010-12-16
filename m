From: Anatolij Gustschin <agust@denx.de>
Date: Thu, 16 Dec 2010 17:42:02 +0000
Subject: Re: [PATCH v4 5/5] fsl-diu-fb: Support setting display mode using
Message-Id: <20101216184202.507dc2ec@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279893639-24333-1-git-send-email-agust@denx.de>
	<1279893639-24333-6-git-send-email-agust@denx.de>
	<AANLkTin-TL5_TKnyHYtZdixosfqpkPNoarSTC+K4tTUb@mail.gmail.com>
In-Reply-To: <AANLkTin-TL5_TKnyHYtZdixosfqpkPNoarSTC+K4tTUb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Thu, 16 Dec 2010 10:47:53 -0600
Timur Tabi <timur@freescale.com> wrote:

> On Fri, Jul 23, 2010 at 9:00 AM, Anatolij Gustschin <agust@denx.de> wrote:
> > Adds support for encoding display mode information
> > in the device tree using verbatim EDID block.
> >
> > If the EDID entry in the DIU node is present, the
> > driver will build mode database using EDID data
> > and allow setting the display modes from this database.
> > Otherwise display mode will be set using mode
> > entries from driver's internal database as usual.
> >
> > This patch also updates device tree bindings.
> >
> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
> > Acked-by: Timur Tabi <timur@freescale.com>
> > Cc: devicetree-discuss@lists.ozlabs.org
> 
> Anatolij,
> 
> I know this patch is old, but I'm now getting back to working on the
> DIU driver.  One question I have: why are you reading the EDID data
> from the device tree?  Why not just read it directly from the device
> using I2C?  Who is supposed to put the EDID data into the device tree
> in the first place?

Many embedded boards only hard-wire a panel which does not provide
an i2c edid channel. For such boards the EDID data can be inserted
by the bootloader or encoded in the board's .dts. Look at pdm360ng
U-Boot board code, it inserts the EDID data into device tree using
fdt_add_edid().

Anatolij
