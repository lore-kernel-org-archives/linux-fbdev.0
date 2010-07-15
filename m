From: Marcin Slusarz <marcin.slusarz@gmail.com>
Date: Thu, 15 Jul 2010 18:32:26 +0000
Subject: Re: [patch] fb: handle allocation failure in alloc_apertures()
Message-Id: <20100715183226.GA2740@joi.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100715083453.GA17585@bicker>
In-Reply-To: <20100715083453.GA17585@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Jul 15, 2010 at 10:39:47AM +0200, Dan Carpenter wrote:
> If the kzalloc() fails we should return NULL.  All the places that call
> alloc_apertures() check for this already.

Thanks for fixing this. I added this function, so FWIW:
Acked-by: Marcin Slusarz <marcin.slusarz@gmail.com>
 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
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
