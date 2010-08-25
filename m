From: Erik Gilling <konkers@android.com>
Date: Wed, 25 Aug 2010 23:56:33 +0000
Subject: Re: [PATCH] video: tegra: add tegra display controller and fb driver
Message-Id: <AANLkTimTJKOgDKqpOR7LR-2gS1qQamke12m73hDru_=t@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1281568272-25871-1-git-send-email-konkers@android.com>
	<4C6379E1.4010500@bluewatersys.com>
	<AANLkTini+n1osaQHkomguzZi-DaHLX3i1G4gA82bK0=S@mail.gmail.com>
	<4C75A039.8060701@bluewatersys.com>
In-Reply-To: <4C75A039.8060701@bluewatersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 25, 2010 at 3:59 PM, Ryan Mallon <ryan@bluewatersys.com> wrote:
> On 08/26/2010 10:03 AM, Erik Gilling wrote:
>
> You sent this just to me, did you mean to post to the list also?

oops

>>>> +config FB_TEGRA
>>>> + =A0 =A0 tristate "Tegra Framebuffer driver"
>>>> + =A0 =A0 depends on TEGRA_DC && FB =3D y
>>>
>
>>>
>>> The dump_regs code is very long for a debugging feature. Can it just be
>>> replaced by a for loop which prints the offsets and values of each regi=
ster?
>>
>> Printing the names of the registers has been invaluable so far. =A0I
>> could move this to a separate file.
>
> Its useful for debugging while developing the driver, but it adds a lot
> of code. Do you expect the register dumping features to be required once
> the driver hits mainline?

I expect the driver will hit mainline is several phases.  This first
one.  One where HDMI works.  One where DSI works.  One which has
rotation.  This code is useful for all those phases.

>>>> +#undef DUMP_REG
>>>> +
>>>> +static int dbg_dc_show(struct seq_file *s, void *unused)
>>>> +{
>>>> + =A0 =A0 struct tegra_dc *dc =3D s->private;
>>>> +
>>>> + =A0 =A0 _dump_regs(dc, s, dbg_regs_print);
>>>> +
>>>> + =A0 =A0 return 0;
>>>> +}
>>>
>>> This all looks a bit confusing (especially the undef stuff). Why do you
>>> have both a debugfs interface to the registers and one which prints them
>>> using dev_dbg?
>>
>> The extra #undef was a type-o. =A0The debugfs file is useful when
>> someone brings me a misbehaving unit and I need to dump the register
>> set. =A0The dump_regs funciton is usefull when I want to look at the
>> state at different points in a code-path.
>
> If you really want to keep the debug feature then I would at least pick
> one interface or the other. The debugfs one feels a bit more standard,
> and is probably more useful to end users once the driver is in mainline.

They still fill different uses.  You can't cat a debugfs file from an
interrupt handler.  You can't call dump_regs() from userspace.  I'm
still actively using both.  I could see taking one out once
development on the driver calms down.

>>>> + =A0 =A0 tegra_dc_init(dc);
>>>> +
>>>> + =A0 =A0 tegra_dc_set_blending(dc, tegra_dc_blend_modes[0]);
>>>> +
>>>> + =A0 =A0 platform_set_drvdata(pdev, dc);
>>>> +
>>>> + =A0 =A0 tegra_dc_dbg_add(dc);
>>>> +
>>>> + =A0 =A0 dev_info(&pdev->dev, "probed\n");
>>>
>>> dev_dbg?
>>
>> I find it very useful when drivers announce when new devices are added.
>>
>
> It adds more noise to the bootlog. There are other ways to determine
> that a driver has successfully probed. If you do want to keep the
> message at least make it a bit more informative so that it prints the
> configuration out or something.

I'll add some more info to the line.

-Erik
