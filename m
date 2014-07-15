From: Varka Bhadram <varkabhadram@gmail.com>
Date: Tue, 15 Jul 2014 10:37:05 +0000
Subject: Re: [RFC v5 1/2] backlight: add new tps611xx backlight driver
Message-Id: <53C50181.3060302@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1405418958-7596-1-git-send-email-gshark.jeong@gmail.com> <1405418958-7596-2-git-send-email-gshark.jeong@gmail.com>
In-Reply-To: <1405418958-7596-2-git-send-email-gshark.jeong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Jeong <gshark.jeong@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Jeong <daniel.jeong@ti.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

On 07/15/2014 03:39 PM, Daniel Jeong wrote:
(...)

> +
> +static int tps611xx_backlight_remove(struct platform_device *pdev)
> +{
> +	struct tps611xx_bl_data *pchip = platform_get_drvdata(pdev);
> +	const struct tps611xx_esdata *esdata = pchip->esdata;
> +
> +	device_remove_file(&(pchip->bled->dev), &dev_attr_enable);
> +	gpio_direction_output(pchip->en_gpio, 0);
> +	mdelay(esdata->time.reset);
> +	return 0;
> +}
> +

Better to move the of_device_ids also here... We can see of_match_table directly...

> +static const struct platform_device_id tps611xx_id_table[] = {
> +	{TPS61158_NAME, (unsigned long)&tps611xx_info[TPS61158_ID]},
> +	{TPS61161_NAME, (unsigned long)&tps611xx_info[TPS61161_ID]},
> +	{TPS61163_NAME, (unsigned long)&tps611xx_info[TPS61163_ID]},
> +	{TPS61165_NAME, (unsigned long)&tps611xx_info[TPS61165_ID]},
> +	{}
> +};
> +
> +static struct platform_driver tps611xx_backlight_driver = {
> +	.driver = {
> +		.name = TPS611XX_NAME,
> +		.owner = THIS_MODULE,

No need to update .owner

see:http://lxr.free-electrons.com/source/include/linux/platform_device.h#L190

-- 
Regards,
Varka Bhadram.

