From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sat, 25 Aug 2018 19:48:14 +0000
Subject: Re: [PATCH] mach64: fix console corruption in 24bpp mode
Message-Id: <alpine.LRH.2.02.1808241640120.1210@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="185206533-1481688517-1535144012=:1210"
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.02.1808171514010.31883@file01.intranet.prod.int.rdu2.redhat.com>
 <20180819102628.GA11867@sci.fi>
In-Reply-To: <20180819102628.GA11867@sci.fi>
To: =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185206533-1481688517-1535144012=:1210
Content-Type: TEXT/PLAIN; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-ID: <alpine.LRH.2.02.1808251546581.8284@file01.intranet.prod.int.rdu2.redhat.com>



On Sun, 19 Aug 2018, Ville Syrj=E4l=E4 wrote:

> On Fri, Aug 17, 2018 at 03:15:52PM -0400, Mikulas Patocka wrote:
> > There's console font corruption when using the mach64 driver in 24bpp
> > mode.
> >=20
> > In 24bpp mode, the mach64 accelerator is set up for 8-bpp mode (with
> > horizontal width and stride multiplied by 3). In this mode, the
> > accelerator can't even possibly support color expansion. Consquently, we
> > have to use an unaccelerated function cfb_imageblit for color expansion.
>=20
> Hmm. I would think it should work just fine since we feed in each bit
> three times and the hw 24bpp rotate thing should take care of selecting
> the right component.
>=20
> -               if (M64_HAS(HW_TRIPLE) && image->width % 8 =3D=3D 0)
> +               if (M64_HAS(HW_TRIPLE) && width % 8 =3D=3D 0)
> 		                        pix_width |=3D DP_HOST_TRIPLE_EN;
> perhaps?

This doesn't have any effect (width is image->width * 3 and multiplication =

by 3 doesn't affect divisibility by 8).

But I have looked at it deeper and I realized that we could fix the screen =

corruption and use the accelerator in 24bpp mode. I'll send the patches in =

following emails.

There's endianity problem in the code that does manual bit triple in=20
atyfb_imageblit (I am using this driver on sparc64). After fixing this,=20
some of the corruption is fixed, but not all of it (there's still=20
corruption when the screen is scrolled).

Another bug is that the function atyfb_imageblit is reading the=20
accelerator registers without waiting for the idle engine - so it reads=20
some indetermediate value of some previous command. I reworked the=20
accelerator functions so that they don't read the registers at all. After=20
fixing these two bugs, I don't observe any corruption at all.

I also noticed that loading the bitmap is inefficient - for every word=20
written, the driver reads the fifo status register and these reads are=20
slow and cannot be queued. I improved the function wait_for_fifo, so that=20
if there's more space than we need, it remembers the surplus and it=20
doesn't have to read the register next time.

Mikulas
--185206533-1481688517-1535144012=:1210--
