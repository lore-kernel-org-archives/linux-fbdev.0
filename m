From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 15 Apr 2020 14:20:18 +0000
Subject: Re: [PATCH v1 1/5] video: ssd1307fb: Convert driver to use ->probe_new()
Message-Id: <20200415142018.GH185537@smile.fi.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200324170532.44384-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200324170532.44384-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Mon, Mar 30, 2020 at 12:51:44PM +0300, Andy Shevchenko wrote:
> On Tue, Mar 24, 2020 at 07:05:28PM +0200, Andy Shevchenko wrote:
> > Use the ->probe_new() callback.
> >=20
> > The driver does not use const struct i2c_device_id * argument,
> > so convert it to utilise the simplified I=B2C driver registration.
> >=20
>=20
> Bartlomiej, any comments on the series?

Do I need to do something with the series?

> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/video/fbdev/ssd1307fb.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1=
307fb.c
> > index 142535267fec..397eae246c2c 100644
> > --- a/drivers/video/fbdev/ssd1307fb.c
> > +++ b/drivers/video/fbdev/ssd1307fb.c
> > @@ -586,8 +586,7 @@ static const struct of_device_id ssd1307fb_of_match=
[] =3D {
> >  };
> >  MODULE_DEVICE_TABLE(of, ssd1307fb_of_match);
> > =20
> > -static int ssd1307fb_probe(struct i2c_client *client,
> > -			   const struct i2c_device_id *id)
> > +static int ssd1307fb_probe(struct i2c_client *client)
> >  {
> >  	struct backlight_device *bl;
> >  	char bl_name[12];
> > @@ -599,11 +598,6 @@ static int ssd1307fb_probe(struct i2c_client *clie=
nt,
> >  	void *vmem;
> >  	int ret;
> > =20
> > -	if (!node) {
> > -		dev_err(&client->dev, "No device tree data found!\n");
> > -		return -EINVAL;
> > -	}
> > -
> >  	info =3D framebuffer_alloc(sizeof(struct ssd1307fb_par), &client->dev=
);
> >  	if (!info)
> >  		return -ENOMEM;
> > @@ -808,7 +802,7 @@ static const struct i2c_device_id ssd1307fb_i2c_id[=
] =3D {
> >  MODULE_DEVICE_TABLE(i2c, ssd1307fb_i2c_id);
> > =20
> >  static struct i2c_driver ssd1307fb_driver =3D {
> > -	.probe =3D ssd1307fb_probe,
> > +	.probe_new =3D ssd1307fb_probe,
> >  	.remove =3D ssd1307fb_remove,
> >  	.id_table =3D ssd1307fb_i2c_id,
> >  	.driver =3D {
> > --=20
> > 2.25.1
> >=20
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

--=20
With Best Regards,
Andy Shevchenko
