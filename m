From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 14 Mar 2015 22:02:43 +0000
Subject: Re: [PATCH 4/8] fbdev: ssd1307fb: Use vmalloc to allocate video memory.
Message-Id: <CAMuHMdXTinYuQTpQGc6WyVNpCOhAHPrkHKfRRQAM3Wy6Cg4wvQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
	<1423261694-5939-5-git-send-email-niederp@physik.uni-kl.de>
	<20150207111821.GN2079@lukather>
	<20150207163541.30047a33@maestro.intranet>
	<20150212151121.GJ2079@lukather>
	<20150214152212.1643da7d@maestro.intranet>
	<54FED559.2030506@ti.com>
	<20150313223128.2a3a682e@maestro.intranet>
In-Reply-To: <20150313223128.2a3a682e@maestro.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Thomas_Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Mar 13, 2015 at 10:31 PM, Thomas Niederpr=C3=BCm
<niederp@physik.uni-kl.de> wrote:
> Am Tue, 10 Mar 2015 13:28:25 +0200
> schrieb Tomi Valkeinen <tomi.valkeinen@ti.com>:
>> Also, isn't doing __pa() for the memory returned by vmalloc plain
>> wrong?
>
>> What was the crash about when using kmalloc? It would be good to fix
>> defio, as I don't see why it should not work with kmalloced memory.
>
> The main challenge here is that the memory handed to userspace upon
> mmap call needs to be page aligned. The memory returned by kmalloc has
> no such alignment, but the pointer presented to the userspace program
> gets aligned to next page boundary. It's not clear to me whether there
> is an easy way to obtain page aligned kmalloc memory. Memory
> allocated by vmalloc on the other hand is always aligned to page
> boundaries. This is why I chose to go for vmalloc.

__get_free_pages()?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
