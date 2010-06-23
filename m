From: Koen Kooi <koen@dominion.thruhere.net>
Date: Wed, 23 Jun 2010 07:40:27 +0000
Subject: Re: [PATCH] OMAP: DSS2: DMA optimization using scaler line buffers
Message-Id: <4A679826-6BE6-4C52-BAF4-29CA3D5BF7EA@student.utwente.nl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <FF55437E1F14DA4BAEB721A458B6701706BDA5F45D@dbde02.ent.ti.com>
In-Reply-To: <FF55437E1F14DA4BAEB721A458B6701706BDA5F45D@dbde02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Nagarajan, Rajkumar" <x0133774@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>


Op 23 jun 2010, om 07:18 heeft Nagarajan, Rajkumar het volgende geschreven:

> 
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -552,7 +552,7 @@ static int setup_vrfb_rotation(struct fb_info *fbi)
> 	omap_vrfb_setup(&rg->vrfb, rg->paddr,
> 			var->xres_virtual,
> 			var->yres_virtual,
> -			bytespp, yuv_mode);
> +			bytespp, mode, 0);

Shouldn't that be 'color_mode' instead of 'mode'?

regards,

Koen
