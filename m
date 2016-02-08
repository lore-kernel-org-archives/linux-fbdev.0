From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 08 Feb 2016 02:54:26 +0000
Subject: Re: [PATCH] staging: sm750fb: Fix comments style
Message-Id: <20160208025426.GA10405@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449083891-29650-1-git-send-email-sebastian.lawniczak@yahoo.com>
In-Reply-To: <1449083891-29650-1-git-send-email-sebastian.lawniczak@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sebastian.lawniczak@yahoo.com
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Wed, Dec 02, 2015 at 08:18:11PM +0100, sebastian.lawniczak@yahoo.com wrote:
> From: Sebastian Lawniczak <sebastian.lawniczak@yahoo.com>
> 
> Fix warnings reported by checkpatch.pl in block comments.
> 
> Signed-off-by: Sebastian Lawniczak <sebastian.lawniczak@yahoo.com>
> ---
>  drivers/staging/sm750fb/ddk750_chip.c | 70 +++++++++++++++++++----------------
>  1 file changed, 39 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
> index 0331d34..01ddf44 100644
> --- a/drivers/staging/sm750fb/ddk750_chip.c
> +++ b/drivers/staging/sm750fb/ddk750_chip.c
> @@ -86,8 +86,10 @@ static void setMemoryClock(unsigned int frequency)
>  		return;
>  
>  	if (frequency) {
> -		/* Set the frequency to the maximum frequency that the DDR Memory can take
> -		which is 336MHz. */
> +		/*
> +		* Set the frequency to the maximum frequency that the DDR Memory can take
> +		* which is 336MHz.
> +		*/

It should look like:
		/*
		 * Set the frequency to the maximum frequency that the DDR Memory can take
		 * which is 336MHz.
		 */

So I can't take this patch, sorry.

Please fix it up and resend.

thanks,

greg k-h
