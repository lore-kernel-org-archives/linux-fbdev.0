From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 05 Apr 2014 11:35:30 +0000
Subject: Re: [PATCH v3 2/2] video: da8xx-fb: Fix casting of info->pseudo_palette
Message-Id: <CAMuHMdWnVxh5PSUrTRW0+f0WEN91-C9WLRBqT55STg2N5v4+RA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1396355974-2257-1-git-send-email-jon@ringle.org>
	<1396355974-2257-2-git-send-email-jon@ringle.org>
	<533E8E49.1030307@ti.com>
In-Reply-To: <533E8E49.1030307@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: jon@ringle.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Jon Ringle <jringle@gridpoint.com>, "Etheridge, Darren" <detheridge@ti.com>

Hi Tomi,

On Fri, Apr 4, 2014 at 12:49 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> I wonder why the pseudo_palette in fb.h is 'void *' in the first place.
> It seems to be cast to 'u32 *' everywhere...

Historically, this was driver-specific. Many drivers stored u16 pixel values.

I guess it can be changed to u32 now, dropping all casts.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
