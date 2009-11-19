From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 19 Nov 2009 09:13:23 +0000
Subject: Re: [PATCH 8/8] pxa: add frame buffer on pxa910 ttc_dkb platform
Message-Id: <20091119091323.GD13376@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911160135x2133c734ub15db7abc64b22a3@mail.gmail.com>
	<7c34ac520911190104n664ae2a2u31a4fdb63385da7c@mail.gmail.com>
In-Reply-To: <7c34ac520911190104n664ae2a2u31a4fdb63385da7c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, Nov 19, 2009 at 05:04:14PM +0800, Jun Nie wrote:
> > diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
> > index dbd8cfd..15e64b4 100644
> > --- a/arch/arm/mach-mmp/ttc_dkb.c
> > +++ b/arch/arm/mach-mmp/ttc_dkb.c
> > @@ -14,6 +14,8 @@
> > =A0#include <linux/mtd/mtd.h>
> > =A0#include <linux/mtd/partitions.h>
> > =A0#include <linux/mtd/onenand.h>
> > +#include <linux/delay.h>
> > +#include <video/pxa168fb.h>
> >
> > =A0#include <asm/mach-types.h>
> > =A0#include <asm/mach/arch.h>
> > @@ -21,6 +23,7 @@
> > =A0#include <mach/addr-map.h>
> > =A0#include <mach/mfp-pxa910.h>
> > =A0#include <mach/pxa910.h>
> > +#include <mach/gpio.h>

linux/gpio.h please.
