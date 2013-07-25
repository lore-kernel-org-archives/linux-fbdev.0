From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 25 Jul 2013 09:58:21 +0000
Subject: Re: [PATCH] driver/vga16fb.c: remove the unused variable "dev" of function vga16fb_destroy()
Message-Id: <CAMuHMdVxXLrUXQno+vtHQrT_mmc9C6q42HZ6F1TujLBeEZt+Mw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51F09D5E.70304@cn.fujitsu.com>
In-Reply-To: <51F09D5E.70304@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Thu, Jul 25, 2013 at 5:37 AM, Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:
> Commit  e21d2170f36602ae2708 removed the unnecessary platform_set_drvdata(),
> but left the variable "dev" unused, delete it.

When referring to another commit, please also include the oneline summary of
the commit, to make it easier for people to see what it's about.

E.g. "Commit  e21d2170f36602ae2708 ("video: remove unnecessary
platform_set_drvdata()") removed the unnecessary platform_set_drvdata(),
but left the variable "dev" unused, delete it."

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
