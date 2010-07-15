From: James Simmons <jsimmons@infradead.org>
Date: Thu, 15 Jul 2010 14:35:14 +0000
Subject: Re: [patch] fb: handle allocation failure in alloc_apertures()
Message-Id: <alpine.LFD.2.00.1007151534480.1038@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100715083453.GA17585@bicker>
In-Reply-To: <20100715083453.GA17585@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


> If the kzalloc() fails we should return NULL.  All the places that call
> alloc_apertures() check for this already.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Acked-by: James Simmons <jsimmons@infradead.org>
 
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 8e5a9df..e7445df 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -873,6 +873,8 @@ struct fb_info {
>  static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
>  	struct apertures_struct *a = kzalloc(sizeof(struct apertures_struct)
>  			+ max_num * sizeof(struct aperture), GFP_KERNEL);
> +	if (!a)
> +		return NULL;
>  	a->count = max_num;
>  	return a;
>  }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
