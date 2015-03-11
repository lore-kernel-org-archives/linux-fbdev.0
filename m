From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 11 Mar 2015 09:09:11 +0000
Subject: Re: [PATCH 6/6] staging: sm750fb: Spinlock and unlock in the same block
Message-Id: <20150311090911.GW10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426037325-8392-1-git-send-email-lstoakes@gmail.com>
 <1426037325-8392-6-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1426037325-8392-6-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 11, 2015 at 01:28:45AM +0000, Lorenzo Stoakes wrote:
> -static inline void myspin_lock(spinlock_t * sl){
> -	struct lynx_share * share;
> -	share = container_of(sl,struct lynx_share,slock);
> -	if(share->dual){
> -		spin_lock(sl);
> -	}
> -}

Yes, good.  We all hate locking wrappers but these are worse than
normal.

> +	/* if not use spin_lock,system will die if user load driver
> +	 * and immediatly unload driver frequently (dual)*/
> +	if (share->dual) {
> +		spin_lock(&share->slock);
> +		share->accel.de_fillrect(&share->accel,
> +					base,pitch,Bpp,
> +					region->dx,region->dy,
> +					region->width,region->height,
> +					color,rop);
> +		spin_unlock(&share->slock);
> +	} else
> +		share->accel.de_fillrect(&share->accel,
> +					base,pitch,Bpp,
> +					region->dx,region->dy,
> +					region->width,region->height,
> +					color,rop);
>  }

No.  You've made the code uglier to work around Sparse stupidness.  Also
the braces are not according to kernel style.

	if (share->dual)
		spin_lock(&share->slock);

	share->accel.de_fillrect(&share->accel,
				 base,pitch,Bpp,
				 region->dx,region->dy,
				 region->width,region->height,
				 color,rop);

	if (share->dual)
		spin_unlock(&share->slock);

Sparse will still complain but no one cares.

regards,
