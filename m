From: =?UTF-8?B?R2llZHJpdXMgU3RhdGtldmnEjWl1cw==?=  <giedrius.statkevicius@gmail.com>
Date: Thu, 19 Mar 2015 17:42:03 +0000
Subject: Re: [PATCH] sm750fb: Fix C99 Comments and if else braces
Message-Id: <550B0A6B.5090008@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150319173947.GA12061@amitoj-Inspiron-3542>
In-Reply-To: <20150319173947.GA12061@amitoj-Inspiron-3542>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Amitoj Kaur Chawla <amitoj1606@gmail.com>, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Hi Amitoj Kaur Chawla,

On 2015.03.19 19:39, Amitoj Kaur Chawla wrote:
> The edits have been made to remove C99 Comments and properly indent
> the if-else statements in the file while taking care of the braces according to
> Linux coding style.
> 
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_chip.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
> index 33add64..33fa456 100644
> --- a/drivers/staging/sm750fb/ddk750_chip.c
> +++ b/drivers/staging/sm750fb/ddk750_chip.c
> @@ -17,25 +17,22 @@ logical_chip_type_t getChipType(void)
>  	char physicalRev;
>  	logical_chip_type_t chip;
>  
> -	physicalID = devId750;//either 0x718 or 0x750
> +	physicalID = devId750;/* either 0x718 or 0x750 */

Add a space here after ;?

>  	physicalRev = revId750;
>  
> -    if (physicalID = 0x718)
> -    {
> -        chip = SM718;
> -    }
> -    else if (physicalID = 0x750)
> -    {
> -        chip = SM750;
> +	if (physicalID = 0x718) {
> +		chip = SM718;
> +	}
> +	else if (physicalID = 0x750) {
> +		chip = SM750;
>  		/* SM750 and SM750LE are different in their revision ID only. */
> -		if (physicalRev = SM750LE_REVISION_ID){
> +		if (physicalRev = SM750LE_REVISION_ID) {
>  			chip = SM750LE;
>  		}
> -    }
> -    else
> -    {
> -        chip = SM_UNKNOWN;
> -    }
> +	}
> +	else {
> +		chip = SM_UNKNOWN;
> +	}
>  
>  	return chip;
>  }
> 


-- 
Thanks,
Giedrius
