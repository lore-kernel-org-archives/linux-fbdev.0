From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 25 Aug 2014 13:39:55 +0000
Subject: Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140825133953.GJ4163@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="dwWFXG4JqVa0wfCP"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
In-Reply-To: <20140825124410.GZ15297@lukather>
To: linux-arm-kernel@lists.infradead.org


--dwWFXG4JqVa0wfCP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2014 at 02:44:10PM +0200, Maxime Ripard wrote:
> On Mon, Aug 25, 2014 at 02:12:30PM +0200, Thierry Reding wrote:
> > On Wed, Aug 13, 2014 at 07:01:06PM +0200, Maxime Ripard wrote:
> > > On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
> > [...]
> > > > If not, perhaps the clock driver should force the clock to be
> > > > enabled (perhaps only if the DRM/KMS driver isn't enabled?).
> > >=20
> > > I'm sorry, but I'm not going to take any code that will do that in our
> > > clock driver.
> > >=20
> > > I'm not going to have a huge list of ifdef depending on configuration
> > > options to know which clock to enable, especially when clk_get should
> > > have the consumer device as an argument.
> >=20
> > Are you saying is that you want to solve a platform-specific problem by
> > pushing code into simple, generic drivers so that your platform code can
> > stay "clean"?
>=20
> Are you saying that this driver would become "dirty" with such a patch?

Yes. Others have said the same and even provided alternative solutions
on how to solve what's seemingly a platform-specific problem in a
platform-specific way.

> If so, we really have an issue in the kernel.

Can you elaborate?

Thierry

--dwWFXG4JqVa0wfCP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT+zypAAoJEN0jrNd/PrOhqS8P/3nfivCZMtwAEPmbXXlGpKk6
cwKi2hPmb7tHrTDcJEa8q5uDFRzrIm/wOLKRoqGXyf/Vo+zFNVjz8exuKH6zCaoD
Djh3nTHD/wKd8vcVHQzBijtvLfp5vptQLnCmlMeuTf2jy54M3I0FYyRiT8D9cTtr
bkNtjm7Te6lMPd1EU7Aj/ANTnVnMgXMQPx97Sy33aA+vgEOmLeepLVFtOref64Z5
+Eqe86e4cYSzxp2+FbpZQ++rkesroGSIx7oWj2Hq+7B7gbaqfGqyOPVamkED4/ei
fLETdSDXlq8Ed13STlS/MkfatqzZtNSoOnt957yxZu2elTBDK/bbHBTa6NiPdmWf
se11YglXk0tH1ZukkIBETL4K8LOysWIJBx2HKE6HHCEgsaPy1gebtUwEPkIxbYTy
vsOJmkS//br7wtQqFrxIBKJfAzH0ffQronnZvoJc1kEl1aDxqCdbGDQz24Oc/TaD
SkQcvOaIJSJgjWzENWDjADBYK7OUioh1scIUCXVZBA4aJhG5pnxXVdAhR9JtFyYe
roRIy+h5vPh+DHWnJq7PFAtDM14bLcAb+Rrf16u/WZkFfYyRdwyFwuphoX4T7cDh
j+eZDN/CeebbceUE6Ec+mHW6xrFJZrxDXNVyPf50WfERCQ3589MK81aNAdF0Ixt1
hYLgsbSfANSgtZ0dHbIs
=UQuH
-----END PGP SIGNATURE-----

--dwWFXG4JqVa0wfCP--
