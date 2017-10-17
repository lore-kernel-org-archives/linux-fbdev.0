From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 17 Oct 2017 11:33:49 +0000
Subject: Re: [PATCH 6/8] video: fbdev: au1200fb: Remove some dead code
Message-Id: <20171017113349.mee6ktysujsui7rj@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1508179264.git.christophe.jaillet@wanadoo.fr>
 <d4ef5b40a6ba8b468bd22cc8e429260c42b2fb7f.1508179264.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <d4ef5b40a6ba8b468bd22cc8e429260c42b2fb7f.1508179264.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: b.zolnierkie@samsung.com, tj@kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Mon, Oct 16, 2017 at 09:04:52PM +0200, Christophe JAILLET wrote:
> There is no need to shut gcc up. It should not complain.
> Axe 'fbdev', it is never used in this function.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/video/fbdev/au1200fb.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
> index e531543bc707..970ce761ff89 100644
> --- a/drivers/video/fbdev/au1200fb.c
> +++ b/drivers/video/fbdev/au1200fb.c
> @@ -1667,10 +1667,6 @@ static int au1200fb_drv_probe(struct platform_device *dev)
>  	printk(DRIVER_NAME ": Panel %d %s\n", panel_index, panel->name);
>  	printk(DRIVER_NAME ": Win %d %s\n", window_index, win->name);
>  
> -	/* shut gcc up */
> -	ret = 0;

Heh...  It looks like they were deliberately silencing the warning about
the bug you fixed in patch 2/8.  :P

regards,
dan carpenter

