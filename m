From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Date: Wed, 24 Sep 2014 06:45:00 +0000
Subject: RE: [PATCH] fbdev: fsl-sii902x: HDMI support for Freescale SoCs
Message-Id: <7076eb85d2e547d2a287c195725a0bb4@BY2PR0301MB0613.namprd03.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1409892517-29816-1-git-send-email-Li.Xiubo@freescale.com>
 <5412BE19.2010302@ti.com>
 <d94bf53d85884b4da0fb4da3041e5742@BY2PR0301MB0613.namprd03.prod.outlook.com>
 <541C3371.8080100@ti.com>
In-Reply-To: <541C3371.8080100-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org" <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "daniel.vetter-/w4YWyX8dFk@public.gmane.org" <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi,


[...]
> >>>  4 files changed, 551 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/video/fsl-
> sii902x.txt
> >>>  create mode 100644 drivers/video/fbdev/fsl-sii902x.c
> >>
> >> I don't know how you picked the names of the people you sent this patch
> >> to, but looks to me that most of them are probably not interested in
> >> this patch.
> >>
> >
> > I just using the get_maintainer.pl script.
> 
> Yes, and that's good, but you have to use your judgment also.
> get_maintainer.pl gives you names of people who have at some point
> touched the files or directories you are changing. Usually only the
> first names returned by get_maintainer.pl are relevant.
> 
Okay :)


> >> Anyway, a few quick comments on the patch:
> >>
> >> - You should probably use regmap instead of direct i2c calls.
> >> Interestingly, you define regmap variable, but you never use it.
> >
> > Yes, this it's my another version in my local machine using regmap which
> > need much more test.
> >
> >> - Use defines for register offsets, instead of magic numbers.
> >
> > This will be fixed together with regmap using.
> 
> Well, it's better to send the patch only when you have tested and
> cleaned up your driver.
> 
> >> - You should not use static variables. They prevent having multiple
> >> instances of the device.
> >>
> >
> > Okay.
> >
> >> So the SiI902x chip is on the SoC, not on the board? And it's a plain
> >> standard SiI902x in other aspects?
> >>
> >
> > No, it's on board.
> >
> > And it will be used for i.MX and LS1+ platforms.
> 
> Ok. In that case, I would suggest you to move to the DRM framework. The
> fbdev framework is not suited to adding external encoders. The end
> result with fbdev will be a SoC/board specific hack driver.
> 
> That said, we already have such drivers for fbdev, so I'm not 100%
> against adding a new one. But I'm very very seriously recommending
> moving to DRM.
> 
> And if this driver is added to fbdev, I think the device tree bindings
> should use the video ports/endpoints to describe the connections.
>
I will have a try to use the DRM framework.

Thanks,

BRs
Xiubo
 
>  Tomi
> 

