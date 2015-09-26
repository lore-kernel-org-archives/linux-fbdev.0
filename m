From: Dave Airlie <airlied@gmail.com>
Date: Sat, 26 Sep 2015 21:55:46 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <CAPM=9twQjvrjvgPR4Y6wTZ6yBT+hKv5f0YQk0Uq=pxsMsy4agw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
	<20150924144621.40e26f0a@free-electrons.com>
	<20150924152312.GV3383@phenom.ffwll.local>
	<CAMuHMdVAO8Ua4G1DRMxTKxqJaAb4xBTQie-nvOkYJ7sox-YCYw@mail.gmail.com>
	<CADnq5_NL5p+sRzOvVpr=JnZ-e-vGtDD-69qapQMKawWtfVRnCw@mail.gmail.com>
	<CAMuHMdX0Jg9RSu9rm2-trtMCDpS16Zy8VLEnmjvW_vWVWvHdVQ@mail.gmail.com>
	<CANq1E4TN4_NNs32LBcNWeDC2jUtT2TCYHfYeummEC5-TQn7BpA@mail.gmail.com>
	<CAMuHMdWdyTay2nX5CFPOUQQjVxFTTcZF=sVaNDziTs6GV2DGqQ@mail.gmail.com>
	<CAF6AEGvqFXf8BgDz6dT4EX95La6PgQjj0ZzK2j3aW8_MvqRL1w@mail.gmail.com>
In-Reply-To: <CAF6AEGvqFXf8BgDz6dT4EX95La6PgQjj0ZzK2j3aW8_MvqRL1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Clark <robdclark@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Arnaud Patard <apatard@mandriva.com>, Dave Airlie <airlied@redhat.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

On 27 September 2015 at 06:49, Rob Clark <robdclark@gmail.com> wrote:
> On Sat, Sep 26, 2015 at 2:46 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> Hi David,
>>
>> On Sat, Sep 26, 2015 at 8:13 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
>>> On Sat, Sep 26, 2015 at 8:01 PM, Geert Uytterhoeven
>>> <geert@linux-m68k.org> wrote:
>>>> On Sat, Sep 26, 2015 at 7:07 PM, Alex Deucher <alexdeucher@gmail.com> wrote:
>>>>> On Sat, Sep 26, 2015 at 4:28 AM, Geert Uytterhoeven
>>>>> <geert@linux-m68k.org> wrote:
>>>>>> For the (mailing list) record, can you please provide some explicit pointers
>>>>>> to these existing really simple drivers?
>>>>>
>>>>> See the tilcdc, ast, mgag200, and udl drivers for example.
>>>>
>>>> Thanks for the list!
>>>>
>>>> The smallest of these (udl) still counts in at ca. 2800 LoC, while there are
>>>> several fbdev drivers that have less than 200 LoC.
>>>> Granted, these really small ones support a single fixed video mode only, but
>>>> you can write a simple fbdev driver with mode setting in less than 1000 LoC.
>>>>
>>>> I'm sure DRM can do better?
>>>
>>> Is counting lines really the level of the discussion to go here?
>>
>> LoC is not the most important. But if the smallest DRM driver needs an order
>> of magnitude more LoC than the smallest fbdev driver, I start to wonder.
>
> I think most of the drm/kms drivers are bigger due to more features..
> iirc original tilcdc was ~2k loc (compared to ~1.6kloc for da8xx-fb),
> but it already supported multiple modes, page flipping, vblank
> notification, etc.  It has grown since then.  Although still probably
> smaller than downstream da8xx-fb + tda998x hdmi bridge (and re-using
> the same tda998x bridge code with several other drivers too, compared
> to downstream solution for the same)..
>
> Probably there is room for more helpers for even more restrictive hw.

My main worry for having helpers for "simple" hw, is that people start
using them
to have a minimal 400loc driver, but once they add any feature outside
the helper
they have to rewrite their driver to avoid the helpers.

Most of the drm driver is boilerplate, we could possibly reduce the boilerplate,
but I'm not sure it's worth the effort to save somebody a small bit of
trouble at
bringup.

loc is a pointless tool for measuring this, a small drm driver will be as simple
as a small fbdev driver, and will likely provide more features that people need.

Dave.
