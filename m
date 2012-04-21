From: Alexander Holler <holler@ahsoftware.de>
Date: Sat, 21 Apr 2012 11:26:19 +0000
Subject: Re: [PATCH] video/smscufx: fix line counting in fb_write
Message-Id: <4F92995B.6030805@ahsoftware.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334959867-3719-1-git-send-email-holler@ahsoftware.de>
In-Reply-To: <1334959867-3719-1-git-send-email-holler@ahsoftware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Holler <holler@ahsoftware.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

Hello,

as for the patch for udlfb, I forgot to mention that this is a candidate 
for all stable trees 3.2 and above.

Btw., the address of the maintainer doesn't seem to be valid anymore.

Regards,

Alexander

Am 21.04.2012 00:11, schrieb Alexander Holler:
> Line 0 and 1 were both written to line 0 (on the display) and all subsequent
> lines had an offset of -1. The result was that the last line on the display
> was never overwritten by writes to /dev/fbN.
>
> The origin of this bug seems to have been udlfb.
>
> Signed-off-by: Alexander Holler<holler@ahsoftware.de>

Cc: stable@vger.kernel.org

> ---
>   drivers/video/smscufx.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/video/smscufx.c b/drivers/video/smscufx.c
> index ccbfef5..1e1e2d2 100644
> --- a/drivers/video/smscufx.c
> +++ b/drivers/video/smscufx.c
> @@ -904,7 +904,7 @@ static ssize_t ufx_ops_write(struct fb_info *info, const char __user *buf,
>   	result = fb_sys_write(info, buf, count, ppos);
>
>   	if (result>  0) {
> -		int start = max((int)(offset / info->fix.line_length) - 1, 0);
> +		int start = max((int)(offset / info->fix.line_length), 0);
>   		int lines = min((u32)((result / info->fix.line_length) + 1),
>   				(u32)info->var.yres);
>

