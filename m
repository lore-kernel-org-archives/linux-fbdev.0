From: Michael Hennerich <michael.hennerich@analog.com>
Date: Mon, 23 Nov 2015 13:53:11 +0000
Subject: Re: [PATCH] backlight: adp88x0: fix uninitialized variable use
Message-Id: <56531A47.5000508@analog.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <3850346.cL1ocQLBvP@wuerfel>
In-Reply-To: <3850346.cL1ocQLBvP@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 11/23/2015 02:44 PM, Arnd Bergmann wrote:
> gcc correctly warns about both the adp8860 and adp8870 backlight
> drivers using an uninitialized variable in their error handling
> path:
>
> drivers/video/backlight/adp8870_bl.c: In function 'adp8870_bl_ambient_light_zone_store':
> drivers/video/backlight/adp8870_bl.c:811:11: warning: 'reg_val' may be used uninitialized in this function
>
> This changes the code to only write back the data if it was
> correctly read to start with.
>
> As a side-note, the drivers are mostly identical, so I think they
> should really be merged into one file to avoid having to fix every
> bug twice.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

>
> diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
> index 98ffe71e8af2..f0d4c0324580 100644
> --- a/drivers/video/backlight/adp8860_bl.c
> +++ b/drivers/video/backlight/adp8860_bl.c
> @@ -621,10 +621,12 @@ static ssize_t adp8860_bl_ambient_light_zone_store(struct device *dev,
>
>   		/* Set user supplied ambient light zone */
>   		mutex_lock(&data->lock);
> -		adp8860_read(data->client, ADP8860_CFGR, &reg_val);
> -		reg_val &= ~(CFGR_BLV_MASK << CFGR_BLV_SHIFT);
> -		reg_val |= (val - 1) << CFGR_BLV_SHIFT;
> -		adp8860_write(data->client, ADP8860_CFGR, reg_val);
> +		ret = adp8860_read(data->client, ADP8860_CFGR, &reg_val);
> +		if (!ret) {
> +			reg_val &= ~(CFGR_BLV_MASK << CFGR_BLV_SHIFT);
> +			reg_val |= (val - 1) << CFGR_BLV_SHIFT;
> +			adp8860_write(data->client, ADP8860_CFGR, reg_val);
> +		}
>   		mutex_unlock(&data->lock);
>   	}
>
> diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
> index 9d738352d7d4..21acac90fd77 100644
> --- a/drivers/video/backlight/adp8870_bl.c
> +++ b/drivers/video/backlight/adp8870_bl.c
> @@ -807,10 +807,12 @@ static ssize_t adp8870_bl_ambient_light_zone_store(struct device *dev,
>
>   		/* Set user supplied ambient light zone */
>   		mutex_lock(&data->lock);
> -		adp8870_read(data->client, ADP8870_CFGR, &reg_val);
> -		reg_val &= ~(CFGR_BLV_MASK << CFGR_BLV_SHIFT);
> -		reg_val |= (val - 1) << CFGR_BLV_SHIFT;
> -		adp8870_write(data->client, ADP8870_CFGR, reg_val);
> +		ret = adp8870_read(data->client, ADP8870_CFGR, &reg_val);
> +		if (!ret) {
> +			reg_val &= ~(CFGR_BLV_MASK << CFGR_BLV_SHIFT);
> +			reg_val |= (val - 1) << CFGR_BLV_SHIFT;
> +			adp8870_write(data->client, ADP8870_CFGR, reg_val);
> +		}
>   		mutex_unlock(&data->lock);
>   	}
>
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
