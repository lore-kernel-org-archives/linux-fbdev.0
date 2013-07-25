From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 25 Jul 2013 10:11:32 +0000
Subject: Re: [PATCH V2] driver/vga16fb.c: remove the unused variable "dev" of function vga16fb_destroy()
Message-Id: <CAMuHMdXWpdTD4sHat9sm5pvXVeGNNKMF6eEN=bUK4qU0H6i1Aw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51F0F88D.8060903@cn.fujitsu.com>
In-Reply-To: <51F0F88D.8060903@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Thu, Jul 25, 2013 at 12:06 PM, Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:
> Commit e21d2170f36602ae2708 ("video: remove unnecessary
> platform_set_drvdata()") removed the unnecessary platform_set_drvdata(),
> but left the variable "dev" unused, delete it.
>
> v2:
>    Following Geert's suggestion to make change log easier reading.
>
> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
> ---

Please send a v3, which has the version info under the above "---",
instead of making it a part of the patch description to be committed.

Thanks again!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
