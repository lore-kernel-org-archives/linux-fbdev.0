From: Ben Dooks <ben@simtec.co.uk>
Date: Fri, 02 Jul 2010 13:16:01 +0000
Subject: Re: [PATCH v3 09/12] s3c-fb: Correct window osd size and alpha register
Message-Id: <4C2DE691.6050209@simtec.co.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1277712538-23188-1-git-send-email-p.osciak@samsung.com>
	<1277712538-23188-10-git-send-email-p.osciak@samsung.com>
In-Reply-To: <1277712538-23188-10-git-send-email-p.osciak@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 28/06/10 09:08, Pawel Osciak wrote:
> S3C64xx and S5P OSD registers for OSD size and alpha are as follows:
> VIDOSDC: win 0 - size, win 1-4: alpha
> VIDOSDD: win 1-2 - size; not present for windows 0, 3 and 4
> 
> Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/video/s3c-fb.c |   58 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 51 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index 94423c5..3b2c7fe 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -64,6 +64,9 @@ struct s3c_fb;
>  #define VIDOSD_B(win, variant) (OSD_BASE(win, variant) + 0x04)
>  #define VIDOSD_C(win, variant) (OSD_BASE(win, variant) + 0x08)
>  #define VIDOSD_D(win, variant) (OSD_BASE(win, variant) + 0x0C)
> +#define VIDOSD_SIZE(win, variant, win_variant) \
> +	(OSD_BASE(win, variant) + (win_variant).osd_size_off)
> +#define VIDOSD_ALPHA(win, variant, win_variant) VIDOSD_C(win, variant)

hmm, this is becoming a bit complicated. if we have a function to
set it then maybe we should just calculate it there.

>  /**
>   * struct s3c_fb_variant - fb variant information
> @@ -112,7 +115,10 @@ struct s3c_fb_variant {
>  struct s3c_fb_win_variant {
>  	unsigned int	has_osd_c:1;
>  	unsigned int	has_osd_d:1;
> +	unsigned int	has_osd_size:1;
> +	unsigned int	has_osd_alpha:1;
>  	unsigned int	palette_16bpp:1;
> +	unsigned short	osd_size_off;
>  	unsigned short	palette_sz;
>  	u32		valid_bpp;
>  };
> @@ -365,6 +371,36 @@ static int s3c_fb_align_word(unsigned int bpp, unsigned int pix)
>  }
>  
>  /**
> + * vidosd_set_size() - set OSD size for a window
> + *
> + * @win: the window to set OSD size for
> + * @size: OSD size register value
> + */
> +static void vidosd_set_size(struct s3c_fb_win *win, u32 size)
> +{
> +	struct s3c_fb *sfb = win->parent;
> +
> +	if (win->variant.has_osd_size)
> +		writel(size, sfb->regs + VIDOSD_SIZE(win->index, sfb->variant,
> +							win->variant));
> +}
> +
> +/**
> + * vidosd_set_alpha() - set alpha transparency for a window
> + *
> + * @win: the window to set OSD size for
> + * @alpha: alpha register value
> + */
> +static void vidosd_set_alpha(struct s3c_fb_win *win, u32 alpha)
> +{
> +	struct s3c_fb *sfb = win->parent;
> +
> +	if (win->variant.has_osd_alpha)
> +		writel(alpha, sfb->regs + VIDOSD_ALPHA(win->index,
> +						sfb->variant, win->variant));
> +}
> +
> +/**
>   * shadow_protect_win() - disable updating values from shadow registers at vsync
>   *
>   * @win: window to protect registers for
> @@ -408,7 +444,7 @@ static int s3c_fb_set_par(struct fb_info *info)
>  	void __iomem *regs = sfb->regs;
>  	void __iomem *buf = regs;
>  	int win_no = win->index;
> -	u32 osdc_data = 0;
> +	u32 alpha = 0;
>  	u32 data;
>  	u32 pagewidth;
>  	int clkdiv;
> @@ -511,15 +547,12 @@ static int s3c_fb_set_par(struct fb_info *info)
>  
>  	data = var->xres * var->yres;
>  
> -	osdc_data = VIDISD14C_ALPHA1_R(0xf) |
> +	alpha = VIDISD14C_ALPHA1_R(0xf) |
>  		VIDISD14C_ALPHA1_G(0xf) |
>  		VIDISD14C_ALPHA1_B(0xf);
>  
> -	if (win->variant.has_osd_d) {
> -		writel(data, regs + VIDOSD_D(win_no, sfb->variant));
> -		writel(osdc_data, regs + VIDOSD_C(win_no, sfb->variant));
> -	} else
> -		writel(data, regs + VIDOSD_C(win_no, sfb->variant));
> +	vidosd_set_alpha(win, alpha);
> +	vidosd_set_size(win, data);
>  
>  	data = WINCONx_ENWIN;
>  
> @@ -1445,12 +1478,17 @@ static int s3c_fb_resume(struct platform_device *pdev)
>  static struct s3c_fb_win_variant s3c_fb_data_64xx_wins[] __devinitdata = {
>  	[0] = {
>  		.has_osd_c	= 1,
> +		.has_osd_size	= 1,
> +		.osd_size_off	= 0x8,
>  		.palette_sz	= 256,
>  		.valid_bpp	= VALID_BPP1248 | VALID_BPP(16) | VALID_BPP(24),
>  	},
>  	[1] = {
>  		.has_osd_c	= 1,
>  		.has_osd_d	= 1,
> +		.has_osd_size	= 1,
> +		.osd_size_off	= 0x12,
> +		.has_osd_alpha	= 1,

how about osd_size_off !=0 => has_osd_size ?

do we need to change the osd c and d definitions?
