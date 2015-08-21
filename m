From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 21 Aug 2015 06:53:02 +0000
Subject: Re: [PATCH v1, TRIVIAL] Fix pxafb nonstd field documentation and add errata info
Message-Id: <55D6CACE.1080801@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="N7Xsb9R306aWeAC9mN1cgLQptcDQVxHob"
List-Id: <linux-fbdev.vger.kernel.org>
References: <55C64864.6070405@tul.cz> <55D5B232.9090006@ti.com>
 <55D63391.3080403@tul.cz>
In-Reply-To: <55D63391.3080403@tul.cz>
To: linux-arm-kernel@lists.infradead.org

--N7Xsb9R306aWeAC9mN1cgLQptcDQVxHob
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 20/08/15 23:07, Petr Cvek wrote:
> Dne 20.8.2015 v 12:55 Tomi Valkeinen napsal(a):
>>
>>
>> On 08/08/15 21:20, Petr Cvek wrote:
>>
>>> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfi=
g
>>> index 2d98de5..8f485ec 100644
>>> --- a/drivers/video/fbdev/Kconfig
>>> +++ b/drivers/video/fbdev/Kconfig
>>> @@ -1893,6 +1893,11 @@ config FB_PXA_OVERLAY
>>>  	bool "Support PXA27x/PXA3xx Overlay(s) as framebuffer"
>>>  	default n
>>>  	depends on FB_PXA && (PXA27x || PXA3xx)
>>> +	---help---
>>> +	  Using the overlay 2 and YUV420 mode on a PXA27x C0 chip revision =
will
>>> +	  hang the LCD until the next SoC restart (errata E24).
>>
>> Shouldn't the driver handle this? It should not allow the combination =
to
>> be used.
>>
>>  Tomi
>>
>=20
> Probably, but I don't know which revisions are OK and which are not. Er=
rata document:
>=20
> 	Marvell=AE PXA270M Processor Specification Update
> 	MV-S900957-00
>=20
> has only 3 revisions, but PXA Manual lists 6 (2.2.5.1 Processor ID Regi=
ster) and one revision from errata is not shown in my PXA Manual. I can e=
xclude mine revision (from "system_rev" variable), but there should be so=
me warning somewhere in configuration.

No, configuration or kernel docs is not the right place for this. The
user is not going to see that. And a single kernel image is supposed to
run on different soc/board versions, so you can't do selections like
this in the kernel config.

The driver should detect the bad revision, and then apply the
workaround, or if that's not possible, refuse the use of the
configuration that leads to the HW bug. Or if even that's not possible,
the driver should print a warning when starting, so that the user is
able to see it.

 Tomi


--N7Xsb9R306aWeAC9mN1cgLQptcDQVxHob
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV1srPAAoJEPo9qoy8lh71SjUQAJZ33eMs3xqfXjAkhil5tZQ9
SgmxvZbuCTrWNBdzstPqPYI/7TsP0aK5laOwMNH8/RWsFTsICApC+eWRSynS7Mk1
bJuWZ1q6M65lGHhcYERCkA7zEJl7FfO3h6AsCSdRsrx0QuWqU0BR6gtUl7PFy9q0
dNbScSPge48/1snFMyx6ZtBGs/79iWTR67MNSGHJL+u8PRbeBdwglxOglkStGbqw
aRxqht1WKID+y4N9mISDtg1Euql3B8YkQRV7ImjXguss+znfEuWMsB16wQXCrc57
YboiNk6wT0CwID7425AL1IB5/zOzEgShw2reuh3erwh719U2TJ4SpxnNJFf0uYEY
/3mV/6HpRnsCVHQQyFDRSyJ2Wc6ptl1D0zOi2FIePUE1m0yh2Rdvkd6bpqtaCRyy
7ydtNOHEpoULMC6Gnhem2Q1z0VD4SvJYVu06Kmb2cuKRYiBIsMrzBWbp/9sx+RRD
DXX6+Yb7Cd392jZEesdyqiIJle8cDaBImNhF3Szuizu6OHpiua7ML4Vmco0fvoXZ
R3vE5wI5RkOuc3J9weq9t4AriGGxWJhwCWAYizMHs4Nl/eS9at9q5nGoPcfJgzcy
u9+AKw59JMjxAR++S0pZ6cPFDCLT0Kc//wRfds2FMaIIzESbactsR09viS7Ggdqw
GjWH0w04wZsl5a+mh3IL
=ht9v
-----END PGP SIGNATURE-----

--N7Xsb9R306aWeAC9mN1cgLQptcDQVxHob--
