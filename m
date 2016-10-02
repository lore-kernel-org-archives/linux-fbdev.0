From: Greg KH <gregkh@linuxfoundation.org>
Date: Sun, 02 Oct 2016 18:13:01 +0000
Subject: Re: [PATCH] staging: sm750fb: Fix printk() style warning
Message-Id: <20161002181301.GA22637@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161002180505.GA19813@gmail.com>
In-Reply-To: <20161002180505.GA19813@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Edward Lipinsky <ellipinsky@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, sudip@vectorindia.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Sun, Oct 02, 2016 at 11:05:05AM -0700, Edward Lipinsky wrote:
> This patch fixes the checkpatch.pl warning:
> 
> WARNING: printk() should include KERN_ facility level
> 
> Signed-off-by: Edward Lipinsky <ellipinsky@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_help.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_help.c b/drivers/staging/sm750fb/ddk750_help.c
> index 9637dd3..e72a29c 100644
> --- a/drivers/staging/sm750fb/ddk750_help.c
> +++ b/drivers/staging/sm750fb/ddk750_help.c
> @@ -11,7 +11,7 @@ void ddk750_set_mmio(void __iomem *addr, unsigned short devId, char revId)
>  	devId750 = devId;
>  	revId750 = revId;
>  	if (revId = 0xfe)
> -		printk("found sm750le\n");
> +		pr_info("found sm750le\n");

Why can't you use dev_info() here?

thanks,

greg k-h
