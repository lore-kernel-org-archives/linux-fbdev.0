From: Donghwa Lee <dh09.lee@samsung.com>
Date: Fri, 09 Mar 2012 00:30:27 +0000
Subject: Re: [RFC PATCH] video:backlight: add dimming sysfs node
Message-Id: <4F594F23.9030308@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4F58573C.3020407@samsung.com> <4F587B1D.5080206@metafoo.de>
In-Reply-To: <4F587B1D.5080206@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi,
On Thu, Mar 8, 2012=EB=85=84 18:25, Lars-Peter Clausen wrote:

> On 03/08/2012 07:52 AM, Donghwa Lee wrote:
>> In backlight class, update_status() callback function is mostly used to =
change
>> backlight brightness. When platform enter the dimming state, it is usual=
ly used.
>> But, I think dimming state can be defined variety of method including br=
ightness.
>> So, it is need to differentiated node from brightness node.
>=20
> What do you mean by dimming? Completely blank the display or just lower t=
he
> brightness to a certain level > 0? In the former case the bl_power sysfs
> node already exposes such functionality. In the later case can you give an
> example how this will be used and how a typical driver would implement th=
is
> functionality?
>=20


The dimming usually means minimum backlight brightness status which is not =

completely blank. Most backlight driver uses minimum brightness by using=20
update_status() callback function so far as I know.=20

But, I think sysfs node have to use only one goals. update_status() is norm=
ally
used to change brightness.=20

I think dimming is different from changing brightness function. Others=20
functionality can be added to dimming, for example, functionality to reduce=
=20
power consumption. In each drivers, some functionalities can be implemented=
=20
how to reduce power consumption in driver not only setting minimum brightne=
ss
to enter dimming state.

That is to say, dimming status can be defined many ways and be implemented =
by=20
developers. Just that time, I think dimming node is used to interface betwe=
en
driver and platform.

Thank you,=20
Donghwa Lee

>>
>> In set_dimming() callback function, developers can define variety dimmin=
g functions.
>>
>> Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
>> Signed-off-by: Inki Dae <inki.dae@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/video/backlight/backlight.c |   37 ++++++++++++++++++++++++++++=
+++++++
>>  include/linux/backlight.h           |    9 ++++++++
>>  2 files changed, 46 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlig=
ht/backlight.c
>> index bf5b1ec..44a77e4 100644
>> --- a/drivers/video/backlight/backlight.c
>> +++ b/drivers/video/backlight/backlight.c
>> @@ -101,6 +101,43 @@ static void backlight_generate_event(struct backlig=
ht_device *bd,
>>  	sysfs_notify(&bd->dev.kobj, NULL, "actual_brightness");
>>  }
>> =20
>> +static ssize_t backlight_store_dimming(struct device *dev,
>> +		struct device_attribute *attr, const char *buf, size_t count)
>> +{
>> +	int rc;
>> +	struct backlight_device *bd =3D to_backlight_device(dev);
>> +	unsigned long dimming;
>> +
>> +	rc =3D strict_strtoul(buf, 0, &dimming);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (dimming < 0)
>> +		rc =3D -EINVAL;
>> +	else {
>> +		pr_debug("set dimming mode\n");
>> +
>> +		if (dimming)
>> +			bd->props.dimming =3D true;
>> +		else
>> +			bd->props.dimming =3D false;
>> +
>> +		backlight_set_dimming(bd);
>> +
>> +		rc =3D count;
>> +	}
>> +
>> +	return rc;
>> +}
>> +
>> +static ssize_t backlight_show_dimming(struct device *dev,
>> +		struct device_attribute *attr,char *buf)
>> +{
>> +	struct backlight_device *bd =3D to_backlight_device(dev);
>> +
>> +	return sprintf(buf, "%d\n", bd->props.dimming);
>> +}
>> +
>>  static ssize_t backlight_show_power(struct device *dev,
>>  		struct device_attribute *attr, char *buf)
>>  {
>> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
>> index 5ffc6dd..823717e 100644
>> --- a/include/linux/backlight.h
>> +++ b/include/linux/backlight.h
>> @@ -55,10 +55,13 @@ struct backlight_ops {
>>  	/* Check if given framebuffer device is the one bound to this backligh=
t;
>>  	   return 0 if not, !=3D0 if it is. If NULL, backlight always matches =
the fb. */
>>  	int (*check_fb)(struct backlight_device *, struct fb_info *);
>> +	/* Notify the backlight driver to enter the dimming state */
>> +	int (*set_dimming)(struct backlight_device *);
>>  };
>> =20
>>  /* This structure defines all the properties of a backlight */
>>  struct backlight_properties {
>> +	bool dimming;
>>  	/* Current User requested brightness (0 - max_brightness) */
>>  	int brightness;
>>  	/* Maximal value for brightness (read-only) */
>> @@ -111,6 +114,12 @@ static inline void backlight_update_status(struct b=
acklight_device *bd)
>>  	mutex_unlock(&bd->update_lock);
>>  }
>> =20
>> +static inline void backlight_set_dimming(struct backlight_device *bd)
>> +{
>> +	if (bd->ops && bd->ops->set_dimming)
>> +		bd->ops->set_dimming(bd);
>> +}
>> +
>>  extern struct backlight_device *backlight_device_register(const char *n=
ame,
>>  	struct device *dev, void *devdata, const struct backlight_ops *ops,
>>  	const struct backlight_properties *props);
>=20
>=20




