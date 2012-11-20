From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 20 Nov 2012 13:25:57 +0000
Subject: Re: [PATCH] video console: add a driver for lcd2s character display
Message-Id: <201211201325.57883.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353416206-3243-1-git-send-email-larsi@wh2.tu-dresden.de>
In-Reply-To: <1353416206-3243-1-git-send-email-larsi@wh2.tu-dresden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars Poeschel <larsi@wh2.tu-dresden.de>
Cc: FlorianSchandinat@gmx.de, poeschel@lemonage.de, mathieu.poirier@linaro.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 20 November 2012, Lars Poeschel wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> 
> This driver allows to use a lcd2s 20x4 character display as
> a linux console output device.
> 
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>

The driver looks nice overall, but I found two style issues:

> +static int __devinit lcd2s_i2c_probe(struct i2c_client *i2c,
> +				const struct i2c_device_id *id)
> +{
> +	struct lcd2s_data *data;
> +
> +	if (!i2c_check_functionality(i2c->adapter,
> +			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
> +		return -EIO;
> +	data = devm_kzalloc(&i2c->dev, sizeof(struct lcd2s_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->i2c = i2c;
> +	data->consw.owner		= THIS_MODULE;
> +	data->consw.con_startup		= lcd2s_startup;
> +	data->consw.con_init		= lcd2s_init;
> +	data->consw.con_deinit		= lcd2s_deinit;
> +	data->consw.con_clear		= lcd2s_clear;
> +	data->consw.con_putc		= lcd2s_putc;
> +	data->consw.con_putcs		= lcd2s_putcs;
> +	data->consw.con_cursor		= lcd2s_cursor;
> +	data->consw.con_scroll		= lcd2s_scroll;
> +	data->consw.con_bmove		= lcd2s_bmove;
> +	data->consw.con_switch		= lcd2s_switch;
> +	data->consw.con_blank		= lcd2s_blank;
> +	data->consw.con_set_palette	= lcd2s_set_palette;
> +	data->consw.con_scrolldelta	= lcd2s_scrolldelta;
> +
> +	i2c_set_clientdata(i2c, data);
> +
> +	take_over_console(&data->consw, LCD2S_FIRST, LCD2S_LAST, 1);
> +
> +	return 0;
> +}

It's better to define the struct consw as a preinitialized
'static const' object, rather than dynamically setting each
member.

> +static struct i2c_driver lcd2s_i2c_driver = {
> +	.driver = {
> +		.name = "lcd2s",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = lcd2s_i2c_probe,
> +	.remove = __devexit_p(lcd2s_i2c_remove),
> +	.id_table = lcd2s_i2c_id,
> +};
> +
> +static int __init lcd2s_modinit(void)
> +{
> +	int ret = 0;
> +
> +	ret = i2c_add_driver(&lcd2s_i2c_driver);
> +	if (ret != 0)
> +		pr_err("Failed to register lcd2s driver\n");
> +
> +	return ret;
> +}
> +module_init(lcd2s_modinit)
> +
> +static void __exit lcd2s_exit(void)
> +{
> +	i2c_del_driver(&lcd2s_i2c_driver);
> +}
> +module_exit(lcd2s_exit)

Here, you can use module_i2c_driver.

	Arnd

