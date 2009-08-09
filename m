From: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH 3/3] drivers/video: Correct use of 
	request_region/request_mem_region
Date: Sun, 9 Aug 2009 11:24:21 +0200
Message-ID: <10f740e80908090224p13d2119do9e4f4d7730ed001e@mail.gmail.com>
References: <Pine.LNX.4.64.0908090943560.13271@ask.diku.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753485AbZHIJYX@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0908090943560.13271@ask.diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
To: Julia Lawall <julia@diku.dk>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-mips@linux-mips.org

On Sun, Aug 9, 2009 at 09:44, Julia Lawall<julia@diku.dk> wrote:
> From: Julia Lawall <julia@diku.dk>
>
> request_region should be used with release_region, not request_mem_re=
gion.
>
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @r1@
> expression start;
> @@
>
> request_region(start,...)
>
> @b1@
> expression r1.start;
> @@
>
> request_mem_region(start,...)
>
> @depends on !b1@
> expression r1.start;
> expression E;
> @@
>
> - release_mem_region
> + release_region
> =C2=A0(start,E)
> // </smpl>
>
> Signed-off-by: Julia Lawall <julia@diku.dk>
>
> ---
> =C2=A0drivers/video/gbefb.c =C2=A0| =C2=A0 =C2=A04 ++--
> =C2=A0drivers/video/tdfxfb.c | =C2=A0 =C2=A04 ++--
> =C2=A02 files changed, 4 insertions(+), 4 deletions(-)
>
> diff -u -p a/drivers/video/gbefb.c b/drivers/video/gbefb.c
> --- a/drivers/video/gbefb.c
> +++ b/drivers/video/gbefb.c
> @@ -1246,7 +1246,7 @@ out_tiles_free:
> =C2=A0out_unmap:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iounmap(gbe);
> =C2=A0out_release_mem_region:
> - =C2=A0 =C2=A0 =C2=A0 release_mem_region(GBE_BASE, sizeof(struct sgi=
_gbe));
> + =C2=A0 =C2=A0 =C2=A0 release_region(GBE_BASE, sizeof(struct sgi_gbe=
));

GBE_BASE seems to be MMIO (it's mapped using ioremap()), so it looks li=
ke the
release_mem_region() is actually correct, while the request_region() sh=
ould be
request_mem_region() instead

> =C2=A0out_release_framebuffer:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0framebuffer_release(info);
>
> @@ -1265,7 +1265,7 @@ static int __devexit gbefb_remove(struct
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iounmap(gbe_me=
m);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_free_coherent(NULL, GBE_TLB_SIZE * siz=
eof(uint16_t),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(void *)gbe_tiles.cpu, gbe_tiles.dma);
> - =C2=A0 =C2=A0 =C2=A0 release_mem_region(GBE_BASE, sizeof(struct sgi=
_gbe));
> + =C2=A0 =C2=A0 =C2=A0 release_region(GBE_BASE, sizeof(struct sgi_gbe=
));

Ditto.

> diff -u -p a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
> --- a/drivers/video/tdfxfb.c
> +++ b/drivers/video/tdfxfb.c
> @@ -1571,8 +1571,8 @@ out_err_iobase:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (default_par->mtrr_handle >=3D 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mtrr_del(defau=
lt_par->mtrr_handle, info->fix.smem_start,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 info->fix.smem_len);
> - =C2=A0 =C2=A0 =C2=A0 release_mem_region(pci_resource_start(pdev, 2)=
,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0pci_resource_len(pdev, 2));
> + =C2=A0 =C2=A0 =C2=A0 release_region(pci_resource_start(pdev, 2),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pci_resource_len(pdev, 2));
> =C2=A0out_err_screenbase:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (info->screen_base)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iounmap(info->=
screen_base);

This one looks OK.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
