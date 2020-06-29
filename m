From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Mon, 29 Jun 2020 21:10:27 +0000
Subject: Re: [PATCH] Remove handhelds.org links and email addresses
Message-Id: <20200629211027.GA1481@kunai>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200629203121.7892-1-grandmaster@al2klimov.de>
In-Reply-To: <20200629203121.7892-1-grandmaster@al2klimov.de>
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: ulf.hansson@linaro.org, gustavo@embeddedor.com, tony@atomide.com, daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, mchehab+samsung@kernel.org, lee.jones@linaro.org, corbet@lwn.net, linux-samsung-soc@vger.kernel.org, aaro.koskinen@iki.fi, robert.jarzmik@free.fr, rafael.j.wysocki@intel.com, yuehaibing@huawei.com, linux@armlinux.org.uk, krzk@kernel.org, kgene@kernel.org, viresh.kumar@linaro.org, kuba@kernel.org, arnd@arndb.de, b.zolnierkie@samsung.com, jani.nikula@intel.com, linux-mmc@vger.kernel.org, linux-input@vger.kernel.org, j.neuschaefer@gmx.net, haojian.zhuang@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, yanaijie@huawei.com, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Julia.Lawall@inria.fr, netdev@vger.kernel.org, davem@davemloft.net, daniel@zonque.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alexander,

thanks for trying to fix this, yet I have some doubts.

On Mon, Jun 29, 2020 at 10:31:21PM +0200, Alexander A. Klimov wrote:
> Rationale:
> https://lore.kernel.org/linux-doc/20200626110706.7b5d4a38@lwn.net/

I think we need some text here. Clicking on a link to understand what a
patch is about is not comfortable. You can add the link with a Link: tag
for additional information.

Removing stale email addresses may have some value, but removing...

>  Compaq's Bootldr + John Dorsey's patch for Assabet support
> -(http://www.handhelds.org/Compaq/bootldr.html)

... information like this is not good. 'Wayback machine' still has
copies in case someone wants to look at where the infos came from.

> - * Copyright 2004-2005  Phil Blundell <pb@handhelds.org>
> + * Copyright 2004-2005  Phil Blundell

This is an OK case in my book...


> -MODULE_AUTHOR("Phil Blundell <pb@handhelds.org>");
> +MODULE_AUTHOR("Phil Blundell");

... same here ...

> @@ -435,7 +435,6 @@
>                             case a PCI bridge (DEC chip 21152). The value of
>                             'pb' is now only initialized if a de4x5 chip is
>                             present.
> -                           <france@handhelds.org>

This is kind of a signature and should be kept IMO.

>   * 2001/07/23: <rmk@arm.linux.org.uk>
> - *	- Hand merge version from handhelds.org CVS tree.  See patch
> + *	- Hand merge version from CVS tree.  See patch

That information may be useful.


>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /* -*- linux-c -*-
> - *
> - * (C) 2003 zecke@handhelds.org

Removing copyright is a bad idea.

Probably some comment blocks are cruft meanwhile and can be removed as a
whole. That can be discussed. But removing only the handhelds.org part
makes most parts worse IMHO.

Thanks and happy hacking,

   Wolfram


--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl76WMAACgkQFA3kzBSg
KbZgWA/+IxRkb15JXVvwYM1c4ReuUiEUrJ0KOI0M0XELe0YWelDrhgcOtSC0ozRT
lTt8uizNNBK4bsRpoo+ghjZvNELOeMx+4VsVtMM+IoXXxIKha1jSJ1hqFDsBcCP0
urAvhdaNyC+TWmEM2H98eb5JfdSxKxrzjIMs4tTBlZOBnu+wAoiDZv4mPf/y1bGv
L33lwlFG6tkWpVX2veVNoTg04TG0LupAtXUyiI+Hnxt7srbugymQs0iwtd5sCt2R
AG+BmuN5zmUS5cISCL6p1uXSxVRrs3FI02dwU7m5yvBfvHHSGVsx+f9wPpnpqNc8
1I3oAR+Ct2K3lvu3uLBY2xDL4WbTmPobmzGLXbwB8ksPC/B1TV5LC/+TI2F+c+gk
ROaTdQqzt4H0wfzNFOzYT8zGyZOoiPFro7jxCcH9CZjbkeDi19sJt7TQ6I1B0I9+
bSTAb7s3yWhzUypFHzdR0PT97e8zeiK/xJUTbPkvv+JsDZZvPht423X7CYEUjaCo
sPQ5UuDSfS4xT25PBabjhNeunmODzCE/+DrtbOSuM5AV63TOoVMB8zWBoJH17emH
mRgD29xeEITWlq/fBWcPWIjgFDVanjDPYIW2/jnGqm7RLTaw703ajQSbD/7ELOAB
84gr1NpIeJuhMnRnB11nHCJsUWnRqvl2rt7lretb/tFUB8LhGFE=
=FQ9k
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
