From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 26 Sep 2015 17:07:46 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <CADnq5_NL5p+sRzOvVpr=JnZ-e-vGtDD-69qapQMKawWtfVRnCw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
 <20150924144621.40e26f0a@free-electrons.com>
 <20150924152312.GV3383@phenom.ffwll.local>
 <CAMuHMdVAO8Ua4G1DRMxTKxqJaAb4xBTQie-nvOkYJ7sox-YCYw@mail.gmail.com>
In-Reply-To: <CAMuHMdVAO8Ua4G1DRMxTKxqJaAb4xBTQie-nvOkYJ7sox-YCYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnaud Patard <apatard@mandriva.com>, Dave Airlie <airlied@redhat.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

On Sat, Sep 26, 2015 at 4:28 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Daniel,
>
> On Thu, Sep 24, 2015 at 5:23 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
>> On Thu, Sep 24, 2015 at 02:46:21PM +0200, Thomas Petazzoni wrote:
>>> Or are there some plans to make the writing of DRM drivers for very
>>> simple/trivial devices a bit simpler?
>>
>> Since years I'm trying to sell someone on implementing support for
>> drm_simple_outputs which would collapse the crtc->encoder->connector
>> chain into 1 entity. Would be trivial to implement and then trivial to
>> write simple drivers on top of that. And besides that drm already has
>> piles of reallly simple drivers with just one output and one framebuffer.
>>
>> There's no reason not to use drm for gfx drivers at all.
>
> Good to hear that!
>
> For the (mailing list) record, can you please provide some explicit pointers
> to these existing really simple drivers?

See the tilcdc, ast, mgag200, and udl drivers for example.

Alex

>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
