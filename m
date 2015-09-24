From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Sep 2015 11:04:46 +0000
Subject: Re: [PATCH 3/4] [resend #2] fb_ddc: Allow I2C adapters without SCL read capability
Message-Id: <5603D8CE.4070605@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="L57LD91dOqabooCjRJPLqO6bvx9jub87v"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440445048-24694-1-git-send-email-linux@rainbow-software.org>
 <1440445048-24694-3-git-send-email-linux@rainbow-software.org>
 <55E6DE7D.9060700@ti.com> <201509021404.51232.linux@rainbow-software.org>
In-Reply-To: <201509021404.51232.linux@rainbow-software.org>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

--L57LD91dOqabooCjRJPLqO6bvx9jub87v
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 02/09/15 15:04, Ondrej Zary wrote:
> On Wednesday 02 September 2015, Tomi Valkeinen wrote:
>> On 24/08/15 22:37, Ondrej Zary wrote:
>>> i2c-algo-bit allows I2C adapters without SCL read capability to work =
but
>>> fb_ddc_read fails to work on them.
>>>
>>> Fix fb_ddc_read to work with I2C adapters not capable of reading SCL.=

>>>
>>> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
>>> Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
>>> ---
>>>  drivers/video/fbdev/core/fb_ddc.c |    8 +++++---
>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/video/fbdev/core/fb_ddc.c
>>> b/drivers/video/fbdev/core/fb_ddc.c index 94322cc..22c694a 100644
>>> --- a/drivers/video/fbdev/core/fb_ddc.c
>>> +++ b/drivers/video/fbdev/core/fb_ddc.c
>>> @@ -69,10 +69,11 @@ unsigned char *fb_ddc_read(struct i2c_adapter
>>> *adapter) algo_data->setscl(algo_data->data, 1);
>>>  		for (j =3D 0; j < 5; j++) {
>>>  			msleep(10);
>>> -			if (algo_data->getscl(algo_data->data))
>>> +			if (algo_data->getscl &&
>>> +			    algo_data->getscl(algo_data->data))
>>>  				break;
>>>  		}
>>> -		if (j =3D=3D 5)
>>> +		if (algo_data->getscl && j =3D=3D 5)
>>>  			continue;
>>>
>>>  		algo_data->setsda(algo_data->data, 0);
>>> @@ -91,7 +92,8 @@ unsigned char *fb_ddc_read(struct i2c_adapter *adap=
ter)
>>>  		algo_data->setscl(algo_data->data, 1);
>>>  		for (j =3D 0; j < 10; j++) {
>>>  			msleep(10);
>>> -			if (algo_data->getscl(algo_data->data))
>>> +			if (algo_data->getscl &&
>>> +			    algo_data->getscl(algo_data->data))
>>>  				break;
>>>  		}
>>
>> Aren't both of those loops pointless if there's no getscl?
>=20
> They're reduced to delays - don't know how much critical they are.

I think the code gets somewhat confusing the way you did it.

Maybe instead something like:

if (algo_data->getscl) {
	the current loop & delays here;
} else {
	msleep(25); // 25 was just a guess...
}

 Tomi


--L57LD91dOqabooCjRJPLqO6bvx9jub87v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWA9jOAAoJEPo9qoy8lh719q8P/RYURABH1cysuT+GH+0XFVe4
Ep3DIlZCriVjHkqp6B+Y8kF39H4sKErkaCtrJj2Rcl3eML6dGkcg3aRqv5Qfnxfg
uugZ9oGD3uEroiOR7kOTVgpVrpd2KGdweoTuz6PHin2zZxrMEv4xAbRL0yrvbuZ3
FU64purfJKRaZoUE40nHXbVCqnc1LH7EQ8pRT+Nqj/Yc4s4i+mpbwFdy6ju3WTtH
oD8jbQlwlC7o1Vu8o+QDllZE775kCJvwIomCmB8bP5/ur7apUc9dgeVncfNB7HJ9
MT4eQbknKVRkB558EICxUqbWt7IHPDaH1vsCf24A0Uvyv4pq0PQkbgl95ftVvmuL
7ThhMYBSc3Zi0B2ikkFL5W05UNdMMeb9KmgAxyB9b+IbxkoXs/6J9smzeT27PBYJ
oBWrMKRXmuVIFyYZCCc8Q3Mcp/E6tAzeqwkigu8xbU3SQfWfp7HaE8/L0UC5MYAB
pwHok6mgHB4jGH7ektTEoermxWQ9GVy271jZuOxkM//lB7Poe1AplDwg2zlufOlZ
z24Lb1y+7grG45eHSOO8eAesWSFqZFIAvEGKWzGwQqK6bhfh9LY1PxeYm/UumQ6I
vjhPuLHMIcdJNuOdz40g+PGkCXf4cdJTQklD2y8XT5dSAi4deH2rWqkG2sa8zG87
m9oITRnsKAiqkeRS9IHx
=YDS2
-----END PGP SIGNATURE-----

--L57LD91dOqabooCjRJPLqO6bvx9jub87v--
