From: Greg KH <gregkh@linuxfoundation.org>
Date: Sun, 21 Aug 2016 16:06:34 +0000
Subject: Re: [PATCH] Staging:sm750fb:ddk750_chip.c:Fixed coding style in comments
Message-Id: <20160821160634.GA10137@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160612133041.GA3709@rithvik-IdeaPad>
In-Reply-To: <20160612133041.GA3709@rithvik-IdeaPad>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rithvik Patibandla <rithvikp98@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Sun, Jun 12, 2016 at 07:00:41PM +0530, Rithvik Patibandla wrote:
> The following patch fixes format of some comments.
> 
> Signed-off-by: Rithvik Patibandla <rithvikp98@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_chip.c | 71 +++++++++++++++++++----------------
>  1 file changed, 38 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
> index f80ee77..8cb5cb9 100644
> --- a/drivers/staging/sm750fb/ddk750_chip.c
> +++ b/drivers/staging/sm750fb/ddk750_chip.c
> @@ -70,11 +70,11 @@ static void setChipClock(unsigned int frequency)
>  		pll.inputFreq = DEFAULT_INPUT_CLOCK; /* Defined in CLOCK.H */
>  		pll.clockType = MXCLK_PLL;
>  
> -		/*
> -		* Call calcPllValue() to fill up the other fields for PLL structure.
> -		* Sometime, the chip cannot set up the exact clock required by User.
> -		* Return value from calcPllValue() gives the actual possible clock.
> -		*/
> +	/*
> +	 * Call calcPllValue() to fill up the other fields for PLL structure.
> +	 * Sometime, the chip cannot set up the exact clock required by User.
> +	 * Return value from calcPllValue() gives the actual possible clock.
> +	 */

Really?  Does that look correct to you?

hint your indentation is totally wrong :(

Please be more careful...

greg k-h
