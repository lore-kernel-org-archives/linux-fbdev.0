From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 30 Sep 2015 11:59:13 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <CACvgo53=6ZjxiouystVCf=jgoG9e9JZ0oOv_iMecAz58h4SDyA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
	<20150924144621.40e26f0a@free-electrons.com>
	<20150924152312.GV3383@phenom.ffwll.local>
	<CAMuHMdVAO8Ua4G1DRMxTKxqJaAb4xBTQie-nvOkYJ7sox-YCYw@mail.gmail.com>
	<CADnq5_NL5p+sRzOvVpr=JnZ-e-vGtDD-69qapQMKawWtfVRnCw@mail.gmail.com>
	<CAMuHMdX0Jg9RSu9rm2-trtMCDpS16Zy8VLEnmjvW_vWVWvHdVQ@mail.gmail.com>
	<CANq1E4TN4_NNs32LBcNWeDC2jUtT2TCYHfYeummEC5-TQn7BpA@mail.gmail.com>
	<CAMuHMdWdyTay2nX5CFPOUQQjVxFTTcZF=sVaNDziTs6GV2DGqQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWdyTay2nX5CFPOUQQjVxFTTcZF=sVaNDziTs6GV2DGqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Herrmann <dh.herrmann@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Arnaud Patard <apatard@mandriva.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Airlie <airlied@redhat.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Hi all,

On 26 September 2015 at 19:46, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi David,
>
> On Sat, Sep 26, 2015 at 8:13 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
>> On Sat, Sep 26, 2015 at 8:01 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> On Sat, Sep 26, 2015 at 7:07 PM, Alex Deucher <alexdeucher@gmail.com> wrote:
>>>> On Sat, Sep 26, 2015 at 4:28 AM, Geert Uytterhoeven
>>>> <geert@linux-m68k.org> wrote:
>>>>> For the (mailing list) record, can you please provide some explicit pointers
>>>>> to these existing really simple drivers?
>>>>
>>>> See the tilcdc, ast, mgag200, and udl drivers for example.
>>>
>>> Thanks for the list!
>>>
>>> The smallest of these (udl) still counts in at ca. 2800 LoC, while there are
>>> several fbdev drivers that have less than 200 LoC.
>>> Granted, these really small ones support a single fixed video mode only, but
>>> you can write a simple fbdev driver with mode setting in less than 1000 LoC.
>>>
>>> I'm sure DRM can do better?
>>
>> Is counting lines really the level of the discussion to go here?
>
> LoC is not the most important. But if the smallest DRM driver needs an order
> of magnitude more LoC than the smallest fbdev driver, I start to wonder.
>
> E.g. if I want to write a new simple driver for my new shiny hardware, it
> can make a big difference if I have to write (and test/debug) 800 LoC, or
> 3000 LoC.
>
Ftr, the smallest DRM/KMS driver that I could see is the layerscape
(fsl-dcu) one. It is roughly 1.4k LoC which includes ~300 worth of
defines, licence headers and build glue. Admittedly not it's not as
low as 200-800 LoC, but it's an example that they can get smaller, as
helpers in drm core are added. udl has been written quite some time
ago and doesn't make use of atomics, etc. the latter of which should
make things easier/shorter.

Regards,
Emil
