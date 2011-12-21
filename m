From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 21 Dec 2011 21:42:42 +0000
Subject: Re: [PATCH RESEND] MXSFB: Fix driver registration
Message-Id: <4EF252D2.7000206@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1324309079-10739-1-git-send-email-marek.vasut@gmail.com>
In-Reply-To: <1324309079-10739-1-git-send-email-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Wolfgang Denk <wd@denx.de>, Stefano Babic <sbabic@denx.de>, Shawn Guo <shawn.guo@linaro.org>, Huang Shijie <b32955@freescale.com>, Axel Lin <axel.lin@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

On 12/19/2011 03:37 PM, Marek Vasut wrote:
> The driver should be registered with mxsfb_driver, not with mxsfb_devtype.
> This caused obvious null pointer dereference and crash.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Huang Shijie <b32955@freescale.com>
> Cc: Axel Lin <axel.lin@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Axel Lin <axel.lin@gmail.com>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/mxsfb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
> index 18742c2..d29c7c0 100644
> --- a/drivers/video/mxsfb.c
> +++ b/drivers/video/mxsfb.c
> @@ -902,7 +902,7 @@ static struct platform_driver mxsfb_driver = {
>  	},
>  };
>  
> -module_platform_driver(mxsfb_devtype);
> +module_platform_driver(mxsfb_driver);
>  
>  MODULE_DESCRIPTION("Freescale mxs framebuffer driver");
>  MODULE_AUTHOR("Sascha Hauer, Pengutronix");

