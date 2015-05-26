From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 May 2015 07:23:18 +0000
Subject: Re: [RFC PATCH] video/logo: introduce new system state for checking if logos are freed
Message-Id: <CAMuHMdWe6nLBaOvjB4wW=AmigU3ib8-wdCycre9G9o5RPwB=mg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430896145-8887-1-git-send-email-hs@denx.de>
	<5562B9CE.7050807@ti.com>
	<5563EEF9.3080901@denx.de>
	<556418A9.8010603@ti.com>
	<CAMuHMdWHP6i15Z2qZJBEW9uz7kh1_ET5N1VbOKoMw1EC7F3O0g@mail.gmail.com>
	<55641D89.5020103@ti.com>
In-Reply-To: <55641D89.5020103@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: hs@denx.de, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Hi Tomi,

On Tue, May 26, 2015 at 9:15 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> 3) Draw the logos from an initcall on all frame buffers that exist at that
>>    point in time. Yes, this will destroy (part of) the content that's
>>    currently shown.
>
> Isn't that almost the same as now? The problem is that the fb probes are
> deferred to a very late stage, so we would not have the fbs when the
> suggested initcall would be called.

Currently it's drawn from fbcon_switch().

Some drivers draw it independently from the fbcon code
(au1200fb_drv_probe() and mmpfb_probe()).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
