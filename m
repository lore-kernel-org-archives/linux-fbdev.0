From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 04 Jun 2010 20:54:54 +0000
Subject: Re: HDMI timing parameters problem
Message-Id: <AANLkTimVSBjRCMeKgg8U9VhTvfGCOp3QjOFASuP2rjVL@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1006041332020.19386@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1006041332020.19386@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Fri, Jun 4, 2010 at 21:54, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Fri, 4 Jun 2010, Geert Uytterhoeven wrote:
>> On Fri, Jun 4, 2010 at 17:27, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> > I'm trying to configure an HDMI controller on an ARM based SoC, and I
>> > cannot seem to find suitable values for blanking parameters.
>> >
>> > The monitor EDID reports 1280x1024@108MHz:
>> >
>> > H_ACTIVE = 1280
>> > H_SYNC_OFFSET = 48
>> > H_SYNC_WIDTH = 112
>> > H_BLANKING = 408
>> >
>> > V_ACTIVE = 1024
>> > V_SYNC_OFFSET = 1
>> > V_SYNC_WIDTH = 3
>> > V_BLANKING = 42
>> >
>> > The HDMI controller can be programmed in one of two modes: with a preset
>> > configuration or manually specifying each parameter. The only mode that
>> > somehow works up to now is the preset 1280x720@74.25MHz. With this mode
>> > the image on the monitor is stretched vertically, but it works.
>> > Unfortunately, the controller doesn't have any preset modes for 1280x1024
>> > or for anything close enough. So, I have to support manual geometry
>> > configuration. To reduce the number of required changes, as a first step,
>> > I'm trying to achieve the same result in manual mode, as I've got with
>> > preset, by programming 1280x720. For this I've chosen the following
>> > configuration:
>> >
>> >        .xres = 1280,
>> >        .yres = 720,
>> >        .left_margin = 224,
>> >        .right_margin = 104,
>> >        .hsync_len = 40,
>> >        .upper_margin = 20,
>> >        .lower_margin = 5,
>> >        .vsync_len = 5,
>> >
>> > which is the same, as what I'm configuring my LCD controller
>> > with. This translates to
>> >
>> > H_ACTIVE = 1280
>> > H_SYNC_OFFSET = 104
>> > H_SYNC_WIDTH = 40
>> > H_BLANKING = 368
>> >
>> > V_ACTIVE = 720
>> > V_SYNC_OFFSET = 5
>> > V_SYNC_WIDTH = 5
>> > V_BLANKING = 30
>> >
>> > With it the monitor recognises the signal, the LED goes green, but there's
>> > no image.
>> >
>> > I've done a few more tests with various configurations, but so far with no
>> > success. Can anyone suggest how to debug this? How to find the proper
>> > video mode?
>>
>> The timings I calculated from the HDTV specs for ps3fb are slightly different.
>> But you may want to give them a try.
>
> You're referring to this mode from drivers/video/ps3fb.c:
>
>    }, {
>        /* SXGA */
>        "sxga", 60, 1280, 1024, 9259, 248, 48, 38, 1, 112, 3,
>        FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED,
>        FB_MODE_IS_VESA
>    }, {
>
> right? Interestingly, those are exactly the values, that my monitor is
> reporting, also quoted at the top of this mail:
>
> 248 + 48 + 112 = 408
> 38 + 1 + 3 = 42
>
> , and I cannot seem to get them to work:( hmm...

I didn't check the 1280x1024 mode, only the 1280x720 mode (cfr. 720pf in ps3fb).

Perhaps it's a sync polarity issue? Traditionally, you have positive
and negative
sync pulses, but HDTV uses a tri-state sync pulse (don't remember the
exact details).
The HDMI chip may support HDTV sync only.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
