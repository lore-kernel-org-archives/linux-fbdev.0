From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 10 May 2012 00:11:04 +0000
Subject: Re: [PATCH] video: smscufx.c: local functions should not be exposed globally
Message-Id: <4FAB0798.8090502@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201205021717.23749.hartleys@visionengravers.com>
In-Reply-To: <201205021717.23749.hartleys@visionengravers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, steve.glendinning@smsc.com

On 05/03/2012 12:17 AM, H Hartley Sweeten wrote:
> Functions not referenced outside of a source file should be marked
> static to prevent them from being exposed globally.
> 
> Quiets the sparse warnings:
> 
> warning: symbol 'ufx_handle_damage' was not declared. Should it be static?
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Steve Glendinning <steve.glendinning@smsc.com>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Applied.


Thanks,

Florian Tobias Schandinat

> 
> ---
> 
> diff --git a/drivers/video/smscufx.c b/drivers/video/smscufx.c
> index 9985785..af3ef27 100644
> --- a/drivers/video/smscufx.c
> +++ b/drivers/video/smscufx.c
> @@ -846,7 +846,7 @@ static void ufx_raw_rect(struct ufx_data *dev, u16 *cmd, int x, int y,
>  	}
>  }
>  
> -int ufx_handle_damage(struct ufx_data *dev, int x, int y,
> +static int ufx_handle_damage(struct ufx_data *dev, int x, int y,
>  	int width, int height)
>  {
>  	size_t packed_line_len = ALIGN((width * 2), 4);
> 

