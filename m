From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Nov 2016 08:25:17 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <CAMuHMdVdPOGQx+kKDvVmKCqws+NjngMv6kE5h-ojx4eCSUY5Fw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <20161123081932.byoasvcl322hrlin@phenom.ffwll.local>
In-Reply-To: <20161123081932.byoasvcl322hrlin@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

Hi Daniel,

On Wed, Nov 23, 2016 at 9:19 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Wed, Nov 23, 2016 at 10:03:10AM +0200, Tomi Valkeinen wrote:
>> Since the fbdev framework is in maintenance mode and all new display drivers
>> should be made with the DRM framework, remove the fbdev drivers from staging.
>>
>> Note: the patches are created with git format-patch -D, so they can't be
>> applied. Only for review.
>
> +1 from my side. Now that we have the simple pipe helpers in drm-kms, and
> a few drivers starting to use them, there's really no reasons left anymore
> to have fbdev drivers.

I haven't been following this that closely, so can you please point me to a
sample DRM driver using this simple pipe helper?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
