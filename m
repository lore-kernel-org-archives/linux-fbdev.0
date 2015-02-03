From: Kevin Hao <haokexin@gmail.com>
Date: Tue, 03 Feb 2015 02:20:02 +0000
Subject: Re: [PATCH 05/15] fbdev: imsttfb: remove the dependency on PPC_OF
Message-Id: <20150203022002.GB28170@pek-khao-d1.corp.ad.wrs.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="yNb1oOkm5a9FJOVX"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-6-git-send-email-haokexin@gmail.com>
 <20150201134433.729a2389@canb.auug.org.au>
 <20150201055150.GA6681@pek-khao-d1.corp.ad.wrs.com>
In-Reply-To: <20150201055150.GA6681@pek-khao-d1.corp.ad.wrs.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linuxppc-dev@lists.ozlabs.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 01, 2015 at 01:51:50PM +0800, Kevin Hao wrote:
> > > diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imst=
tfb.c
> > > index aae10ce74f14..91a80bb8f988 100644
> > > --- a/drivers/video/fbdev/imsttfb.c
> > > +++ b/drivers/video/fbdev/imsttfb.c
> > > @@ -1470,7 +1470,6 @@ static int imsttfb_probe(struct pci_dev *pdev, =
const struct pci_device_id *ent)
> > >  	unsigned long addr, size;
> > >  	struct imstt_par *par;
> > >  	struct fb_info *info;
> > > -#ifdef CONFIG_PPC_OF
> > >  	struct device_node *dp;
> >=20
> > I see no way in this file for struct device_node to be defined
> > (especially if CONFIG_PPC is not set).  of.h may be included
> > implicitly, but that is very dependent on the architecture and CONFIG_
> > options.
>=20
> This do pass the build test for the non-OF archs, such as x86. But your
> concerns sound pretty reasonable, so I will explicitly include of.h.

I took a second look at this. It seems that there is a declaration of
struct device_node in linux/device.h and there is also no access to the
member of device_node in this driver. So we are safe to not include of.h he=
re.
That is also why I didn't get the build failure for the non-OF archs. :-)

Thanks,
Kevin

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU0DBSAAoJEJNY7TDerrFxguMH/1KHo4SR7qPMXNkwmOJW/iJg
KLStj8GkCGOiFnnCL+xGvSrjWAyhPT9L9uImtuciHKcZ6uRt74PsmiLml/cQ7scs
i0j4zPip9Bgce6TitqnMb0+FgN0l/5cwjX8WqdMkUnMfB6svhokygPcrgwBLPvm+
yDaXrUe3ZtK1CfzeIgPAwMa/HiCAG0uRkAIKWHkYsKxd96+ABtXjpVRCt98bH7j2
pVNB2/PAe1lIhF4uIwAnmN5aNDBJVjHPjnyepx99Xfh9SbSe6CSInl9DXyi/L2YW
NyPptAfi6/QD2Azygebf3vvxTyJa/4tMW9n6W+mZ4E5TBgci+Bgt6+GCAY+i6ss=
=27FZ
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
