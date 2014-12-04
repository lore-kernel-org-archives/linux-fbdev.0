From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Date: Thu, 04 Dec 2014 01:56:28 +0000
Subject: RE: [PATCHv2 0/4] LS1021A: Add dcfb framebuffer driver support.
Message-Id: <BY2PR0301MB06131C2C901351E8592ED3D89B780@BY2PR0301MB0613.namprd03.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417598162-40433-1-git-send-email-Li.Xiubo@freescale.com>
 <4810522.t9QFQYHtHI@wuerfel>
In-Reply-To: <4810522.t9QFQYHtHI@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "alexander.stein@systec-electronic.com" <alexander.stein@systec-electronic.com>

Hi Arnd,

Thanks for you advice.

Because this is very emergency for customers and have delayed for monthes, and the
DRM/KMS will have a little long time to be supported. So I'd like to add this first
and will add DRM/KMS version later.

Thanks very much,

BRs
Xiubo


> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
> owner@vger.kernel.org] On Behalf Of Arnd Bergmann
> Sent: Wednesday, December 03, 2014 5:52 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: Xiubo Li-B47053; plagnioj@jcrosoft.com; tomi.valkeinen@ti.com; linux-
> fbdev@vger.kernel.org; linux-kernel@vger.kernel.org; shawn.guo@linaro.org;
> alexander.stein@systec-electronic.com
> Subject: Re: [PATCHv2 0/4] LS1021A: Add dcfb framebuffer driver support.
> 
> On Wednesday 03 December 2014 17:15:58 Xiubo Li wrote:
> > Framebuffer driver for the Freescale SoC Display Controller.
> >
> >
> > Change in V2:
> > - Use the native-mode timing as default.
> > - Add to_fsl_private().
> 
> <standard reply>
> 
> We try to not have any new framebuffer drivers. Please consider making
> this a DRM/KMS driver instead.
> 
> </standard reply>
> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
