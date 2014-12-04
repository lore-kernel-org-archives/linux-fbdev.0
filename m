From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Date: Thu, 04 Dec 2014 08:30:01 +0000
Subject: RE: [PATCHv2 0/4] LS1021A: Add dcfb framebuffer driver support.
Message-Id: <BY2PR0301MB0613ABEA1410C04CF07C1C7C9B780@BY2PR0301MB0613.namprd03.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417598162-40433-1-git-send-email-Li.Xiubo@freescale.com>
 <4810522.t9QFQYHtHI@wuerfel>
 <BY2PR0301MB06131C2C901351E8592ED3D89B780@BY2PR0301MB0613.namprd03.prod.outlook.com>
 <548016D9.6030006@ti.com>
In-Reply-To: <548016D9.6030006@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Arnd Bergmann <arnd@arndb.de>
Cc: "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "alexander.stein@systec-electronic.com" <alexander.stein@systec-electronic.com>

Hi Tomi,



> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@ti.com]
> Sent: Thursday, December 04, 2014 4:10 PM
> To: Xiubo Li-B47053; Arnd Bergmann
> Cc: plagnioj@jcrosoft.com; linux-fbdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; shawn.guo@linaro.org; alexander.stein@systec-
> electronic.com
> Subject: Re: [PATCHv2 0/4] LS1021A: Add dcfb framebuffer driver support.
> 
> Hi Xiubo,
> 
> On 04/12/14 03:56, Li.Xiubo@freescale.com wrote:
> > Hi Arnd,
> >
> > Thanks for you advice.
> >
> > Because this is very emergency for customers and have delayed for monthes,
> and the
> > DRM/KMS will have a little long time to be supported. So I'd like to add
> this first
> > and will add DRM/KMS version later.
> 
> I would also suggest to just write a drm driver for this. I don't see
> anything special in this driver that would be better supported via
> fbdev. With drm you'll get a more modern framework, and you will still
> have the same /dev/fbX device to use for legacy userspace software.
> 
> What do you mean with "delayed for months"? The first version of this
> series (that I can find) was posted less than two weeks ago.
> 

Sorry for confusing, it was delayed for other reasons internal.

I am not familiar about the DRM, and I'd like to know if the DRM driver will be
support, should I also develop the libdrm too ? Or just coding in kernel level ?
Is there any Document about how to have /dev/fbX device to use ?

If possible, I'd like this could be accept for this time. And I will add the DRM
Version later(for developing and testing will take a long time).

Thanks very much,

BRs
Xiubo


>  Tomi
> 

