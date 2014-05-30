From: Manuel Schoelling <manuel.schoelling@gmx.de>
Date: Fri, 30 May 2014 14:57:43 +0000
Subject: Re: [PATCH] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <1401461863.4646.9.camel@schoellingm.dzne.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401456425-15931-1-git-send-email-manuel.schoelling@gmx.de>
	 <CAMuHMdVrDB7Q+oZi_WJk07a7OF_VOJiOHxpYwRABymTKsPuMoA@mail.gmail.com>
In-Reply-To: <CAMuHMdVrDB7Q+oZi_WJk07a7OF_VOJiOHxpYwRABymTKsPuMoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mark Brown <broonie@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, David Herrmann <dh.herrmann@gmail.com>, Dave Airlie <airlied@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Geert,

On Fr, 2014-05-30 at 16:28 +0200, Geert Uytterhoeven wrote:
Hi Manuel,
>=20
> On Fri, May 30, 2014 at 3:27 PM, Manuel Sch=C3=B6lling
> <manuel.schoelling@gmx.de> wrote:
> > Add a scrollback buffers for each VGA console. The benefit is that
> > the scrollback history is not flushed when switching between
consoles
> > but is persistent.
> > The buffers are allocated on demand when a new console is opened.
>=20
> Thanks for your patch!
>=20
> I see two issues with this feature:
>   1. Before, the single (default 64 KiB) buffer was allocated at
startup.
>      Now you will allocate a buffer each time a new console is opened.
>      Depending on memory fragmentation, this may fail.
Indeed, if allocation fails, scrollbuffer[vc_num]->data will stay NULL
and scrolling will be disabled for that console. Is that ok or would you
prefer another behavior of the kernel?

>  2. People with RAM-constrained systems may not like this.
>      Can it be a config option?
Sure, I will add an option for that.

>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
geert@linux-m68k.org
>=20
> In personal conversations with technical people, I call myself a
hacker. But
> when I'm talking to journalists I just say "programmer" or something
like that.
>                                 -- Linus Torvalds
>=20

