From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Dec 2013 14:10:11 +0000
Subject: Re: [PATCH] fbmem: really support wildcard video=options for all fbdev drivers
Message-Id: <CAMuHMdX1fLsmRmJfOB3+CzDomT67G+d-S23YGtvvJad3Kthz-Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387140035-12234-1-git-send-email-olaf@aepfle.de>
In-Reply-To: <1387140035-12234-1-git-send-email-olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olaf Hering <olaf@aepfle.de>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Dec 15, 2013 at 9:40 PM, Olaf Hering <olaf@aepfle.de> wrote:
> Documentation/fb/modedb.txt states that video=option should be
> considered a global option. But video_setup and fb_get_options are not
> coded that way. Instead its required to boot with video=driver:option to
> set a given option in drvier.  This is cumbersome because it requires to
> know in advance which driver will be active for a given board/kernel.

That's an interesting finding: this definitely was working fine a few years ago.
Unfortunately I have no idea when I used it recently. I'm 100% sure I used it
with ps3fb ca. 5 years ago.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
