From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 21 Apr 2017 09:33:13 +0000
Subject: Re: [PATCH 1/2 v3 resend] video: fbdev: imxfb: support AUS mode
Message-Id: <7991281.N2SBFgRzh8@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1488193030-13064-1-git-send-email-martin@kaiser.cx>
        <CGME20170421074622epcas3p1a7c713728386d1ac175bd8104867ffd0@epcas3p1.samsung.com>
        <1492760753-8374-1-git-send-email-martin@kaiser.cx>
In-Reply-To: <1492760753-8374-1-git-send-email-martin-XxZfDwE/svGeZLLa646FqQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Kaiser <martin-XxZfDwE/svGeZLLa646FqQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Hi,

On Friday, April 21, 2017 09:45:52 AM Martin Kaiser wrote:
> Some displays require setting AUS mode in the LDCD AUS Mode Control
> Register to work with the imxfb driver. Like the value of the Panel
> Configuration Register, the AUS mode setting depends on the display
> mode.
> 
> Allow setting AUS mode from the device tree by adding a boolean
> property. Make this property optional to keep the DT ABI stable.
> AUS mode can be set only on imx21 and compatible chipsets.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> re-sending v3, rebased against current linux-next
> it seems this got lost along the way, there was a bit of confusion
> whether to split this in two patches or not

It hadn't been lost, I've been waiting on v4, please see:

https://lkml.org/lkml/2017/3/15/709

[ Rob has requested rename of the property to "fsl,aus-mode". ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

