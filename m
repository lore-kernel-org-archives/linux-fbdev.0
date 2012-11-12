From: Grazvydas Ignotas <notasas@gmail.com>
Date: Mon, 12 Nov 2012 13:39:45 +0000
Subject: Re: [PATCH 0/5] OMAPFB: use dma_alloc instead of omap's vram
Message-Id: <CANOLnOO0yMabku-_3yhi=1bwohbrb=rtFDOuKf1LPCAFv_OqCQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi,

On Mon, Nov 12, 2012 at 12:25 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wr=
ote:
> This series changes omapfb to use standard dma_alloc funcs instead of omap
> specific vram allocator. This let's us remove the omap vram allocator, ma=
king
> omapfb platform independent.
>
> However, note that using standard dma funcs causes the following downside=
s:
>
> ...
>
> 3) OMAPFB_GET_VRAM_INFO ioctl cannot return real values anymore. I
> changed the ioctl to return 64M for all the values, which, I hope, the
> applications will interpret as "there's enough vram".

Do at least OMAPFB_QUERY_MEM/OMAPFB_SETUP_MEM still work?

> 4) "vram" kernel parameter to define how much ram to reserve for video us=
e no
> longer works. The user needs to enable CMA and use "cma" parameter.

That's a significant change, you should update Documentation/ .
What about omapfb.vram, is it still there?
Perhaps we also need to select/depend on CMA?


--=20
Gra=C5=BEvydas
