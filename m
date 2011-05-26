From: Peter Jones <pjones@redhat.com>
Date: Thu, 26 May 2011 14:34:38 +0000
Subject: Re: [PATCH 3/4] efifb: Fix an integer-to-pointer size warning
Message-Id: <4DDE64FE.5080205@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0c405ceeca72c92d25cb6ee4bc92c35d2cb15019.1306418703.git.luto@mit.edu>
In-Reply-To: <0c405ceeca72c92d25cb6ee4bc92c35d2cb15019.1306418703.git.luto@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 05/26/2011 10:13 AM, Andy Lutomirski wrote:
> Signed-off-by: Andy Lutomirski <luto@mit.edu>

Signed-off-by: Peter Jones <pjones@redhat.com>

> ---
>  drivers/video/efifb.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
> index 43af770..39bbfa9 100644
> --- a/drivers/video/efifb.c
> +++ b/drivers/video/efifb.c
> @@ -246,8 +246,9 @@ static int set_system(const struct dmi_system_id *id)
>  
>  	printk(KERN_INFO "efifb: dmi detected %s - framebuffer at %p "
>  			 "(%dx%d, stride %d)\n", id->ident,
> -			 (void *)screen_info.lfb_base, screen_info.lfb_width,
> -			 screen_info.lfb_height, screen_info.lfb_linelength);
> +			 (void *)(unsigned long)screen_info.lfb_base,
> +			 screen_info.lfb_width, screen_info.lfb_height,
> +			 screen_info.lfb_linelength);
>  
>  
>  	return 1;


-- 
        Peter

If you're not part of the solution, then you're part of the precipitate.

01234567890123456789012345678901234567890123456789012345678901234567890123456789
