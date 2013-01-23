From: Alex Courbot <acourbot@nvidia.com>
Date: Wed, 23 Jan 2013 10:29:16 +0000
Subject: Re: [PATCH 2/3] tegra: pwm-backlight: add tegra pwm-bl driver
Message-Id: <3208798.X7kqxH1FjQ@percival>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358591420-7790-1-git-send-email-acourbot@nvidia.com> <1358591420-7790-3-git-send-email-acourbot@nvidia.com> <CAL1wa8d2BS3RxdsdUyCqF20ZKe46jUZcfUKitnpP9Lgb9aB5hw@mail.gmail.com>
In-Reply-To: <CAL1wa8d2BS3RxdsdUyCqF20ZKe46jUZcfUKitnpP9Lgb9aB5hw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Leela Krishna Amudala <leelakrishna.a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On Wednesday 23 January 2013 18:15:30 Leela Krishna Amudala wrote:
> > +       pwm_backlight_set_subdriver_data(dev, data);
> 
> Here you are passing ventana_bl_data pointer as input and in the
> pwm_backlight_get_subdriver_data() function you are assigning the
> received driver data to backlight_device pointer. As both are two
> different structures with different structure fields in it. There can
> be a chance for a crash.

That's because the following happens later in pwm_backlight_probe():

	pb->subdriver_data = dev_get_drvdata(&pdev->dev);
	...
	bl = backlight_device_register(dev_name(&pdev->dev), &pdev->dev, pb,
				       &pwm_backlight_ops, &props);
	...
	platform_set_drvdata(pdev, bl);

So from then on the result of dev_get_drvdata() is indeed an instance of 
backlight_device from which we can retrieve the subdriver data. I'm not really 
proud of this. But fortunately it seems like we are going to do things 
differently.

Alex.

