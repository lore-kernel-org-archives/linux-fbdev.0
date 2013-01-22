From: Alex Courbot <acourbot@nvidia.com>
Date: Tue, 22 Jan 2013 03:24:34 +0000
Subject: Re: [PATCH 2/3] tegra: pwm-backlight: add tegra pwm-bl driver
Message-Id: <12033649.LY58cllSHv@percival>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358591420-7790-1-git-send-email-acourbot@nvidia.com> <1358591420-7790-3-git-send-email-acourbot@nvidia.com> <50FD7EF9.1010205@wwwdotorg.org>
In-Reply-To: <50FD7EF9.1010205-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On Tuesday 22 January 2013 01:46:33 Stephen Warren wrote:
> >  arch/arm/boot/dts/tegra20-ventana.dts  |  18 +++-
> >  arch/arm/configs/tegra_defconfig       |   1 +
> >  drivers/video/backlight/Kconfig        |   7 ++
> >  drivers/video/backlight/pwm_bl.c       |   3 +
> >  drivers/video/backlight/pwm_bl_tegra.c | 159
> >  +++++++++++++++++++++++++++++++++
> This should be at least 3 separate patches: (1) Driver code (2) Ventana
> .dts file (3) Tegra defconfig.

Will do that.

> If this is Ventana-specific, this should have a vendor prefix; "nvidia,"
> would be appropriate.
> 
> But, why is this Ventana-specific; surely it's at most panel-specific,
> or perhaps even generic across any/most LCD panels?

Yes, we could use the panel model here instead. Not sure how many other panels 
follow the same powering sequence though.

Making it Ventana-specific would have allowed to group all Tegra board support 
into the same driver, and considering that probably not many devices use the 
same panels as we do this seemed to make sense at first.

> > +		power-supply = <&vdd_bl_reg>;
> 
> "power" doesn't seem like a good regulator name; power to what? Is this
> for the backlight, since I see there's a panel-supply below?
> 
> > +		panel-supply = <&vdd_pnl_reg>;
> > 
> > +		bl-gpio = <&gpio 28 0>;
> > +		bl-panel = <&gpio 10 0>;
> 
> GPIO names usually have "gpios" in their name, so I assume those should
> be bl-enable-gpios, panel-enable-gpios?

Indeed, even though there is only one gpio here. Maybe we could group them 
into a single property and retrieve them by index - that's what the DT GPIO 
APIs seem to be designed for initially.

> > +static struct pwm_backlight_subdriver pwm_backlight_ventana_subdriver = {
> > +	.name = "pwm-backlight-ventana",
> > +	.init = init_ventana,
> > +	.exit = exit_ventana,
> > +	.notify = notify_ventana,
> > +	.notify_after = notify_after_ventana,
> > +};
> 
> It seems like all of that code should be completely generic.

Sorry, I don't get your point here - could you elaborate?

> Rather than invent some new registration mechanism, if we need
> board-/panel-/...-specific drivers, it'd be better to make each of those
> specific drivers a full platform device in an of itself (i.e. regular
> Linux platform device/driver, have its own probe(), etc.), and have
> those specific drivers call into the base PWM backlight code, treating
> it like a utility API.

That's what would make the most sense indeed, but would require some extra 
changes in pwm-backlight and might go against Thierry's wish to keep it 
simple. On the other hand I totally agree this would be more elegant. Every 
pwm-backlight based driver would just need to invoke pwm_bl's probe/remove 
function from its own. Thierry, would that be an acceptable alternative to the 
sub-driver thing despite the slightly deeper changes this involves?

Thanks,
Alex.

