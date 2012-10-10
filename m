From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 10 Oct 2012 12:29:21 +0000
Subject: Re: [PATCH RESEND] video/udlfb: fix line counting in fb_write
Message-Id: <50756A21.1020700@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5029FA0D.1090107@ahsoftware.de>
In-Reply-To: <5029FA0D.1090107@ahsoftware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Holler <holler@ahsoftware.de>
Cc: linux-kernel@vger.kernel.org, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org

On 08/14/2012 07:11 AM, Alexander Holler wrote:
> Line 0 and 1 were both written to line 0 (on the display) and all
> subsequent
> lines had an offset of -1. The result was that the last line on the display
> was never overwritten by writes to /dev/fbN.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Holler <holler@ahsoftware.de>

As Bernie agreed but didn't send me a pull request, I applied this one.
Though the formatting was screwed up and I had to fix it...


Best regards,

Florian Tobias Schandinat


> ---
>  drivers/video/udlfb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
> index a159b63..85d8110 100644
> --- a/drivers/video/udlfb.c
> +++ b/drivers/video/udlfb.c
> @@ -647,7 +647,7 @@ static ssize_t dlfb_ops_write(struct fb_info *info,
> const char __user *buf,
>      result = fb_sys_write(info, buf, count, ppos);
>       if (result > 0) {
> -        int start = max((int)(offset / info->fix.line_length) - 1, 0);
> +        int start = max((int)(offset / info->fix.line_length), 0);
>          int lines = min((u32)((result / info->fix.line_length) + 1),
>                  (u32)info->var.yres);
>  -- 1.7.6.5
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

