From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 10 Oct 2012 12:34:29 +0000
Subject: Re: [PATCH 1/2] drivers/video/savage/savagefb_driver.c: fix error return code
Message-Id: <50756B55.9040100@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1349268044-32616-1-git-send-email-peter.senna@gmail.com>
In-Reply-To: <1349268044-32616-1-git-send-email-peter.senna@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Senna Tschudin <peter.senna@gmail.com>
Cc: Antonino Daplas <adaplas@gmail.com>, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/03/2012 12:40 PM, Peter Senna Tschudin wrote:
> From: Peter Senna Tschudin <peter.senna@gmail.com>
> 
> Convert a nonnegative error return code to a negative one, as returned
> elsewhere in the function.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> (
> if@p1 (\(ret < 0\|ret != 0\))
>  { ... return ret; }
> |
> ret@p1 = 0
> )
> ... when != ret = e1
>     when != &ret
> *if(...)
> {
>   ... when != ret = e2
>       when forall
>  return ret;
> }
> // </smpl>
> 
> 
> Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>

Applied.


Thanks,

Florian Tobias Schandinat


> 
> ---
>  drivers/video/savage/savagefb_driver.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
> index 0d0f52c..f4f53b0 100644
> --- a/drivers/video/savage/savagefb_driver.c
> +++ b/drivers/video/savage/savagefb_driver.c
> @@ -2266,8 +2266,10 @@ static int __devinit savagefb_probe(struct pci_dev* dev,
>  	lpitch = info->var.xres_virtual*((info->var.bits_per_pixel + 7) >> 3);
>  	info->var.yres_virtual = info->fix.smem_len/lpitch;
>  
> -	if (info->var.yres_virtual < info->var.yres)
> +	if (info->var.yres_virtual < info->var.yres) {
> +		err = -ENOMEM;
>  		goto failed;
> +	}
>  
>  #if defined(CONFIG_FB_SAVAGE_ACCEL)
>  	/*
> 
> 

