From: Stephen Warren <swarren@wwwdotorg.org>
Date: Mon, 21 Jan 2013 17:46:33 +0000
Subject: Re: [PATCH 2/3] tegra: pwm-backlight: add tegra pwm-bl driver
Message-Id: <50FD7EF9.1010205@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358591420-7790-1-git-send-email-acourbot@nvidia.com> <1358591420-7790-3-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1358591420-7790-3-git-send-email-acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

On 01/19/2013 03:30 AM, Alexandre Courbot wrote:
> Add a PWM-backlight subdriver for Tegra boards, with support for
> Ventana.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra20-ventana.dts  |  18 +++-
>  arch/arm/configs/tegra_defconfig       |   1 +
>  drivers/video/backlight/Kconfig        |   7 ++
>  drivers/video/backlight/pwm_bl.c       |   3 +
>  drivers/video/backlight/pwm_bl_tegra.c | 159 +++++++++++++++++++++++++++++++++

This should be at least 3 separate patches: (1) Driver code (2) Ventana
.dts file (3) Tegra defconfig.

> diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts

> +	backlight {
> +		compatible = "pwm-backlight-ventana";

If this is Ventana-specific, this should have a vendor prefix; "nvidia,"
would be appropriate.

But, why is this Ventana-specific; surely it's at most panel-specific,
or perhaps even generic across any/most LCD panels?

There needs to be binding documentation.

> +		brightness-levels = <0 16 32 48 64 80 96 112 128 144 160 176 192 208 224 240 255>;
> +		default-brightness-level = <12>;
> +
> +		pwms = <&pwm 2 5000000>;
> +		pwm-names = "backlight";
> +
> +		power-supply = <&vdd_bl_reg>;

"power" doesn't seem like a good regulator name; power to what? Is this
for the backlight, since I see there's a panel-supply below?

> +		panel-supply = <&vdd_pnl_reg>;

> +		bl-gpio = <&gpio 28 0>;
> +		bl-panel = <&gpio 10 0>;

GPIO names usually have "gpios" in their name, so I assume those should
be bl-enable-gpios, panel-enable-gpios?

> diff --git a/drivers/video/backlight/pwm_bl_tegra.c b/drivers/video/backlight/pwm_bl_tegra.c

> +static void exit_ventana(struct device *dev)
> +{
> +	struct ventana_bl_data *data = pwm_backlight_get_subdriver_data(dev);
> +
> +	devm_gpio_free(dev, data->panel_gpio);
> +	devm_gpio_free(dev, data->bl_gpio);
> +	devm_regulator_put(data->vdd_panel);
> +	devm_regulator_put(data->vdd_power);
> +	devm_kfree(dev, data);
> +}

There shouldn't be a need to explicitly free devm-allocated objects in
almost all cases; that's the whole point of the devm APIs.

> +static struct pwm_backlight_subdriver pwm_backlight_ventana_subdriver = {
> +	.name = "pwm-backlight-ventana",
> +	.init = init_ventana,
> +	.exit = exit_ventana,
> +	.notify = notify_ventana,
> +	.notify_after = notify_after_ventana,
> +};

It seems like all of that code should be completely generic.

> +static int __init pwm_backlight_tegra_init(void)
> +{
> +	pwm_backlight_add_subdriver(&pwm_backlight_ventana_subdriver);
> +	return 0;
> +}
> +
> +static void __exit pwm_backlight_tegra_exit(void)
> +{
> +	pwm_backlight_remove_subdriver(&pwm_backlight_ventana_subdriver);
> +}
> +
> +module_init(pwm_backlight_tegra_init);
> +module_exit(pwm_backlight_tegra_exit);

Rather than invent some new registration mechanism, if we need
board-/panel-/...-specific drivers, it'd be better to make each of those
specific drivers a full platform device in an of itself (i.e. regular
Linux platform device/driver, have its own probe(), etc.), and have
those specific drivers call into the base PWM backlight code, treating
it like a utility API.

> +MODULE_DESCRIPTION("Backlight Driver for Tegra boards");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:pwm-tegra-backlight");
> +
> +

Some extra blank lines there.
