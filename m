From: Joe Perches <joe@perches.com>
Date: Sat, 25 Nov 2017 22:36:27 +0000
Subject: Re: [PATCH] Staging: sm750fb: Fix coding style issue in ddk750_sii164.c
Message-Id: <1511649387.20482.5.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171125175937.10428-1-j.lacomis@gmail.com>
In-Reply-To: <20171125175937.10428-1-j.lacomis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeremy Lacomis <j.lacomis@gmail.com>, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Sat, 2017-11-25 at 12:59 -0500, Jeremy Lacomis wrote:
> This is a patch to the ddk750_sii164.c file that fixes line length warnings
> found by the checkpatch.pl script
> 
> Signed-off-by: Jeremy Lacomis <j.lacomis@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_sii164.c | 39 +++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
> index c787a74c4f9c..d081ecbb3e3d 100644
> --- a/drivers/staging/sm750fb/ddk750_sii164.c
> +++ b/drivers/staging/sm750fb/ddk750_sii164.c
> @@ -39,8 +39,10 @@ unsigned short sii164GetVendorID(void)
>  {
>  	unsigned short vendorID;
>  
> -	vendorID = ((unsigned short) i2cReadReg(SII164_I2C_ADDRESS, SII164_VENDOR_ID_HIGH) << 8) |
> -		    (unsigned short) i2cReadReg(SII164_I2C_ADDRESS, SII164_VENDOR_ID_LOW);
> +	vendorID = ((unsigned short) i2cReadReg(SII164_I2C_ADDRESS,
> +						SII164_VENDOR_ID_HIGH) << 8) |
> +		    (unsigned short) i2cReadReg(SII164_I2C_ADDRESS,
> +						SII164_VENDOR_ID_LOW);
>  
>  	return vendorID;
>  }
> @@ -56,15 +58,20 @@ unsigned short sii164GetDeviceID(void)
>  {
>  	unsigned short deviceID;
>  
> -	deviceID = ((unsigned short) i2cReadReg(SII164_I2C_ADDRESS, SII164_DEVICE_ID_HIGH) << 8) |
> -		    (unsigned short) i2cReadReg(SII164_I2C_ADDRESS, SII164_DEVICE_ID_LOW);
> +	deviceID = ((unsigned short) i2cReadReg(SII164_I2C_ADDRESS,
> +						SII164_DEVICE_ID_HIGH) << 8) |
> +		    (unsigned short) i2cReadReg(SII164_I2C_ADDRESS,
> +						SII164_DEVICE_ID_LOW);
>  
>  	return deviceID;
>  }

i2cReadReg is always used with SII154_I2C_ADDRESS.

Perhaps it'd be better to redefine i2cReadReg to something else.
i2cReadReg also returns an unsigned char so this cast isn't
particularly sensible.

Perhaps something like:

#define sii164_i2c_read_reg(reg)	i2cReadReg(SII164_I2C_ADDRESS, reg)

	device_id = sii164_i2c_read_reg(SII164_DEVICE_ID_HIGH) << 8 |
		    sii164_i2c_read_reg(SII164_DEVICE_ID_LOW);


