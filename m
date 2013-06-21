From: Daniel Drake <dsd@laptop.org>
Date: Fri, 21 Jun 2013 16:14:19 +0000
Subject: Re: MMP display subsystem questions
Message-Id: <CAMLZHHQFtXWx0weG3uh14Nm3euqbSqyztBEQHEQFBzjFxWGTZA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMLZHHTmSzzcL-aqk6rMjuD8Ct2zno--p7tUGfVVsocWiyhf8A@mail.gmail.com>
 <51C3BD65.8070206@marvell.com>
In-Reply-To: <51C3BD65.8070206@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jun 20, 2013 at 8:41 PM, Zhou Zhu <zzhu3@marvell.com> wrote:
> I admit it's an issue of no documents. We would submit a patch to add
> description under Documentation soon later.

That would be much appreciated. Without the required background I am
still having trouble fully understanding your reply and reviewing your
patches.

>> The overlay's address is written to a register that is specific to
>> it's parent path. If we are dealing with two overlays, how does this
>> work? We write both overlay addresses to the same register and the
>> second one "wins"? I checked all of the other overlay-related
>> functions and they all defer to the parent path as well.
>>
>> As an experiment I modified platform data to suggest that my path has
>> 98 overlays and the framebuffer should run on overlay 33. Nonsense,
>> but the framebuffer booted up as normal. It seems like there is
>> something missing in this path/overlay relationship.
>>
>> What is the plan going forward for this overlay management? At the
>> moment there is only one consumer of overlays in the kernel - the
>> framebuffer driver. And the framebuffer will only ever use one. Who
>> are the other intended in-kernel users of overlays?
>
> We have already pushed patches to fix this issue and support overlays.
> Please see patches below:
> [V2 7/7] video: mmp: add video layer set win/addr operations support
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/175071.html

At a glance, I cannot see how this patch answers any of my questions.
I will attempt to review the patches in that series and let you know
my difficulties in understanding. Hopefully that will help us write
good documentation.

>> path_config: this value gets written to registers LCD_SCLK *and*
>> IOPAD_CONTROL. The bit definitions in these registers are totally
>> different. It seems like nonsense to share the same configuration
>> value between two diversely different registers - what is going on
>> here?
>>
>> link_config: Seems to have a dual meaning. Upper 4 bits can be used to
>> specify dumb panel mode in registers like LCD_DUMB_CTRL. Bit 0 is
>> totally unrelated and triggers "swap RB" i.e. use BGR instead of RGB,
>> when dealing with totally different registers. Other bits are ignored.
>> If "disorganised" bitfields are to be haphazardly invented in this way
>> it would at least be nice to have documentation.
>
> Actually we are using mixed configs here and it is not so clear.
> We may update these config to separated configs with more clearly meanings.
> Currently 4 fields is here:
> SCLK source: select source clock for sclk. We have plan to remove it and
> move the source selection into common clock driver.
> IOPAD CONTROL: for iopad control
> DUMB CONTROL: for dumb panel mode
> RB SWAP: for rb swaps in link. Actually it's do required as for some panels
> would swap r/b links.

Yes, separating this makes sense. I look forward to the patch, with
the kind of documentation written above.

> Actually in our usage mode, we'd rather prefer to make one fb connected to
> one path.
> In many usage mode, we may need 2 or more devices (panel, external tv...)
> turned on together so 2 or more fb devices are required to connect to
> separate path.

That makes sense.

>> 4. Which overlay to use - according to my investigation above, this
>> doesn't actually have any meaningful effect on the driver.
>
> As overlay enabled in patch above now, this config is required to make fb
> show on some overlay and other interface(v4l2, private interface) to use
> others.

I don't understand this, but it might be easier to understand once you
have documented what an overlay is and how it relates to a path. How
is v4l2 going to interact with this driver? What private interfaces
are you referring to?

> So according to comments above, fb buffer is still need to be configure in
> dts for path/overlay configs.

Or can we just auto-instantiate one framebuffer per path with good defaults?

> Also there still might be some settings in fb for some further settings like
> vsync usage or yres_virtual size in coming patches.

Wouldn't such information be represented in the modes supported by the panel?

A couple more questions:

1. What is the invert_pixclock setting in the mmp_mode structure? This
causes a currently unused bit to be set in fb_videomode->vmode to be
set (seems dangerous). And then nothing acts upon this bit, as far as
I can see.

2. What about pix_fmt_out? Why is pixel format dumped into the mode
specifier? If there is a supported panel that really can support
different pixel formats, I would expect it to support all the pixel
formats for all the resolution. This also seems unused within the
driver.

Thanks
Daniel
