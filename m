From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 15 Jan 2020 15:27:12 +0000
Subject: Re: [PATCH] fbdev: s1d13xxxfb: add missed unregister_framebuffer in remove
Message-Id: <d13e08ff-befc-978c-0216-a4b0c60f1354@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20191118080914eucas1p2fce1f43568b8453b9d513108df54f384@eucas1p2.samsung.com>
 <20191118080900.30634-1-hslester96@gmail.com>
In-Reply-To: <20191118080900.30634-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chuhong Yuan <hslester96@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Kristoffer Ericson <kristoffer.ericson@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 11/18/19 9:09 AM, Chuhong Yuan wrote:
> The driver calls register_framebuffer in probe but does not call
> unregister_framebuffer in remove.
> Add the missed call to fix it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/video/fbdev/s1d13xxxfb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
> index e04efb567b5c..162003ea6b79 100644
> --- a/drivers/video/fbdev/s1d13xxxfb.c
> +++ b/drivers/video/fbdev/s1d13xxxfb.c
> @@ -729,6 +729,7 @@ s1d13xxxfb_remove(struct platform_device *pdev)
>  	struct s1d13xxxfb_par *par = NULL;
>  
>  	if (info) {
> +		unregister_framebuffer(info);

s1d13xxxfb_remove() is not only called on removal operation but also
by s1d13xxxfb_probe() on register_framebuffer() failure. After above
change the code in s1d13xxxfb_probe() will break. The issue needs to
be fixed in different way, i.e.

- rename existing s1d13xxxfb_remove() to __s1d13xxxfb_remove()

- add s1d13xxxfb_remove() which does unregister_framebuffer() and
  then calls __s1d13xxxfb_remove())

>  		par = info->par;
>  		if (par && par->regs) {
>  			/* disable output & enable powersave */
> 

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
