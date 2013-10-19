From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Sat, 19 Oct 2013 10:48:34 +0000
Subject: Re: [PATCH] tmio: call tmiofb_set_par in tmiofb_probe
Message-Id: <20131019104834.GJ18477@ns203013.ovh.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382003443-5044-1-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1382003443-5044-1-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 13:50 Thu 17 Oct     , Dmitry Eremin-Solenikov wrote:
> Call tmiofb_set_par() to initlaize fixed variable before registering
> framebuffer. This is necessary for current kexecboot.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/video/tmiofb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/tmiofb.c b/drivers/video/tmiofb.c
> index deb8733..69fd0f7 100644
> --- a/drivers/video/tmiofb.c
> +++ b/drivers/video/tmiofb.c
> @@ -774,6 +774,10 @@ static int tmiofb_probe(struct platform_device *dev)
>  	if (retval)
>  		goto err_hw_init;
>  
> +	retval = tmiofb_set_par(info);
> +	if (retval)
> +		goto err_set_par;
> +

sorry no fix kexecboot

Best Regards,
J.
>  	fb_videomode_to_modelist(data->modes, data->num_modes,
>  				 &info->modelist);
>  
> @@ -787,7 +791,7 @@ static int tmiofb_probe(struct platform_device *dev)
>  	return 0;
>  
>  err_register_framebuffer:
> -/*err_set_par:*/
> +err_set_par:
>  	tmiofb_hw_stop(dev);
>  err_hw_init:
>  	if (cell->disable)
> -- 
> 1.8.4.rc3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
