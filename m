From: Alexander Holler <holler@ahsoftware.de>
Date: Sat, 21 Apr 2012 11:26:00 +0000
Subject: Re: [PATCH] video/udlfb: fix line counting in fb_write
Message-Id: <4F929948.9010504@ahsoftware.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334959844-3665-1-git-send-email-holler@ahsoftware.de>
In-Reply-To: <1334959844-3665-1-git-send-email-holler@ahsoftware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Holler <holler@ahsoftware.de>
Cc: linux-kernel@vger.kernel.org, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org

Hello,

sorry, I forgot to mention that this is a candidate for all stable trees 
2.6.37 and above. Not sure how to announce that, but I think I should 
have added the below Cc: to the patch.

Regards,

Alexander

Am 21.04.2012 00:10, schrieb Alexander Holler:
> Line 0 and 1 were both written to line 0 (on the display) and all subsequent
> lines had an offset of -1. The result was that the last line on the display
> was never overwritten by writes to /dev/fbN.
>
> Signed-off-by: Alexander Holler<holler@ahsoftware.de>

Cc: stable@vger.kernel.org

> ---
>   drivers/video/udlfb.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
> index a159b63..85d8110 100644
> --- a/drivers/video/udlfb.c
> +++ b/drivers/video/udlfb.c
> @@ -647,7 +647,7 @@ static ssize_t dlfb_ops_write(struct fb_info *info, const char __user *buf,
>   	result = fb_sys_write(info, buf, count, ppos);
>
>   	if (result>  0) {
> -		int start = max((int)(offset / info->fix.line_length) - 1, 0);
> +		int start = max((int)(offset / info->fix.line_length), 0);
>   		int lines = min((u32)((result / info->fix.line_length) + 1),
>   				(u32)info->var.yres);
>

