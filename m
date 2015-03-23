From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 23 Mar 2015 11:26:23 +0000
Subject: Re: [PATCH 10/13] staging: sm750: blank line after declaration
Message-Id: <20150323112623.GG10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150322231416.GA17270@x230-arch.club.entropia.de>
In-Reply-To: <20150322231416.GA17270@x230-arch.club.entropia.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Mar 23, 2015 at 12:14:17AM +0100, Michel von Czettritz wrote:
> This patch fixes "WARNING: Missing a blank line after declaration"
> checkpatch.pl warnings.
> 
> Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 90dc801..870bf6f 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -61,6 +61,7 @@ static char *g_option = NULL;
>  static inline void myspin_lock(spinlock_t *sl)
>  {
>  	struct lynx_share *share;
> +	

These introduces new checkpatch warnings.  Use checkpatch.pl on your own
patches.

regards,
dan carpenter

