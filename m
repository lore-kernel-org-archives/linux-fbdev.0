From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 14 Jun 2017 10:54:58 +0000
Subject: Re: [PATCH] sm501fb: Silence a coccinelle script warning.
Message-Id: <3551083.sIQ6JeN0q9@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170508061141epcas3p4d89f8f964dbe8a327de1abf80da94e6a@epcas3p4.samsung.com>
        <20170508061116.31471-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20170508061116.31471-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: khoroshilov@ispras.ru, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org


Hi,

On Monday, May 08, 2017 08:11:16 AM Christophe JAILLET wrote:
> According to surrounding goto, it is likely that 'goto err_probed_panel' is
> expected here.
> This change is just done in order to silence some coccinelle scripts
> which try to detect wrongly ordered goto.
> 
> If 'info->fb[HEAD_PANEL]' and' 'info->fb[HEAD_CRT]' are both NULL, this
> means that no 'framebuffer_alloc' has been performed, so 'goto err_alloc'
> looks fine.
> Anyway, it is also harmless in this case to call 'framebuffer_release'.
> The code looks more straight forward.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

It seems that the code for supporting only selected framebuffers
(only HEAD_PANEL fb or only HEAD_CRT fb) is broken anyway as at least
the suspend/resume support assumes that both framebuffers are always
present. Also all sm501fb driver users always try try to initialize
both framebuffers. Therefore I would prefer the removal of non-working
individual framebuffers support (the code that your patch modifies
would be removed as well). Could you please look into it?

> ---
>  drivers/video/fbdev/sm501fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
> index 67e314fdd947..4d89b045ce40 100644
> --- a/drivers/video/fbdev/sm501fb.c
> +++ b/drivers/video/fbdev/sm501fb.c
> @@ -1990,7 +1990,7 @@ static int sm501fb_probe(struct platform_device *pdev)
>  	    info->fb[HEAD_CRT] = NULL) {
>  		dev_err(dev, "no framebuffers found\n");
>  		ret = -ENODEV;
> -		goto err_alloc;
> +		goto err_probed_panel;
>  	}
>  
>  	/* get the resources for both of the framebuffers */

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

