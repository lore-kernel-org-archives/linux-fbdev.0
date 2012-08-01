From: Kukjin Kim <kgene.kim@samsung.com>
Date: Wed, 01 Aug 2012 02:14:38 +0000
Subject: RE: [PATCH V2 2/5] include/video: Add Exynos5 specific FIMD register offsets
Message-Id: <02f201cd6f8b$673b9df0$35b2d9d0$%kim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343737385-23337-1-git-send-email-l.krishna@samsung.com>
 <1343737385-23337-3-git-send-email-l.krishna@samsung.com>
In-Reply-To: <1343737385-23337-3-git-send-email-l.krishna@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Leela Krishna Amudala' <l.krishna@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, ben-linux@fluff.org, inki.dae@samsung.com, joshi@samsung.com, jg1.han@samsung.com, m.szyprowski@samsung.com

Leela Krishna Amudala wrote:
> 
> Exynos5 has VIDTCON and VIDCON registers at different offsets
> from the previous SOCs. Hence, adding the macros.
> 
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>  include/video/samsung_fimd.h |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
> index e979f42..820f190 100644
> --- a/include/video/samsung_fimd.h
> +++ b/include/video/samsung_fimd.h
> @@ -524,3 +524,10 @@
>   * 1110		-none-	 -none-	  -none-   -none-    -none-
>   * 1111		-none-	 -none-   -none-   -none-    -none-
>  */
> +
> +/*EXYNOS5 FIMD REG OFFSET */
> +#define EXYNOS5_VIDTCON0	(0x20010)
> +#define EXYNOS5_VIDTCON1	(0x20014)
> +#define EXYNOS5_VIDTCON2	(0x20018)
> +#define EXYNOS5_VIDTCON3	(0x2001C)
> +#define EXYNOS5_VIDCON1		(0x20004)
> --
> 1.7.0.4

All of EXYNOS5 SoCs including upcoming SoCs _really_ have same address like
above?

I don't think so. You need to consider its flexibility or some compatibility
when definitions are added.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

