From: Joe Perches <joe@perches.com>
Date: Tue, 23 May 2017 10:49:19 +0000
Subject: Re: staging: sm750fb: Replace CamelCase variable names with underscores
Message-Id: <1495536559.2093.56.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1495517476-31531-1-git-send-email-richaj@cdac.in>
In-Reply-To: <1495517476-31531-1-git-send-email-richaj@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richa Jha <richaj@cdac.in>, gregkh@linuxfoundation.org
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Tue, 2017-05-23 at 11:01 +0530, Richa Jha wrote:
>     Replace CamelCase variable names with underscores to comply with
>     the standard kernel coding style

Better would be to remove the hungarian prefixes too

> diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
[]
> @@ -55,7 +55,7 @@ static unsigned int get_mxclk_freq(void)
>  static void set_chip_clock(unsigned int frequency)
>  {
>  	struct pll_value pll;
> -	unsigned int ulActualMxClk;
> +	unsigned int ul_actual_max_clk;

	unsigned int actual_max_clk;

etc...

