From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 15 Apr 2020 14:36:37 +0000
Subject: Re: [PATCH v1 1/5] video: ssd1307fb: Convert driver to use ->probe_new()
Message-Id: <3f4e53db-e933-b5ba-82fe-2a839ed11a87@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200324170532.44384-1-andriy.shevchenko@linux.intel.com>
 <20200330095144.GL1922688@smile.fi.intel.com>
 <CGME20200415142020eucas1p2b9c75eee5c24918c3c657386345f0732@eucas1p2.samsung.com>
 <20200415142018.GH185537@smile.fi.intel.com>
In-Reply-To: <20200415142018.GH185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-fbdev@vger.kernel.org, xllacyx@gmail.com, dri-devel@lists.freedesktop.org


[ added dri-devel to Cc: ]

Hi,

On 4/15/20 4:20 PM, Andy Shevchenko wrote:
> On Mon, Mar 30, 2020 at 12:51:44PM +0300, Andy Shevchenko wrote:
>> On Tue, Mar 24, 2020 at 07:05:28PM +0200, Andy Shevchenko wrote:
>>> Use the ->probe_new() callback.
>>>
>>> The driver does not use const struct i2c_device_id * argument,
>>> so convert it to utilise the simplified I=C2=B2C driver registration.
>>>
>>
>> Bartlomiej, any comments on the series?
>=20
> Do I need to do something with the series?

It hasn't been lost :), just handling of fbdev patches posted too
late for v5.7 has been postponed after v5.7-rc1 release.

LGTM after quick look.

I'll review it properly / apply later this week (hopefully tomorrow).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> ---
>>>  drivers/video/fbdev/ssd1307fb.c | 10 ++--------
>>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1=
307fb.c
>>> index 142535267fec..397eae246c2c 100644
>>> --- a/drivers/video/fbdev/ssd1307fb.c
>>> +++ b/drivers/video/fbdev/ssd1307fb.c
>>> @@ -586,8 +586,7 @@ static const struct of_device_id ssd1307fb_of_match=
[] =3D {
>>>  };
>>>  MODULE_DEVICE_TABLE(of, ssd1307fb_of_match);
>>> =20
>>> -static int ssd1307fb_probe(struct i2c_client *client,
>>> -			   const struct i2c_device_id *id)
>>> +static int ssd1307fb_probe(struct i2c_client *client)
>>>  {
>>>  	struct backlight_device *bl;
>>>  	char bl_name[12];
>>> @@ -599,11 +598,6 @@ static int ssd1307fb_probe(struct i2c_client *clie=
nt,
>>>  	void *vmem;
>>>  	int ret;
>>> =20
>>> -	if (!node) {
>>> -		dev_err(&client->dev, "No device tree data found!\n");
>>> -		return -EINVAL;
>>> -	}
>>> -
>>>  	info =3D framebuffer_alloc(sizeof(struct ssd1307fb_par), &client->dev=
);
>>>  	if (!info)
>>>  		return -ENOMEM;
>>> @@ -808,7 +802,7 @@ static const struct i2c_device_id ssd1307fb_i2c_id[=
] =3D {
>>>  MODULE_DEVICE_TABLE(i2c, ssd1307fb_i2c_id);
>>> =20
>>>  static struct i2c_driver ssd1307fb_driver =3D {
>>> -	.probe =3D ssd1307fb_probe,
>>> +	.probe_new =3D ssd1307fb_probe,
>>>  	.remove =3D ssd1307fb_remove,
>>>  	.id_table =3D ssd1307fb_i2c_id,
>>>  	.driver =3D {
>>> --=20
>>> 2.25.1
>>>
>>
>> --=20
>> With Best Regards,
>> Andy Shevchenko
