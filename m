From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 13 Feb 2012 21:27:15 +0000
Subject: Re: [PATCH] video: da8xx-fb: Fix build warning on unused label
Message-Id: <4F398033.80900@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1328763879-16345-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1328763879-16345-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Cc: linux-fbdev@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, linux-kernel@vger.kernel.org

On 02/09/2012 05:04 AM, Manjunathappa, Prakash wrote:
> Patch fixes build warning on label "err_cpu_freq" when CONFIG_CPU_FREQ
> is not defined.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/da8xx-fb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 29577bf..f360d62 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -1264,8 +1264,8 @@ static int __devinit fb_probe(struct platform_device *device)
>  irq_freq:
>  #ifdef CONFIG_CPU_FREQ
>  	lcd_da8xx_cpufreq_deregister(par);
> -#endif
>  err_cpu_freq:
> +#endif
>  	unregister_framebuffer(da8xx_fb_info);
>  
>  err_dealloc_cmap:

