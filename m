From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 22 Mar 2017 09:41:14 +0000
Subject: Re: staging: iio: Replace a bit shift by a use of BIT.
Message-Id: <20170322094114.GH32449@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170322024942.GA21242@arushi-HP-Pavilion-Notebook>
In-Reply-To: <20170322024942.GA21242@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

On Wed, Mar 22, 2017 at 08:19:42AM +0530, Arushi Singhal wrote:
> This patch replaces bit shifting on 1 with the BIT(x) macro.
> This was done with coccinelle:
> @@
> constant c;
> @@
> 
> -1 << c
> +BIT(c)
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7816.c |  2 +-
>  drivers/staging/iio/cdc/ad7150.c |  2 +-
>  drivers/staging/iio/cdc/ad7746.c | 22 +++++++++++-----------
>  3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 17d280581e24..42f637ca0251 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -222,7 +222,7 @@ static ssize_t ad7816_show_value(struct device *dev,
>  		value = (s8)((data >> AD7816_TEMP_FLOAT_OFFSET) - 103);
>  		data &= AD7816_TEMP_FLOAT_MASK;
>  		if (value < 0)
> -			data = (1 << AD7816_TEMP_FLOAT_OFFSET) - data;
> +			data = (BIT(AD7816_TEMP_FLOAT_OFFSET)) - data;

Remove the extra parentheses from all of these:

			data = BIT(AD7816_TEMP_FLOAT_OFFSET) - data;

regards,
dan carpenter

