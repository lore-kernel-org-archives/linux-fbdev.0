From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Date: Mon, 15 Sep 2014 02:17:24 +0000
Subject: RE: [PATCH] fbdev: fsl-sii902x: HDMI support for Freescale SoCs
Message-Id: <d94bf53d85884b4da0fb4da3041e5742@BY2PR0301MB0613.namprd03.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1409892517-29816-1-git-send-email-Li.Xiubo@freescale.com>
 <5412BE19.2010302@ti.com>
In-Reply-To: <5412BE19.2010302-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org" <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "daniel.vetter-/w4YWyX8dFk@public.gmane.org" <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Tomi,

Thanks very much for your comments.


> Subject: Re: [PATCH] fbdev: fsl-sii902x: HDMI support for Freescale SoCs
> 
> Hi,
> 
> On 05/09/14 07:48, Xiubo Li wrote:
> > Some Freescale SoCs, there has an DVI/HDMI controller and a PHY,
> > attached to one of their display controller unit's LCDC interfaces.
> > This patch adds a preliminary static support for such controllers.
> >
> > This will support for many modes and a dynamic switching between
> > them.
> >
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > ---
> >  .../devicetree/bindings/video/fsl-sii902x.txt      |  17 +
> >  drivers/video/fbdev/Kconfig                        |   7 +
> >  drivers/video/fbdev/Makefile                       |   1 +
> >  drivers/video/fbdev/fsl-sii902x.c                  | 526
> +++++++++++++++++++++
> >  4 files changed, 551 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/video/fsl-sii902x.txt
> >  create mode 100644 drivers/video/fbdev/fsl-sii902x.c
> 
> I don't know how you picked the names of the people you sent this patch
> to, but looks to me that most of them are probably not interested in
> this patch.
> 

I just using the get_maintainer.pl script.


> Anyway, a few quick comments on the patch:
> 
> - You should probably use regmap instead of direct i2c calls.
> Interestingly, you define regmap variable, but you never use it.

Yes, this it's my another version in my local machine using regmap which
need much more test.

> - Use defines for register offsets, instead of magic numbers.

This will be fixed together with regmap using.

> - You should not use static variables. They prevent having multiple
> instances of the device.
> 

Okay.

> So the SiI902x chip is on the SoC, not on the board? And it's a plain
> standard SiI902x in other aspects?
> 

No, it's on board.

And it will be used for i.MX and LS1+ platforms.

Thanks,

BRs
Xiubo
