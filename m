From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 23 Aug 2012 20:28:46 +0000
Subject: Re: [PATCH 2/4] fbcon: prevent possible buffer overflow.
Message-Id: <5036927E.1080504@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343091626-11435-1-git-send-email-paul@crapouillou.net> <1343091626-11435-2-git-send-email-paul@crapouillou.net>
In-Reply-To: <1343091626-11435-2-git-send-email-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Cercueil <paul@crapouillou.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On 07/24/2012 01:00 AM, Paul Cercueil wrote:
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/console/fbcon.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
> index a0b1818..3ffab97 100644
> --- a/drivers/video/console/fbcon.c
> +++ b/drivers/video/console/fbcon.c
> @@ -442,7 +442,7 @@ static int __init fb_console_setup(char *this_opt)
>  
>  	while ((options = strsep(&this_opt, ",")) != NULL) {
>  		if (!strncmp(options, "font:", 5))
> -			strcpy(fontname, options + 5);
> +			strlcpy(fontname, options + 5, sizeof(fontname));
>  		
>  		if (!strncmp(options, "scrollback:", 11)) {
>  			char *k;

