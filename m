From: Stephen Warren <swarren@wwwdotorg.org>
Date: Tue, 22 Jan 2013 16:30:03 +0000
Subject: Re: [PATCH 2/3] tegra: pwm-backlight: add tegra pwm-bl driver
Message-Id: <50FEBE8B.60101@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358591420-7790-1-git-send-email-acourbot@nvidia.com> <1358591420-7790-3-git-send-email-acourbot@nvidia.com> <50FD7EF9.1010205@wwwdotorg.org> <12033649.LY58cllSHv@percival>
In-Reply-To: <12033649.LY58cllSHv@percival>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On 01/21/2013 08:24 PM, Alex Courbot wrote:
> On Tuesday 22 January 2013 01:46:33 Stephen Warren wrote:
>>>  arch/arm/boot/dts/tegra20-ventana.dts  |  18 +++-
>>>  arch/arm/configs/tegra_defconfig       |   1 +
>>>  drivers/video/backlight/Kconfig        |   7 ++
>>>  drivers/video/backlight/pwm_bl.c       |   3 +
>>>  drivers/video/backlight/pwm_bl_tegra.c | 159

>>> +static struct pwm_backlight_subdriver pwm_backlight_ventana_subdriver = {
>>> +	.name = "pwm-backlight-ventana",
>>> +	.init = init_ventana,
>>> +	.exit = exit_ventana,
>>> +	.notify = notify_ventana,
>>> +	.notify_after = notify_after_ventana,
>>> +};
>>
>> It seems like all of that code should be completely generic.
> 
> Sorry, I don't get your point here - could you elaborate?

Nothing there (i.e. in the body of any of those functions) seems
remotely specific to Ventana or even Ventana's panel; presumably it
would work for any built-in LCD panel?
