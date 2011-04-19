From: Peter Jones <pjones@redhat.com>
Date: Tue, 19 Apr 2011 14:22:14 +0000
Subject: Re: [PATCH] efifb: fix int to pointer cast warning
Message-Id: <4DAD9A96.9050203@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110419094715.7888.84515.stgit@localhost6>
In-Reply-To: <20110419094715.7888.84515.stgit@localhost6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 04/19/2011 05:47 AM, Konstantin Khlebnikov wrote:
> drivers/video/efifb.c:247: warning: cast to pointer from integer of different size
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@openvz.org>

Looks fine to me:

Signed-off-by: Peter Jones <pjones@redhat.com>

> ---
>  drivers/video/efifb.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
> index 4eb38db..fb20584 100644
> --- a/drivers/video/efifb.c
> +++ b/drivers/video/efifb.c
> @@ -242,9 +242,9 @@ static int set_system(const struct dmi_system_id *id)
>  		return 0;
>  	}
>  
> -	printk(KERN_INFO "efifb: dmi detected %s - framebuffer at %p "
> +	printk(KERN_INFO "efifb: dmi detected %s - framebuffer at 0x%08x "
>  			 "(%dx%d, stride %d)\n", id->ident,
> -			 (void *)screen_info.lfb_base, screen_info.lfb_width,
> +			 screen_info.lfb_base, screen_info.lfb_width,
>  			 screen_info.lfb_height, screen_info.lfb_linelength);
>  
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
        Peter

Hardware simply does not work like the manual says and no amount
of Zen contemplation will ever make you at one with a 3c905B ethernet card.
		-- Alan

01234567890123456789012345678901234567890123456789012345678901234567890123456789
