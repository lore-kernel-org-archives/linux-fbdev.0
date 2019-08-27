From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Aug 2019 11:35:19 +0000
Subject: Re: [PATCH v3 3/3] fbdev: fbmem: avoid exporting fb_center_logo
Message-Id: <CAMuHMdVkqX7x_D5nf01s-kE=o+y5OLM-5fd3q=2RDKGTcpCfHg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190827110854.12574-1-peda@axentia.se>
 <20190827110854.12574-4-peda@axentia.se>
In-Reply-To: <20190827110854.12574-4-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Rosin <peda@axentia.se>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Matthew Wilcox <willy@infradead.org>

Hi Peter,

On Tue, Aug 27, 2019 at 1:09 PM Peter Rosin <peda@axentia.se> wrote:
> The variable is only ever used from fbcon.c which is linked into the
> same module. Therefore, the export is not needed.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

But note that the same is true for fb_class, so perhaps it can be added
(or better, removed ;-)?

Once drivers/staging/olpc_dcon/olpc_dcon.c stops abusing registered_fb[]
and num_registered_fb, those can go, too.

Does anyone remembe why au1200fb calls fb_prepare_logo() and fb_show_logo()
itself?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
