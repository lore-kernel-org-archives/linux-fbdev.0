From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 22 Jun 2015 17:46:02 +0000
Subject: Re: [PATCH] staging: sm750fb: use tabs for indentation
Message-Id: <20150622174601.GF28762@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434761450-15722-1-git-send-email-juston.h.li@gmail.com>
In-Reply-To: <1434761450-15722-1-git-send-email-juston.h.li@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Juston Li <juston.h.li@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Fri, Jun 19, 2015 at 05:50:50PM -0700, Juston Li wrote:
>  void sii164ClearInterrupt(void)
>  {
> -    unsigned char detectReg;
> +	unsigned char detectReg;
>  
> -    /* Clear the MDI interrupt */
> -    detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
> -    i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT, detectReg | SII164_DETECT_MONITOR_STATE_CLEAR);

The patch accidentally deletes this write.

> +	/* Clear the MDI interrupt */
> +	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
>  }

regards,
dan carpenter
--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
