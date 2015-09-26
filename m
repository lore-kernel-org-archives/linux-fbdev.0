From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 26 Sep 2015 18:01:11 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <CAMuHMdX0Jg9RSu9rm2-trtMCDpS16Zy8VLEnmjvW_vWVWvHdVQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
 <20150924144621.40e26f0a@free-electrons.com>
 <20150924152312.GV3383@phenom.ffwll.local>
 <CAMuHMdVAO8Ua4G1DRMxTKxqJaAb4xBTQie-nvOkYJ7sox-YCYw@mail.gmail.com>
 <CADnq5_NL5p+sRzOvVpr=JnZ-e-vGtDD-69qapQMKawWtfVRnCw@mail.gmail.com>
In-Reply-To: <CADnq5_NL5p+sRzOvVpr=JnZ-e-vGtDD-69qapQMKawWtfVRnCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnaud Patard <apatard@mandriva.com>, Dave Airlie <airlied@redhat.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Hi Alex,

On Sat, Sep 26, 2015 at 7:07 PM, Alex Deucher <alexdeucher@gmail.com> wrote:
> On Sat, Sep 26, 2015 at 4:28 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Thu, Sep 24, 2015 at 5:23 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
>>> On Thu, Sep 24, 2015 at 02:46:21PM +0200, Thomas Petazzoni wrote:
>>>> Or are there some plans to make the writing of DRM drivers for very
>>>> simple/trivial devices a bit simpler?
>>>
>>> Since years I'm trying to sell someone on implementing support for
>>> drm_simple_outputs which would collapse the crtc->encoder->connector
>>> chain into 1 entity. Would be trivial to implement and then trivial to
>>> write simple drivers on top of that. And besides that drm already has
>>> piles of reallly simple drivers with just one output and one framebuffer.
>>>
>>> There's no reason not to use drm for gfx drivers at all.
>>
>> Good to hear that!
>>
>> For the (mailing list) record, can you please provide some explicit pointers
>> to these existing really simple drivers?
>
> See the tilcdc, ast, mgag200, and udl drivers for example.

Thanks for the list!

The smallest of these (udl) still counts in at ca. 2800 LoC, while there are
several fbdev drivers that have less than 200 LoC.
Granted, these really small ones support a single fixed video mode only, but
you can write a simple fbdev driver with mode setting in less than 1000 LoC.

I'm sure DRM can do better?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
