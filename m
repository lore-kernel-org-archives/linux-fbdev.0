From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 20 Nov 2019 15:28:50 +0000
Subject: Re: [PATCH v1 3/5] fbtft: Drop useless #ifdef CONFIG_OF and dead code
Message-Id: <20191120152850.GQ32742@smile.fi.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191120095716.26628-1-andriy.shevchenko@linux.intel.com>
 <20191120095716.26628-3-andriy.shevchenko@linux.intel.com>
 <37435de0-873d-d20c-ac66-420ba91356fd@tronnes.org>
 <676c3f0e-81b7-d9be-8b37-a38eb3d762fb@tronnes.org>
In-Reply-To: <676c3f0e-81b7-d9be-8b37-a38eb3d762fb@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, Nishad Kamdar <nishadkamdar@gmail.com>, dri-devel@lists.freedesktop.org

On Wed, Nov 20, 2019 at 04:04:17PM +0100, Noralf Tr=F8nnes wrote:
> Den 20.11.2019 15.43, skrev Noralf Tr=F8nnes:
> > Den 20.11.2019 10.57, skrev Andy Shevchenko:

> >> First of all there is no need to guard GPIO request by CONFIG_OF.
> >> It works for everybody independently on resource provider. While here,
> >> rename the function to reflect the above.
> >>
> >> Moreover, since we have a global dependency to OF, the rest of
> >> conditional compilation is no-op, i.e. it's always be true.
> >>
> >> Due to above drop useless #ifdef CONFIG_OF and therefore dead code.
> >>
> >> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> ---
> >>  drivers/staging/fbtft/fbtft-core.c | 19 ++-----------------
> >>  1 file changed, 2 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtf=
t/fbtft-core.c
> >=20
> > <snip>
> >=20
> >> @@ -1184,17 +1176,10 @@ static struct fbtft_platform_data *fbtft_probe=
_dt(struct device *dev)
> >>  		pdata->display.backlight =3D 1;
> >>  	if (of_find_property(node, "init", NULL))
> >>  		pdata->display.fbtftops.init_display =3D fbtft_init_display_dt;
> >> -	pdata->display.fbtftops.request_gpios =3D fbtft_request_gpios_dt;
> >> +	pdata->display.fbtftops.request_gpios =3D fbtft_request_gpios;
> >=20
> > You can ditch the .request_gpios callback and call fbtft_request_gpios()
> > directly in fbtft_register_framebuffer(). That will make it safe to drop
> > the OF dependency, otherwise .request_gpios will be NULL in the non-DT
> > case. This is one of the bugs that follwed the gpio refactoring.
>=20
> Really difficult to read this fbtft code (that I wrote...).
> The NULL deref can only happen when dev->platform_data is set. That
> can't happen, in mainline at least, now that fbtft_device is gone.

Hmm... If I read code correctly this patch doesn't change this logic. We ha=
ve
non-NULL ->request_gpios() in case of pdata !=3D NULL if and only if suppli=
er
gives it to us.

The above assignment happens only for DT case (fbtft_properties_read() is
guarded against non-DT, okay non-fwnode, cases).

> > You can also ditch the .request_gpios_match callback if you want, it
> > isn't called anymore (it is set in fb_agm1264k-fl).

I guess both improvements can be done later since they are not affecting the
logic in this series.

--=20
With Best Regards,
Andy Shevchenko
