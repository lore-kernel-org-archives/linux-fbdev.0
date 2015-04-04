From: =?ISO-8859-2?Q?Giedrius_Statkevi=E8ius?=  <giedrius.statkevicius@gmail.com>
Date: Sat, 04 Apr 2015 19:31:26 +0000
Subject: Re: [PATCH] staging: sm7xxfb: Fix sparse warning
Message-Id: <alpine.LNX.2.03.1504042230330.9041@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150404165120.GA3111@Caladan>
In-Reply-To: <20150404165120.GA3111@Caladan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nickolaus Woodruff <nickolauswoodruff@gmail.com>
Cc: sudipmmukherjee@gmail.com, teddywang@siliconmotion.com, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 4 Apr 2015, Nickolaus Woodruff wrote:

> This patch fixes the following sparse warning in sm7xx.h:
> 
> drivers/staging/sm7xxfb/sm7xx.h:122:17: warning: symbol 'vgamode'
> was not declared. Should it be static?
> 
> Signed-off-by: Nickolaus Woodruff <nickolauswoodruff@gmail.com>
> ---
>  drivers/staging/sm7xxfb/sm7xx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm7xxfb/sm7xx.h b/drivers/staging/sm7xxfb/sm7xx.h
> index 7cc1896..c5d6253 100644
> --- a/drivers/staging/sm7xxfb/sm7xx.h
> +++ b/drivers/staging/sm7xxfb/sm7xx.h
> @@ -119,7 +119,7 @@ struct ModeInit {
>  /**********************************************************************
>  			 SM712 Mode table.
>   **********************************************************************/
> -struct ModeInit vgamode[] = {
> +static struct ModeInit vgamode[] = {

Someone already fixed this:
https://git.kernel.org/cgit/linux/kernel/git/gregkh/staging.git/tree/drivers/staging/sm7xxfb/sm7xx.h?h=staging-testing#n122
Please work against staging-testing branch of the staging tree.

Su pagarba / Regards,
Giedrius
