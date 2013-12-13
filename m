From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 13 Dec 2013 13:11:21 +0000
Subject: Re: [patch 1/2] video: mmp: delete a stray mutex_unlock()
Message-Id: <20131213125921.GW28413@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20131114081918.GB8150@elgon.mountain>
In-Reply-To: <20131114081918.GB8150@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Ping.

regards,
dan carpenter

On Thu, Nov 14, 2013 at 11:19:18AM +0300, Dan Carpenter wrote:
> We aren't holding the disp_lock so we shouldn't release it.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/video/mmp/core.c b/drivers/video/mmp/core.c
> index 84de263..c8d4265 100644
> --- a/drivers/video/mmp/core.c
> +++ b/drivers/video/mmp/core.c
> @@ -173,7 +173,7 @@ struct mmp_path *mmp_register_path(struct mmp_path_info *info)
>  		+ sizeof(struct mmp_overlay) * info->overlay_num;
>  	path = kzalloc(size, GFP_KERNEL);
>  	if (!path)
> -		goto failed;
> +		return NULL;
>  
>  	/* path set */
>  	mutex_init(&path->access_ok);
> @@ -219,11 +219,6 @@ struct mmp_path *mmp_register_path(struct mmp_path_info *info)
>  
>  	mutex_unlock(&disp_lock);
>  	return path;
> -
> -failed:
> -	kfree(path);
> -	mutex_unlock(&disp_lock);
> -	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(mmp_register_path);
>  
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
