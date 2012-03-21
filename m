From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 21 Mar 2012 18:35:51 +0000
Subject: Re: [PATCH] video:uvesafb: notice user when we failed to save hardware state
Message-Id: <4F6A1F87.6010806@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120302014531.GA3597@udknight>
In-Reply-To: <20120302014531.GA3597@udknight>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wang YanQing <Udknight@gmail.com>, spock@gentoo.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/02/2012 01:45 AM, Wang YanQing wrote:
> 
> uvesafb_open may failed to save hardware state when kmalloc failed
> in uvesafb_vbe_state_save, we should check this and notice user.
> 
> Signed-off-by: Wang YanQing <udknight@gmail.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/uvesafb.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
> index e7f69ef..9db3de3 100644
> --- a/drivers/video/uvesafb.c
> +++ b/drivers/video/uvesafb.c
> @@ -362,7 +362,7 @@ static u8 *uvesafb_vbe_state_save(struct uvesafb_par *par)
>  
>  	state = kmalloc(par->vbe_state_size, GFP_KERNEL);
>  	if (!state)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	task = uvesafb_prep();
>  	if (!task) {
> @@ -1172,9 +1172,17 @@ static int uvesafb_open(struct fb_info *info, int user)
>  {
>  	struct uvesafb_par *par = info->par;
>  	int cnt = atomic_read(&par->ref_count);
> +	u8 *buf = NULL;
>  
> -	if (!cnt && par->vbe_state_size)
> -		par->vbe_state_orig = uvesafb_vbe_state_save(par);
> +	if (!cnt && par->vbe_state_size) {
> +		buf =  uvesafb_vbe_state_save(par);
> +		if (IS_ERR(buf)) {
> +			printk(KERN_WARNING "uvesafb: save hardware state"
> +				"failed, error code is %ld!\n", PTR_ERR(buf));
> +		} else {
> +			par->vbe_state_orig = buf;
> +		}
> +	}
>  
>  	atomic_inc(&par->ref_count);
>  	return 0;

