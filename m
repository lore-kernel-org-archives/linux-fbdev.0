From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Date: Mon, 07 Jul 2014 10:20:39 +0000
Subject: Re: [PATCH] video: fbdev: xen-fbfront.c:  Cleaning up useless assignment of function parameter
Message-Id: <alpine.DEB.2.02.1407071120310.27641@kaball.uk.xensource.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404667640-14855-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404667640-14855-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 6 Jul 2014, Rickard Strandqvist wrote:
> Remove assignment of function parameter, that has no effect outside the function
> 
> This was found using a static code analysis program called cppcheck
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>  drivers/video/fbdev/xen-fbfront.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
> index 901014b..e1207a1 100644
> --- a/drivers/video/fbdev/xen-fbfront.c
> +++ b/drivers/video/fbdev/xen-fbfront.c
> @@ -222,7 +222,6 @@ static int xenfb_setcolreg(unsigned regno, unsigned red, unsigned green,
>  	red = CNVT_TOHW(red, info->var.red.length);
>  	green = CNVT_TOHW(green, info->var.green.length);
>  	blue = CNVT_TOHW(blue, info->var.blue.length);
> -	transp = CNVT_TOHW(transp, info->var.transp.length);
>  #undef CNVT_TOHW
>  
>  	v = (red << info->var.red.offset) |
> -- 
> 1.7.10.4
> 
