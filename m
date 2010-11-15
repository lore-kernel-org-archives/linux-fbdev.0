From: Dan Carpenter <error27@gmail.com>
Date: Mon, 15 Nov 2010 07:20:15 +0000
Subject: Re: [patch 2/2] fbcmap: integer overflow bug
Message-Id: <20101115072014.GB21614@bicker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101027093716.GD6062@bicker>
 <20101105134018.2c11f283.akpm@linux-foundation.org>
 <20101113100718.GB1795@bicker>
 <20101115044820.GA8489@linux-sh.org>
 <AANLkTin0T5FN6WhUj0csypR=j0UPRbeHN+HC3N9xnk7E@mail.gmail.com>
In-Reply-To: <AANLkTin0T5FN6WhUj0csypR=j0UPRbeHN+HC3N9xnk7E@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Mon, Nov 15, 2010 at 07:56:05AM +0100, Geert Uytterhoeven wrote:
> On Mon, Nov 15, 2010 at 05:48, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Sat, Nov 13, 2010 at 01:07:18PM +0300, Dan Carpenter wrote:
> >> @@ -256,8 +264,12 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, s=
truct fb_info *info)
> >> =A0 =A0 =A0 int rc, size =3D cmap->len * sizeof(u16);
> >> =A0 =A0 =A0 struct fb_cmap umap;
> >>
> >> + =A0 =A0 if (cmap->len * 2 > INT_MAX)
>=20
> Isn't that another integer overflow? I.e. should be "if (cmap->len >
> INT_MAX / sizeof(u16))" instead?
>=20

Yeah it is.  :/

I'll change it to:
	if (size < 0 || size < cmap->len)
like Paul asked.

regards,
dan carpenter

