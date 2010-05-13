From: Nishanth Menon <nm@ti.com>
Date: Thu, 13 May 2010 15:30:13 +0000
Subject: Re: [PATCH v2 1/2] DSS2: Allow FB_OMAP2 to build without VRFB
Message-Id: <4BEC1B05.3040500@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1273764028-25822-1-git-send-email-svadivu@ti.com> <1273764028-25822-2-git-send-email-svadivu@ti.com>
In-Reply-To: <1273764028-25822-2-git-send-email-svadivu@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Senthilvadivu Guruswamy <svadivu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

Senthilvadivu Guruswamy had written, on 05/13/2010 10:20 AM, the following:
> FB_OMAP2 can work without VRFB, but currently does not build. Fix this.
> 
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/vrfb.h |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/vrfb.h b/arch/arm/plat-omap/include/plat/vrfb.h
> index d8a03ce..3792bde 100644
> --- a/arch/arm/plat-omap/include/plat/vrfb.h
> +++ b/arch/arm/plat-omap/include/plat/vrfb.h
> @@ -35,6 +35,7 @@ struct vrfb {
>  	bool yuv_mode;
>  };
>  
> +#ifdef CONFIG_OMAP2_VRFB
>  extern int omap_vrfb_request_ctx(struct vrfb *vrfb);
>  extern void omap_vrfb_release_ctx(struct vrfb *vrfb);
>  extern void omap_vrfb_adjust_size(u16 *width, u16 *height,
> @@ -47,4 +48,19 @@ extern void omap_vrfb_setup(struct vrfb *vrfb, unsigned long paddr,
>  extern int omap_vrfb_map_angle(struct vrfb *vrfb, u16 height, u8 rot);
>  extern void omap_vrfb_restore_context(void);
>  
> +#else
> +static inline int omap_vrfb_request_ctx(struct vrfb *vrfb) { return 0; }
> +static inline void omap_vrfb_release_ctx(struct vrfb *vrfb) {}
> +static inline void omap_vrfb_adjust_size(u16 *width, u16 *height,
> +		u8 bytespp) {}
> +static inline u32 omap_vrfb_min_phys_size(u16 width, u16 height, u8 bytespp)
> +		{ return 0; }
> +static inline u16 omap_vrfb_max_height(u32 phys_size, u16 width, u8 bytespp)
> +		{ return 0; }
> +static inline void omap_vrfb_setup(struct vrfb *vrfb, unsigned long paddr,
> +		u16 width, u16 height, unsigned bytespp, bool yuv_mode) {}
> +static inline int omap_vrfb_map_angle(struct vrfb *vrfb, u16 height, u8 rot)
> +		{ return 0; }
> +static inline void omap_vrfb_restore_context(void) {}
> +#endif
>  #endif /* __VRFB_H */

the core of the problem not solved: How do we handle the same kernel 
bootup on OMAP3(vrfb) and OMAP4(tiler) if it is compile time decided?

-- 
Regards,
Nishanth Menon
