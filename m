From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 26 Jul 2012 17:23:13 +0000
Subject: Re: [PATCH] fb: epson1355fb: Fix section mismatch
Message-Id: <50117D01.2060607@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1342337558-9912-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1342337558-9912-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 07/15/2012 07:32 AM, Alexander Shiyan wrote:
> This patch fixes "section mismatch" warning in the epson1355fb driver.
> 
> WARNING: vmlinux.o(.devinit.text+0x184): Section mismatch in reference from the function epson1355fb_probe() to the function .init.text:fetch_hw_state()
> The function __devinit epson1355fb_probe() references
> a function __init fetch_hw_state().
> If fetch_hw_state is only used by epson1355fb_probe then
> annotate fetch_hw_state with a matching annotation.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/epson1355fb.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/epson1355fb.c b/drivers/video/epson1355fb.c
> index a268cbf..68b9b51 100644
> --- a/drivers/video/epson1355fb.c
> +++ b/drivers/video/epson1355fb.c
> @@ -477,11 +477,11 @@ static __init unsigned int get_fb_size(struct fb_info *info)
>  	return size;
>  }
>  
> -static int epson1355_width_tab[2][4] __initdata > +static int epson1355_width_tab[2][4] __devinitdata >      { {4, 8, 16, -1}, {9, 12, 16, -1} };
> -static int epson1355_bpp_tab[8] __initdata = { 1, 2, 4, 8, 15, 16 };
> +static int epson1355_bpp_tab[8] __devinitdata = { 1, 2, 4, 8, 15, 16 };
>  
> -static void __init fetch_hw_state(struct fb_info *info, struct epson1355_par *par)
> +static void __devinit fetch_hw_state(struct fb_info *info, struct epson1355_par *par)
>  {
>  	struct fb_var_screeninfo *var = &info->var;
>  	struct fb_fix_screeninfo *fix = &info->fix;
> @@ -601,7 +601,7 @@ static int epson1355fb_remove(struct platform_device *dev)
>  	return 0;
>  }
>  
> -int __devinit epson1355fb_probe(struct platform_device *dev)
> +static int __devinit epson1355fb_probe(struct platform_device *dev)
>  {
>  	struct epson1355_par *default_par;
>  	struct fb_info *info;

