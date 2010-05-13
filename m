From: Koen Kooi <koen@dominion.thruhere.net>
Date: Thu, 13 May 2010 16:00:27 +0000
Subject: Re: [PATCH v2 1/2] DSS2: Allow FB_OMAP2 to build without VRFB
Message-Id: <EBB422FB-C763-4EBE-AAD3-02AE86D4FF05@student.utwente.nl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1273764028-25822-1-git-send-email-svadivu@ti.com> <1273764028-25822-2-git-send-email-svadivu@ti.com>
In-Reply-To: <1273764028-25822-2-git-send-email-svadivu@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Senthilvadivu Guruswamy <svadivu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, tony@atomide.com, tomi.valkeinen@nokia.com, hvaibhav@ti.com


Op 13 mei 2010, om 17:20 heeft Senthilvadivu Guruswamy het volgende geschreven:

> FB_OMAP2 can work without VRFB, but currently does not build. Fix this.
> 
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> ---
> arch/arm/plat-omap/include/plat/vrfb.h |   16 ++++++++++++++++
> 1 file changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/vrfb.h b/arch/arm/plat-omap/include/plat/vrfb.h
> index d8a03ce..3792bde 100644
> --- a/arch/arm/plat-omap/include/plat/vrfb.h
> +++ b/arch/arm/plat-omap/include/plat/vrfb.h
> @@ -35,6 +35,7 @@ struct vrfb {
> 	bool yuv_mode;
> };
> 
> +#ifdef CONFIG_OMAP2_VRFB

That is still a compiletime option, not a runtime check. You need something like if(is_omap3()), not #ifdef 

regards,

Koen