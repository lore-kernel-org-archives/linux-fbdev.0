From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Thu, 15 Dec 2011 02:43:06 +0000
Subject: Re: [PATCH 47/57] fbdev: sh_mobile_meram: Use genalloc to manage
Message-Id: <4EE95EBA.8030702@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1323784972-24205-48-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1323784972-24205-48-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 2011/12/13 23:02, Laurent Pinchart wrote:
> @@ -195,43 +196,40 @@ static int meram_check_overlap(struct sh_mobile_meram_priv *priv,
>  	    test_bit(new->cache_icb,  &priv->used_icb))
>  		return  1;
>  
> -	for (i = 0; i < MERAM_ICB_NUM; i++) {
> -		if (!test_bit(i, &priv->used_icb))
> -			continue;
> -
> -		used_start = MERAM_CACHE_START(priv->icbs[i].region);
> -		used_end   = MERAM_CACHE_END(priv->icbs[i].region);
> -		meram_start = new->meram_offset;
> -		meram_end   = new->meram_offset + new->meram_size;
> -
> -		if ((meram_start >= used_start && meram_start < used_end) ||
> -		    (meram_end > used_start && meram_end < used_end))
> -			return 1;
> -	}
> -
>  	return 0;
>  }
>  
> -/* Mark the specified ICB as used. */
> -static void meram_mark(struct sh_mobile_meram_priv *priv,
> +/* Allocate memory for the ICBs and mark them as used. */
> +static int meram_alloc(struct sh_mobile_meram_priv *priv,
>  		       const struct sh_mobile_meram_icb_cfg *new,
>  		       int pixelformat)
>  {
> +	struct sh_mobile_meram_icb *marker = &priv->icbs[new->marker_icb];
> +	unsigned long mem;
> +
> +	mem = gen_pool_alloc(priv->pool, new->meram_size * 1024);
> +	if (mem = 0)
> +		return -ENOMEM;
> +
>  	__set_bit(new->marker_icb, &priv->used_icb);
>  	__set_bit(new->cache_icb, &priv->used_icb);
>  
> -	priv->icbs[new->marker_icb].region = MERAM_CACHE_SET(new->meram_offset,
> -							     new->meram_size);
> -	priv->icbs[new->cache_icb].region = MERAM_CACHE_SET(new->meram_offset,
> -							    new->meram_size);
> -	priv->icbs[new->marker_icb].current_reg = 1;
> -	priv->icbs[new->marker_icb].pixelformat = pixelformat;
> +	marker->offset = mem - priv->meram;
I might have missed this somewhere, but it doesn't look like priv->meram
is assigned anywhere.

Damian
-- 
Damian Hobson-Garcia
IGEL Co.,Ltd
http://www.igel.co.jp
