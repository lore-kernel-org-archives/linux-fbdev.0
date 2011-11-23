From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 23 Nov 2011 06:52:14 +0000
Subject: Re: [PATCH 3/3] Drivers: video: controlfb: fixed a brace coding style
Message-Id: <4ECC981E.9030703@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321590896-8249-1-git-send-email-zac.3.14159@gmail.com>
In-Reply-To: <1321590896-8249-1-git-send-email-zac.3.14159@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zac Storer <zac.3.14159@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/18/2011 04:34 AM, Zac Storer wrote:
> Fixed a brace coding style issue.
> 
> Signed-off-by: Zac Storer <zac.3.14159@gmail.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/controlfb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/controlfb.c b/drivers/video/controlfb.c
> index 7b2c40a..0c189b3 100644
> --- a/drivers/video/controlfb.c
> +++ b/drivers/video/controlfb.c
> @@ -420,7 +420,7 @@ static int __init init_control(struct fb_info_control *p)
>  
>  	/* Try to pick a video mode out of NVRAM if we have one. */
>  #ifdef CONFIG_NVRAM
> -	if (default_cmode = CMODE_NVRAM){
> +	if (default_cmode = CMODE_NVRAM) {
>  		cmode = nvram_read_byte(NV_CMODE);
>  		if(cmode < CMODE_8 || cmode > CMODE_32)
>  			cmode = CMODE_8;

