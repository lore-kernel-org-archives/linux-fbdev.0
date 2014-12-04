From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Date: Thu, 04 Dec 2014 09:54:08 +0000
Subject: RE: [PATCHv2 0/4] LS1021A: Add dcfb framebuffer driver support.
Message-Id: <BY2PR0301MB061372E00518F169BCF2FFFA9B780@BY2PR0301MB0613.namprd03.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417598162-40433-1-git-send-email-Li.Xiubo@freescale.com>
 <4810522.t9QFQYHtHI@wuerfel>
 <BY2PR0301MB06131C2C901351E8592ED3D89B780@BY2PR0301MB0613.namprd03.prod.outlook.com>
 <548016D9.6030006@ti.com>
 <BY2PR0301MB0613ABEA1410C04CF07C1C7C9B780@BY2PR0301MB0613.namprd03.prod.outlook.com>
 <548024C7.3060004@ti.com>
In-Reply-To: <548024C7.3060004@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "alexander.stein@systec-electronic.com" <alexander.stein@systec-electronic.com>

Hi Tomi,

Thanks for your information very much.

> > Sorry for confusing, it was delayed for other reasons internal.
> >
> > I am not familiar about the DRM, and I'd like to know if the DRM driver will
> be
> > support, should I also develop the libdrm too ? Or just coding in kernel
> level ?
> 
> For simple drm drivers (this looks like it would be a simple one), I
> don't think there's any need for libdrm support. The generic DRM
> interfaces should be enough, so just kernel level coding needed.
> 

That's to say, if I am using the X11 server without any code in usrspace,
If the DRM driver will support /dev/fbX, it could work correctly ?

Thanks,

BRs
Xiubo




