From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 02 Sep 2011 20:57:45 +0000
Subject: Re: [PATCH] video: mb862xx-i2c: fix for reliable decoder register
Message-Id: <4E614349.70809@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314892421-13471-1-git-send-email-agust@denx.de>
In-Reply-To: <1314892421-13471-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 09/01/2011 03:53 PM, Anatolij Gustschin wrote:
> Increase delay when polling for tx status. This fixes
> the unreliable video decoder i2c register access.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>

Looks good to me, applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/mb862xx/mb862xx-i2c.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/mb862xx/mb862xx-i2c.c b/drivers/video/mb862xx/mb862xx-i2c.c
> index b953099..934081d 100644
> --- a/drivers/video/mb862xx/mb862xx-i2c.c
> +++ b/drivers/video/mb862xx/mb862xx-i2c.c
> @@ -23,7 +23,7 @@ static int mb862xx_i2c_wait_event(struct i2c_adapter *adap)
>  	u32 reg;
>  
>  	do {
> -		udelay(1);
> +		udelay(10);
>  		reg = inreg(i2c, GC_I2C_BCR);
>  		if (reg & (I2C_INT | I2C_BER))
>  			break;

