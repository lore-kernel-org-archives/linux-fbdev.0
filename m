From: Joe Perches <joe@perches.com>
Date: Fri, 15 Feb 2019 10:00:27 +0000
Subject: Re: [PATCH] video: fbdev: vesafb: fix indentation issue
Message-Id: <6b0d55253ce61f1b7a068689ae9db597aaf5d30a.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190212132905.7307-1-colin.king@canonical.com>
In-Reply-To: <20190212132905.7307-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin King <colin.king@canonical.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2019-02-12 at 13:29 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are a couple of statements that are indented too deeply, fix
> this by removing tabs. Also add a space after a comma to clean up
> a cppcheck warning.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/video/fbdev/vesafb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
> index 528fe917dd49..b7388e25aa2a 100644
> --- a/drivers/video/fbdev/vesafb.c
> +++ b/drivers/video/fbdev/vesafb.c
> @@ -336,8 +336,8 @@ static int vesafb_probe(struct platform_device *dev)
>  		printk(KERN_INFO "vesafb: pmi: set display start = %p, set palette = %p\n",pmi_start,pmi_pal);
>  		if (pmi_base[3]) {
>  			printk(KERN_INFO "vesafb: pmi: ports = ");
> -				for (i = pmi_base[3]/2; pmi_base[i] != 0xffff; i++)
> -					printk("%x ",pmi_base[i]);
> +			for (i = pmi_base[3]/2; pmi_base[i] != 0xffff; i++)
> +				printk("%x ", pmi_base[i]);
>  			printk("\n");
>  			if (pmi_base[i] != 0xffff) {
>  				/*

Perhaps you could also use pr_cont too because otherwise this
emits each printk on separate lines.
