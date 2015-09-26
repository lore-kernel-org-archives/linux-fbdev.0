From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 26 Sep 2015 09:03:17 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <CAMuHMdWx1Fpf9FJ1wkc1_qmrhJb-k+MFui5EwsBx_-3jVdam+w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <560524E7.4020707@gmail.com>
In-Reply-To: <560524E7.4020707@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kamil Lulko <kamil.lulko@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>

On Fri, Sep 25, 2015 at 12:41 PM, Kamil Lulko <kamil.lulko@gmail.com> wrote:
>> fbdev is (more or less) maintained, but it's a deprecated framework. All
>> new Linux display drivers should be done on DRM.
>
>
> What about no-mmu platforms? DRM has a big fat MMU dependency in the
> kconfig, is there a way to write DRM driver for such devices?

That would indeed be a showstopper...

I dropped the dependency, and gave it a quick try for m68knommu.
Seems like DRM currently needs pgprot_writecombine() and pte_wrprotect().
Probably that can be fixed easily.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
