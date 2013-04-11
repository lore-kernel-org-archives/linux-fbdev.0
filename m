From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 11 Apr 2013 05:12:18 +0000
Subject: Re: [PATCH 13/30] video/s3c: move platform_data out of arch/arm
Message-Id: <003301ce3673$23ae2f80$6b0a8e80$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-14-git-send-email-arnd@arndb.de>
In-Reply-To: <1365638712-1028578-14-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday, April 11, 2013 9:05 AM, Arnd Bergmann wrote:
> 
> The s3c-fb driver requires header files from the samsung platforms
> to find its platform_data definition, but this no longer works on
> multiplatform kernels, so let's move the data into a new header
> file under include/linux/platform_data.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Jingoo Han <jg1.han@samsung.com>
> ---
>  arch/arm/plat-samsung/include/plat/fb.h | 50 +-----------------------------
>  drivers/video/s3c-fb.c                  |  3 +-
>  include/linux/platform_data/video_s3c.h | 54 +++++++++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+), 51 deletions(-)
>  create mode 100644 include/linux/platform_data/video_s3c.h
> 

[.....]

> +struct s3c_fb_platdata {
> +	void	(*setup_gpio)(void);
> +
> +	struct s3c_fb_pd_win	*win[S3C_FB_MAX_WIN];
> +	struct fb_videomode     *vtiming;
> +
> +	u32			 vidcon0;
> +	u32			 vidcon1;
> +};
> + 

There is an unnecessary space.
When the patch is merged, this space should be removed.


Best regards,
Jingoo Han

> +#endif
> --
> 1.8.1.2

