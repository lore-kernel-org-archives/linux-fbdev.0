From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 03 Jul 2017 06:19:37 +0000
Subject: Re: [PATCH] staging: sm750fb: skip unnecessary comparisons
Message-Id: <20170703061937.GA13523@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170703001809.GA1480@lynnl.wit>
In-Reply-To: <20170703001809.GA1480@lynnl.wit>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lynn Lei <lynnl.wit@gmail.com>
Cc: sudipm.mukherjee@gmail.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, teddy.wang@siliconmotion.com, linux-kernel@vger.kernel.org

On Mon, Jul 03, 2017 at 09:26:47AM +0800, Lynn Lei wrote:
> introduced early checks to skip unnecessary comparisons when flags set.

Why?

> 
> Signed-off-by: Lynn Lei <lynnl.wit@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 386d4adcd91d..9e57a2d32465 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -1171,11 +1171,16 @@ static int __init lynxfb_setup(char *options)
>  	 */
>  	while ((opt = strsep(&options, ":")) != NULL) {
>  		/* options that mean for any lynx chips are configured here */
> -		if (!strncmp(opt, "noaccel", strlen("noaccel"))) {
> +
> +		/*
> +		 * NOTE: the length of options is hard-coded
> +		 * if any of those options changed  please update its length
> +		 */

That's not good, why require this?  What is wrong with the original code
here?  It doesn't have that type of restriction, right?

> +		if (!g_noaccel && !strncmp(opt, "noaccel", 7)) {
>  			g_noaccel = 1;
> -		} else if (!strncmp(opt, "nomtrr", strlen("nomtrr"))) {
> +		} else if (!g_nomtrr && !strncmp(opt, "nomtrr", 6)) {

I don't see the benefit of this change at all, what am I missing?

thanks,

greg k-h
