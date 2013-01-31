From: Alexandre Courbot <gnurou@gmail.com>
Date: Thu, 31 Jan 2013 04:24:19 +0000
Subject: Re: [RFC 1/4] video: panel: add CLAA101WA01A panel support
Message-Id: <CAAVeFuJf9Ww7g8Q9RAG9Na1SZq2-n2MMxcAEBek52ZVG7RpL7g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359514939-15653-1-git-send-email-acourbot@nvidia.com>
 <1359514939-15653-2-git-send-email-acourbot@nvidia.com> <5108C9C1.1090707@gmail.com>
 <51098064.7030902@wwwdotorg.org> <5109EA2A.8020204@gmail.com>
In-Reply-To: <5109EA2A.8020204-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Zhang <nvmarkzhang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On Thu, Jan 31, 2013 at 12:51 PM, Mark Zhang <nvmarkzhang@gmail.com> wrote:
>> DDC access is a property of the display controller, not the panel
>> itself. The panel might be hooked up to a display controller's DDC/I2C
>> channel as the target, but it isn't the host/controller of the DDC/I2C
>> channel. As such, placing the nvidia,ddc property into the display
>> controller node makes sense.
>>
>
> Yes, DC triggers the DDC access and is the host of the DDC/I2C channel.
> So I think it's reasonable to put nvidia,ddc property into the display
> controller node. But the video mode info in EDID which be fetched via
> DDC is the property of the panel, so this info should be provided by
> panel driver. Actually display controller cares about the video modes,
> not the way to get these info. So I think it's better to do the whole
> work like this:
>
> 1) display controller relied on CDF to call "display_entity_get_modes"
> 2) panel driver calls the function which is hooked to display controller
> to get the video modes via DDC.
> 3) if the video modes can't be fetched via DDC, panel driver provides
> the info(either by hard-coded or defined in DT) anyway

This would require a callback dedicated to this in display_entity and
would break its simple design.

> Just like I said above, display controller should not query DDC
> directly. Since CDF already defines these for us, display controller
> should call CDF's functions, like: display_entity_get_modes,
> display_entity_get_size... I think this is the key difference I wanna
> talk about. And also in this way, display controller doesn't need to
> care about this 2 steps logics, just call "display_entity_get_modes" is OK.

Well the fact is that it *is* the display controller that queries DDC
directly. The panel is just a bus here, and the EDID EEPROM could
perfectly work without it. If you model what you described with DT
nodes, I'm afraid you will end up with something both complex (with DC
node referencing panel node and back again for the EDID bus) and that
does not picture reality accurately.

Alex.
