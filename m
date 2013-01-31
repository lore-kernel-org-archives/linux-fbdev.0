From: Mark Zhang <nvmarkzhang@gmail.com>
Date: Thu, 31 Jan 2013 07:30:52 +0000
Subject: Re: [RFC 1/4] video: panel: add CLAA101WA01A panel support
Message-Id: <510A1DAC.1070106@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359514939-15653-1-git-send-email-acourbot@nvidia.com> <1359514939-15653-2-git-send-email-acourbot@nvidia.com> <5108C9C1.1090707@gmail.com> <51098064.7030902@wwwdotorg.org> <5109EA2A.8020204@gmail.com> <CAAVeFuJf9Ww7g8Q9RAG9Na1SZq2-n2MMxcAEBek52ZVG7RpL7g@mail.gmail.com> <5109F916.8080404@gmail.com> <CAAVeFuL_a1aAEDCFdhjMzZG40QuK3dcZqsWqfVpwmQbZsfiHRg@mail.gmail.com>
In-Reply-To: <CAAVeFuL_a1aAEDCFdhjMzZG40QuK3dcZqsWqfVpwmQbZsfiHRg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

On 01/31/2013 02:36 PM, Alexandre Courbot wrote:
> On Thu, Jan 31, 2013 at 1:54 PM, Mark Zhang <nvmarkzhang@gmail.com> wrote:
>> Display controller don't know whether the panel has EDID EEPROM but the
>> panel driver knows. So why we need to make display controller queries
>> EDID blindly? Since panel driver knows about all "video modes/panel
>> size" stuffs, why not we let it handle all these things?
> 
> The DC actually does know whether the connected panel supports EDID -
> in this case, the output node will have a property for the DDC bus,
> e.g.
> 
>         nvidia,ddc-i2c-bus = <&lcd_ddc>;
> 
> If no DDC bus is specified or if transfer fails, the DC driver can
> still query the panel driver for hardcoded modes.
> 

Strictly speaking, according to my understanding, "nvidia,ddc-i2c-bus"
means tegra has a hardware ddc channel, this doesn't mean we can get the
EDID from this DDC surely.

> Also passing a function pointer to get_modes() does not relief the DC
> driver from probing for the DDC bus. You will still have to handle
> both conditions (DDC bus present or not), the check will just be moved
> into your callback function.
> 

Yes. But panel driver decides whether the DDC probing is needed. If the
panel has an EEPROM, it can call the function which display controller
provides to do a DDC probing, it not, panel driver just ignores this
function pointer and return the hardcoded modes directly.

> Alex.
> 
