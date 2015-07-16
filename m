From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 Jul 2015 23:41:16 +0000
Subject: Re: [PATCH v2 01/12] device: property: delay device-driver matches
Message-Id: <CAJZ5v0gMx=DA0f8i9wdMvkYTyOhr0WKh-T6L7rjcxeaAjNMW3g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
	<1435743667-11987-2-git-send-email-tomeu.vizoso@collabora.com>
	<20150716202312.GD11162@sirena.org.uk>
In-Reply-To: <20150716202312.GD11162-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>

Hi Mark,

On Thu, Jul 16, 2015 at 10:23 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jul 01, 2015 at 11:40:56AM +0200, Tomeu Vizoso wrote:
>
>> Delay matches of platform devices until late_initcall, when we are sure
>> that all built-in drivers have been registered already. This is needed
>> to prevent deferred probes because of some dependencies' drivers not
>> having registered yet.
>
> I have to say I'm still not 100% clear that special casing platform
> devices makes sense here - I can see that platform devices are usually
> the first devices to instantiate but there are other kinds of devices
> and it's not obvious what the benefit of specifically picking out
> platform devices as opposed to just deferring all devices is.

Some existing devices cannot be deferred without redesigning things quite a bit.

What I was talking about, though, was to use an opt-in mechanism for
that which could be set for all platform devices, for example, by
default, but it might be set for other bus types too if that's useful.

Thanks,
Rafael
