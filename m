From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 28 Dec 2010 02:48:56 +0000
Subject: Re: [PATCH 3/5] fbdev: sh_mobile_lcdc: increase maximum framebuffer
Message-Id: <AANLkTinH1Qog6RST7P1fn_UjvMMo6b8eMpSehyD=gLyD@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1011041200050.13123@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1011041200050.13123@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Mon, Dec 27, 2010 at 10:41 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Mon, 27 Dec 2010, Magnus Damm wrote:
>> On Sun, Dec 26, 2010 at 6:44 AM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> > Paul, apart from increasing the fb size to 1080p, this patch also fixe=
s a
>> > regression, which leads to unusable by applications framebuffer on some
>> > platforms, including migor. This happens, when one of parameters lies
>> > outside of limits, being checked in sh_mobile_check_var(). On migor it=
 is
>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.left_margin =3D 0,
>> >
>> > Then the fb-console is working, but, e.g., mplayer is not. So, we need
>> > this patch in 2.6.37 too, please. Unfortunately, it also introduces a
>> > wrong format printk format, which a later patch of yours fixes, so, you
>> > might want to push that patch too, although, that's not that important.
>>
>> It's great that you work on fixing this issue, thank you.
>>
>> In the long run I wonder if it's best to try to get rid of the
>> MAX_XRES/MAX_YRES stuff from the LCDC driver. I understand that you
>> need to allocate the frame buffer memory early on, but it would be
>> much better if the maximum values could be kept in platform data. The
>> maximum resolution varies with CPU type, so a one-for-all modification
>> like this may break older platforms.
>
> Hm, I'l not sure how it can break other platforms. You mean they just will
> fail to allocate that much RAM? Otherwise it shouldn't cause any problems.
> But yes, I'll make an incremental patch to let platform override those
> values, and use defaults otherwise, would that be ok?

There seem to be two ways to specify the maximum LCDC resolution today:

1) The highest resolution specified by the lcd_cfg array.
2) The default MAX_XRES / MAX_YRES.

Your patch is good in the sense that it starts using the limits from
above in check_var(), but only for case 2). Perhaps it would be good
to walk the lcd_cfg arrray to handle case 1) too?

Also, about case 2), I don't really see why we need it. I would much
prefer to treat missing platform data information as an error case.

With the current hard coded MAX_XRES / MAX_YRES the driver needs to be
updated now and then. I'm sure there are many good reasons to update
the driver, but having to do so just to increase the max resolution
seems a bit silly to me. Also, with the MAX_XRES / MAX_YRES there is a
silent assumption about the maximum resolution that has nothing to do
with the LCDC hardware capabilities at all.

I understand you may need to allocate memory early for the hotplug
HDMI case, but it must be possible to specify the maximum resolution
with platform data in that case too, no?

As for breaking other platforms, if there are any users of the LCDC
driver in mode 2) above that assume that MAX_XRES / MAX_YRES allocate
720p memory then they may break with this patch. The pain may be
limited to allocating more memory than actually needed though, but
that may cause a run-time error anyway depending on the MAX_ZONEORDER
kernel configuration.

So if possible I'd like to get rid of 2) above. And use the lcd_cfg
array in check_var(). Does it make sense?

Thanks,

/ magnus
