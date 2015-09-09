From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Sep 2015 12:00:31 +0000
Subject: Re: [PATCHv2 1/3] leds: Add of_led_get() and led_put()
Message-Id: <55F01F5F.4060609@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="v9ETHvUwUsOg7oXAluM1IDMpKfME1udSw"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1441711176-4258-1-git-send-email-tomi.valkeinen@ti.com>
 <1441711176-4258-2-git-send-email-tomi.valkeinen@ti.com>
 <55EEE0A1.5070000@samsung.com>
In-Reply-To: <55EEE0A1.5070000@samsung.com>
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

--v9ETHvUwUsOg7oXAluM1IDMpKfME1udSw
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 08/09/15 16:20, Jacek Anaszewski wrote:
> Hi Tomi,
>=20
> Thanks for the update.
>=20
> On 09/08/2015 01:19 PM, Tomi Valkeinen wrote:
>> This patch adds basic support for a kernel driver to get a LED device.=

>> This will be used by the led-backlight driver.
>>
>> Only OF version is implemented for now, and the behavior is similar to=

>> PWM's of_pwm_get() and pwm_put().
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   drivers/leds/Makefile    |  6 +++-
>>   drivers/leds/led-class.c | 13 +++++++-
>>   drivers/leds/led-of.c    | 82
>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/leds/leds.h      |  1 +
>>   include/linux/leds-of.h  | 26 +++++++++++++++
>=20
> According to existing naming convention this should be "of_leds.h".

Right. I was thinking it's "leds" first, and "of" second, but I see
of_*.h is the convention.

>> +#include <linux/leds.h>
>> +#include <linux/of.h>
>> +#include <linux/leds-of.h>
>=20
> Please keep alphabetical order.

Yep.

>> +#include <linux/module.h>
>> +
>> +#include "leds.h"
>> +
>> +/* find OF node for the given led_cdev */
>> +static struct device_node *find_led_of_node(struct led_classdev
>> *led_cdev)
>> +{
>> +    struct device *led_dev =3D led_cdev->dev;
>> +    struct device_node *child;
>> +
>> +    for_each_child_of_node(led_dev->parent->of_node, child) {
>> +        if (of_property_match_string(child, "label", led_cdev->name)
>> =3D=3D 0)
>=20
> Line over 80 characters.

I don't like to split lines to exact 80 chars, when it makes the code
more difficult to read. In this case it's 3 chars over 80, and splitting
the function call above to two lines doesn't look nice to me.

I'll do the func call separately, then it stays under 80 chars.

>> +            return child;
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +static int led_match_led_node(struct device *led_dev, const void *dat=
a)
>> +{
>> +    struct led_classdev *led_cdev =3D dev_get_drvdata(led_dev);
>> +    const struct device_node *target_node =3D data;
>> +    struct device_node *led_node;
>> +
>> +    led_node =3D find_led_of_node(led_cdev);
>> +    if (!led_node)
>> +        return 0;
>> +
>> +    of_node_put(led_node);
>> +
>> +    return led_node =3D=3D target_node ? 1 : 0;
>=20
> return led_node =3D=3D target_node;

Again a matter of taste, but to me, =3D=3D returns a bool, whereas the ma=
tch
function here returns an int.

But I'm fine with plain =3D=3D here.

 Tomi


--v9ETHvUwUsOg7oXAluM1IDMpKfME1udSw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV8B9fAAoJEPo9qoy8lh71A78QAKYfgvXjwMuEUW3ayjZBjeWq
qBLU5sMHDBL4lGBTqcIYCyd+QmLTv+GszcRdykrOVCVmJZjl+RrIsCJOJD47MrA6
VI12fBCcXU9mTOxq/6zNLn5lTBI2fUOPJu4FHYxiGhU0R7yRR4vQPJkjhlcDADdV
5PHUQmpLe+jsYaTN44T0n03a7JSXhWk3EK4uGVyOxKGOGZEZZcqXq7LjtbzNEMdO
CM7OqHIAmSAAAPcZstCNobtQ9FQC3POso9qXf4zuVuG38wEffivBkIDmGD0wCPKy
FTu+Sh+mUu8/1QFNtSSYGIXmMWEmNrVha/ZJbiNOODKnu+blsWhVpi995f+eGlXf
cW4Gqwhp9iS0K0G18F25Cw0A462tYucvOU2rXz13MMYEMETy+NpsdTdXQ577i0x0
Gzuo7bb778KPT0xavQw6lDvMcYZ1WrBKbxKlqcWaNq6dTBOYrzwmCj6wLF/Kfpzw
RkzRB5bVr9tUl83TYcTYcLdNhGatFSbCB/vcuaWUGtg1PzkSJWhtkj3M6rOR+U5p
iSX4wopsuy8slNTNhjaX63fTcwqkLiW8mDP1HNu7FLWVb3PNNg4YKb6WZxjekDPx
2vrfhpK/tnkQTvb+dof6KJ23K7MA6R9YJBbWTfmO/9Z7M++65KrvBvK9DT1ICANy
IcnZzxJnqCQEQLgyTwX3
=4LTt
-----END PGP SIGNATURE-----

--v9ETHvUwUsOg7oXAluM1IDMpKfME1udSw--
