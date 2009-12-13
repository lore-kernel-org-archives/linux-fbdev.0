From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 13 Dec 2009 12:52:59 +0000
Subject: Re: [PATCH 7/9] drivers/video: Correct code taking the size of a
Message-Id: <4B24E3AB.9040609@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.0912131242240.24267@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.0912131242240.24267@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <julia@diku.dk>
Cc: JosephChan@via.com.tw, Scott Fang <ScottFang@viatech.com.cn>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Hi Julia, Andrew,

Julia Lawall schrieb:
> From: Julia Lawall <julia@diku.dk>
> 
> sizeof(viafb_gamma_table) is just the size of the pointer.  This is changed
> to the size used when calling kmalloc to initialize the pointer.

this is the second patch addressing this issue ending up in my mailbox. 
At least this one is technically correct so feel free to upstream it.
However I vote for removing this ioctl hell from viafb as most of them 
duplicate framebuffer functionality or have unknown (not clearly 
defined) functionality or at least solve a generic problem with a custom 
ioctl (which I consider bad). I had a patch ready to move this stuff to 
an extra file and print a warning that it is subject to be removed. I 
feel a bit uncomfortable about repairing broken stuff prior to removing it.
Any comments on this subject?


Thanks,

Florian Tobias Schandinat

> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> ---
>  drivers/video/via/viafbdev.c        |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
> index 56ec696..a0b47f1 100644
> --- a/drivers/video/via/viafbdev.c
> +++ b/drivers/video/via/viafbdev.c
> @@ -680,7 +680,7 @@ static int viafb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
>  		if (!viafb_gamma_table)
>  			return -ENOMEM;
>  		if (copy_from_user(viafb_gamma_table, argp,
> -				sizeof(viafb_gamma_table))) {
> +				256 * sizeof(u32))) {
>  			kfree(viafb_gamma_table);
>  			return -EFAULT;
>  		}
> @@ -694,7 +694,7 @@ static int viafb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
>  			return -ENOMEM;
>  		viafb_get_gamma_table(viafb_gamma_table);
>  		if (copy_to_user(argp, viafb_gamma_table,
> -			sizeof(viafb_gamma_table))) {
> +			256 * sizeof(u32))) {
>  			kfree(viafb_gamma_table);
>  			return -EFAULT;
>  		}
