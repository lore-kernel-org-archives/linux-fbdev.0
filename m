From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 25 Aug 2014 12:12:30 +0000
Subject: Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140825121228.GB4163@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MW5yreqqjyrRcusr"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
In-Reply-To: <20140813170106.GT15297@lukather>
To: linux-arm-kernel@lists.infradead.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2014 at 07:01:06PM +0200, Maxime Ripard wrote:
> On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
[...]
> > If not, perhaps the clock driver should force the clock to be
> > enabled (perhaps only if the DRM/KMS driver isn't enabled?).
>=20
> I'm sorry, but I'm not going to take any code that will do that in our
> clock driver.
>=20
> I'm not going to have a huge list of ifdef depending on configuration
> options to know which clock to enable, especially when clk_get should
> have the consumer device as an argument.

Are you saying is that you want to solve a platform-specific problem by
pushing code into simple, generic drivers so that your platform code can
stay "clean"?

Thierry

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT+ygsAAoJEN0jrNd/PrOh+8cP+gKsZ9xE9JReLJXvmAxGWf2H
ZmNaUUaRk5X6i0IRHv07ZyiY5Nh/ir1EY4QY705rcc8MKvfM9+NlcH73lCGKSJYL
t71WdTY4Gg912NlAr1AAhXsOmMPVT3tegfpsOrMndlAAqp7ZV6I6u7J2vwnbqH4F
wptToc/pBBSGp6oEsLRLz1e2q1jk1/MILJdXB5WGvH2oQ0BMfx8hrOo5ImcDKh2p
T0qqxWPp4c4G+/c0CLdrau6AcVdeEN1hjLX6Omb0T+zZHDftSUAEA7BlpSrqtngx
BvNmctYh9U7yJfyoMqJ8v2guFlq8pq1srrRGvdxpQAQyygSWDOq40KGcVjGq/F6+
5I0vGmoOE7tw9zRKbtvBCjw7dGHxJOXl+OkeC/kKIxPC1Agd8VzsAGtcT7uCLoXg
2RChvz37dqIL9G/fBVjarI6hcO1leul6G94WO8BXeg4dgipsEX2l2P4gzhBWOrFI
BkaoyIPID/qpdEVFcwOQK26k6y+3b7Hl48uf8J1h54uYvlt0w1MVxfrkcvFwKsf6
3RgTAdgnfgnJMprIfT2+Nk1DJmfI555SRJo5pDkkQIBapD8gV6sEZZMe6KAMdaXE
7STiJl+ayn6oyGEQz+KM1wOecnAHvFMdN6hAa4I/Hiw8WohayEjOeG8kWzfMz/wX
Y/x99ArRjD4RO02sLI4H
=NT3s
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
