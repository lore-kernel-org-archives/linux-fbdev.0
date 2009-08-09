From: Julia Lawall <julia@diku.dk>
Subject: Re: [Linux-fbdev-devel] [PATCH 3/3] drivers/video: Correct use of 
 request_region/request_mem_region
Date: Sun, 9 Aug 2009 11:33:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0908091132160.13271@ask.diku.dk>
References: <Pine.LNX.4.64.0908090943560.13271@ask.diku.dk>
 <10f740e80908090224p13d2119do9e4f4d7730ed001e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-511516320-771632445-1249810387=:13271"
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <10f740e80908090224p13d2119do9e4f4d7730ed001e@mail.gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: <fbdev-devel.lists.sourceforge.net
To: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-mips@linux-mips.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---511516320-771632445-1249810387=:13271
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks forthe information. I will fix the occurrences in gbefb.c and then=20
submit a revised vesion of the complete patch.

julia


On Sun, 9 Aug 2009, Geert Uytterhoeven wrote:

> On Sun, Aug 9, 2009 at 09:44, Julia Lawall<julia@diku.dk> wrote:
> > From: Julia Lawall <julia@diku.dk>
> >
> > request_region should be used with release_region, not request_mem_regi=
on.
> >
> > The semantic patch that fixes this problem is as follows:
> > (http://coccinelle.lip6.fr/)
> >
> > // <smpl>
> > @r1@
> > expression start;
> > @@
> >
> > request_region(start,...)
> >
> > @b1@
> > expression r1.start;
> > @@
> >
> > request_mem_region(start,...)
> >
> > @depends on !b1@
> > expression r1.start;
> > expression E;
> > @@
> >
> > - release_mem_region
> > + release_region
> > =A0(start,E)
> > // </smpl>
> >
> > Signed-off-by: Julia Lawall <julia@diku.dk>
> >
> > ---
> > =A0drivers/video/gbefb.c =A0| =A0 =A04 ++--
> > =A0drivers/video/tdfxfb.c | =A0 =A04 ++--
> > =A02 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff -u -p a/drivers/video/gbefb.c b/drivers/video/gbefb.c
> > --- a/drivers/video/gbefb.c
> > +++ b/drivers/video/gbefb.c
> > @@ -1246,7 +1246,7 @@ out_tiles_free:
> > =A0out_unmap:
> > =A0 =A0 =A0 =A0iounmap(gbe);
> > =A0out_release_mem_region:
> > - =A0 =A0 =A0 release_mem_region(GBE_BASE, sizeof(struct sgi_gbe));
> > + =A0 =A0 =A0 release_region(GBE_BASE, sizeof(struct sgi_gbe));
>=20
> GBE_BASE seems to be MMIO (it's mapped using ioremap()), so it looks like=
 the
> release_mem_region() is actually correct, while the request_region() shou=
ld be
> request_mem_region() instead
>=20
> > =A0out_release_framebuffer:
> > =A0 =A0 =A0 =A0framebuffer_release(info);
> >
> > @@ -1265,7 +1265,7 @@ static int __devexit gbefb_remove(struct
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iounmap(gbe_mem);
> > =A0 =A0 =A0 =A0dma_free_coherent(NULL, GBE_TLB_SIZE * sizeof(uint16_t),
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(void *)gbe_tiles.cp=
u, gbe_tiles.dma);
> > - =A0 =A0 =A0 release_mem_region(GBE_BASE, sizeof(struct sgi_gbe));
> > + =A0 =A0 =A0 release_region(GBE_BASE, sizeof(struct sgi_gbe));
>=20
> Ditto.
>=20
> > diff -u -p a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
> > --- a/drivers/video/tdfxfb.c
> > +++ b/drivers/video/tdfxfb.c
> > @@ -1571,8 +1571,8 @@ out_err_iobase:
> > =A0 =A0 =A0 =A0if (default_par->mtrr_handle >=3D 0)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mtrr_del(default_par->mtrr_handle, info-=
>fix.smem_start,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info->fix.smem_len);
> > - =A0 =A0 =A0 release_mem_region(pci_resource_start(pdev, 2),
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_resource_len(p=
dev, 2));
> > + =A0 =A0 =A0 release_region(pci_resource_start(pdev, 2),
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_resource_len(pdev, 2));
> > =A0out_err_screenbase:
> > =A0 =A0 =A0 =A0if (info->screen_base)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iounmap(info->screen_base);
>=20
> This one looks OK.
>=20
> Gr{oetje,eeting}s,
>=20
> 						Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
> 							    -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
---511516320-771632445-1249810387=:13271--
