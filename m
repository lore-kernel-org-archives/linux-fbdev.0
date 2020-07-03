From: =?UTF-8?B?RnLDqWTDqXJpYyBQaWVycmV0?=  <frederic.pierret@qubes-os.org>
Date: Fri, 03 Jul 2020 14:24:31 +0000
Subject: dummy-backlight
Message-Id: <903f7645-5062-00a9-8d7c-b30ef5f54951@qubes-os.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="4fGmdG7NnKFN1M86H79xV4JfD01yLcbyk"
List-Id: <linux-fbdev.vger.kernel.org>
To: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, dri-devel <dri-devel@lists.freedesktop.org>, linux-fbdev@vger.kernel.org
Cc: =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= <marmarek@invisiblethingslab.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4fGmdG7NnKFN1M86H79xV4JfD01yLcbyk
Content-Type: multipart/mixed; boundary="Q7nSMCZKXlHpZb2Yy992XltX3EiXUZfr7"

--Q7nSMCZKXlHpZb2Yy992XltX3EiXUZfr7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dear all,

I'm working on a simple kernel module currently called "dummy-backlight" =
(https://github.com/fepitre/dummy-backlight) which creates a testing back=
light. After loaded, this driver allows to modify integer values of the v=
irtual backlight created through its sysfs attributes directly.

In the context of the Qubes OS project, it allows to setup into a VM, a v=
irtual backlight and managing the hardware backlight into the VM directly=
 thanks to a communication channel with the host system.

I'm writing to you to know if you would be interested to have such module=
 into kernel. Another name could be "virtual-backlight".

I've written a similar module for PSU too (https://lore.kernel.org/linux-=
pm/a8223cce-636f-578b-7304-eb0e4868e018@qubes-os.org/) where a nice sugge=
stion of improvement has been made to use a misc device for controlling a=
ttributes instead of sysfs directly. Indeed, it's appropriated in case of=
 multiple PSU but maybe for a (only one?) "dummy-backligh", using two sys=
fs attributes is enough.

Any kind of improvements are very welcomed. Thank you.

Best regards,
Fr=C3=A9d=C3=A9ric Pierret


--Q7nSMCZKXlHpZb2Yy992XltX3EiXUZfr7--

--4fGmdG7NnKFN1M86H79xV4JfD01yLcbyk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn6ZLkvlecGvyjiymSEAQtc3FduIFAl7/P58ACgkQSEAQtc3F
duIIehAAop77snM7y/Bd9ln0IS+FiUw6eZcj5mp+0oKi1xjKbiCui/6WfVFwYzki
Q500M5gH/6r3jXf1wBOiZIkRVgj9TKkKiOlPJDCqTSBMKEYV3n7P4yrq0Lr+dTlf
qvXBOnzQlG2GuTDvGz3UOOmHLaa/NV4P7wQusNVkj2dCBBMoC4QJsuwnA2jVZHdI
4Va19Yijrfpx+8pWgb5/yTHuo/yjxCiobTRsFQI+qas15KbJ0r+wHHESD4qZ+T8M
FIrDLUIcUAV3orMjLkx1b6KxG/1aMtXwYH+bIpswFbhJ9iw/jhuemEtiJnM+Zbf2
1iviZSzlICZB3hsEmzqcFPGdAXZj+O6cdm30wl7kMQeZiPzkGg9WMaQ/c7/AUcPb
hwBI7KteyvkGahM7nkooIaJnu29+Yc9KS8r5RhedPA1fJycxSsZniPudRLwh186G
9TqTqTDyYkTbnhsjQQTOosUqlwYG1sgk9Xs64glgiAl6WAbWTYOrj4W2bNyw/jDx
RYbGBV0PwpCASCOyZhMk++oPeloQytLN17y1AQO+tM+t/UjK1FHWlSZ1fD3BlZVg
m6qItivxR+I6kvrOM4AhTZrR5h6nS0R0WHaVyvoxSnrcdO/t0K4m2T+MZxD8If8P
4g31Uk6bcm3kOQ29ifCnnkJXPwoJWPrksG88/sKxe7nmdPyQdag=
=NWRT
-----END PGP SIGNATURE-----

--4fGmdG7NnKFN1M86H79xV4JfD01yLcbyk--
