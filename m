From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Wed, 30 Jun 2010 08:50:44 +0000
Subject: Re: [PATCH] OMAP2:OMAPFB: Fix error path
Message-Id: <1277887844.2474.122.camel@tubuntu.research.nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTilje0umiNM2Tn7p2S5xhfEbEhtj6pIuSBMKvShi@mail.gmail.com>
In-Reply-To: <AANLkTilje0umiNM2Tn7p2S5xhfEbEhtj6pIuSBMKvShi@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ext Afzal Mohammed <lazfamam@gmail.com>
Cc: "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>, "tj@kernel.org" <tj@kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

Please send the patch as plaintext, without any HTML content.

Also, use the same patch subject as other patches for omapfb, in this
case "OMAP: DSS2: OMAPFB: ...", and include a bit more verbose
description.

 Tomi


On Tue, 2010-06-29 at 22:29 +0200, ext Afzal Mohammed wrote:
> 
> 
> sysfs file removed in error path of omapfb_create_framebuffers()
> 
> 
> Signed-off-by: Afzal Mohammed <lazfamam@gmail.com>
> ---
>  drivers/video/omap2/omapfb/omapfb-main.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c
> b/drivers/video/omap2/omapfb/omapfb-main.c
> index 4b4506d..2319b81 100644
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -1945,6 +1945,7 @@ static int omapfb_create_framebuffers(struct
> omapfb2_device *fbdev)
>   r = omapfb_overlay_enable(ovl, 1);
>  
>   if (r) {
> + omapfb_remove_sysfs(fbdev);
>   dev_err(fbdev->dev,
>   "failed to enable overlay\n");
>   return r;
> -- 
> 1.7.0.4
> 
> 


