From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 26 Sep 2015 08:28:06 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <CAMuHMdVAO8Ua4G1DRMxTKxqJaAb4xBTQie-nvOkYJ7sox-YCYw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
 <20150924144621.40e26f0a@free-electrons.com>
 <20150924152312.GV3383@phenom.ffwll.local>
In-Reply-To: <20150924152312.GV3383@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Arnaud Patard <apatard@mandriva.com>, Dave Airlie <airlied@redhat.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Hi Daniel,

On Thu, Sep 24, 2015 at 5:23 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, Sep 24, 2015 at 02:46:21PM +0200, Thomas Petazzoni wrote:
>> Or are there some plans to make the writing of DRM drivers for very
>> simple/trivial devices a bit simpler?
>
> Since years I'm trying to sell someone on implementing support for
> drm_simple_outputs which would collapse the crtc->encoder->connector
> chain into 1 entity. Would be trivial to implement and then trivial to
> write simple drivers on top of that. And besides that drm already has
> piles of reallly simple drivers with just one output and one framebuffer.
>
> There's no reason not to use drm for gfx drivers at all.

Good to hear that!

For the (mailing list) record, can you please provide some explicit pointers
to these existing really simple drivers?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
