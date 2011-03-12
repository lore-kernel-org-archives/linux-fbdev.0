From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 12 Mar 2011 15:31:35 +0000
Subject: Re: [PATCH] video/via: drop deprecated (and unused) i2c_adapter.id
Message-Id: <4D7B91D7.807@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1295991264-8640-1-git-send-email-peterhuewe@gmx.de>
In-Reply-To: <1295991264-8640-1-git-send-email-peterhuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Huewe <peterhuewe@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

Peter Huewe schrieb:
> This patch removes an assignment to the deprecated i2c_adapter.id
> field. Since the field isn't used anywhere else in the driver it is
> save to remove it.
> 
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>

Applied. Thanks,


Florian Tobias Schandinat

> ---
>  drivers/video/via/via_i2c.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/via/via_i2c.c b/drivers/video/via/via_i2c.c
> index 3844b55..a172a31 100644
> --- a/drivers/video/via/via_i2c.c
> +++ b/drivers/video/via/via_i2c.c
> @@ -209,7 +209,6 @@ static int create_i2c_bus(struct i2c_adapter *adapter,
>  	sprintf(adapter->name, "viafb i2c io_port idx 0x%02x",
>  		adap_cfg->ioport_index);
>  	adapter->owner = THIS_MODULE;
> -	adapter->id = 0x01FFFF;
>  	adapter->class = I2C_CLASS_DDC;
>  	adapter->algo_data = algo;
>  	if (pdev)

