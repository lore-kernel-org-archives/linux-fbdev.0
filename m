From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 02 Aug 2013 06:40:04 +0000
Subject: Re: [PATCH v2 18/24] video: da8xx-fb: minimal dt support
Message-Id: <51FB5444.3080404@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="do5cVbKWao2VfPTf6bR5bFVntj6b1HD3G"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375208791-15781-19-git-send-email-detheridge@ti.com>
In-Reply-To: <1375208791-15781-19-git-send-email-detheridge@ti.com>
To: linux-fbdev@vger.kernel.org

--do5cVbKWao2VfPTf6bR5bFVntj6b1HD3G
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/08/13 23:21, Darren Etheridge wrote:
> Darren Etheridge <detheridge@ti.com> wrote on Thu [2013-Aug-01 08:36:02=
 -0500]:
>> Tomi Valkeinen <tomi.valkeinen@ti.com> wrote on Wed [2013-Jul-31 13:19=
:01 +0300]:
>>>> +Required properties:
>>>> +- compatible:
>>>> +	DA830 - "ti,da830-lcdc"
>>>> +	AM335x SoC's - "ti,am3352-lcdc", "ti,da830-lcdc"
>>>
>>> I'm not totally sure about this, but how I understand the compatible
>>> property, the above reads as: "this device is ti,am3352-lcdc and it's=

>>> fully compatible with ti,da830-lcdc". I.e. if the kernel has a driver=

>>> for da830-lcdc, it should work with AM335x also (without any of the n=
ew
>>> features in AM335x, obviously). Which I believe is not the case, as t=
he
>>> point of this series is to add the AM335x support.
>>>
>>> Or should the current da830-lcdc work with AM335x also, but it just
>>> didn't because there were bugs in da830-lcdc?
>>>
>>>  Tomi
>>>
>>>
>> OK I agree there is something wrong here, for one I don't think settin=
g
>> ti,am3352-lcdc would do anything anyway given the driver only reports
>> .compatible with ti,da830-lcdc so at the very least the document is
>> wrong.  I will look into this and decide what is the best way of
>> resolving this.  I will go ahead and submit the series without the DT
>> support anyway and then I will look into this.
>>
> Reading the device tree documentation I think what is here in the
> patch is actually correct so ignore my first response.
>=20
> In answer to your original question in theory the da830 driver would
> be fully compatible with the am335x - am335x implements a version 2 of
> the lcd controller that adds some extra reg bits that support larger
> horizontal and vertical resolutions and a sync loss interrupt. =20
> However the driver takes care of those differences internally.  I
> think the main thing that was needed from this patch set to support
> am335x were the dt changes, the Kconfig changes and the clock changes
> - the rest of it are enhancements and bug fixes that are not strictly
> needed for am335x support.=20

Ok. And the clock changes are also valid in da8xx context also? The need
for them just didn't realize with our current use of da8xx?

> Perhaps the correct thing to do and maybe what you are getting at is
> really am3352 is the superset driver which we have now added complete
> support for with these patches. However because we handle the
> differences between the two IP's directly in the driver we should have
> the driver provide both ti,am3352-lcdc and ti,da830-lcdc as
> .compatible entries because really the driver supports both version 1 a=
nd
> version 2 IP's.

Hmm, right, I believe the driver should provide "ti,am3352-lcdc" also,
because it does support the extra features offered in am3352.

A bit side tracking, but: I've been wondering about the device names we
use. Naming the lcdc driver by the SoC is not quite correct. I don't
know all the IPs TI has, but what I see is that TI has two types of
display controllers: the more basic LCDC, and the bigger DSS.

Could we just call the device lcdc or dss? So, for example, DA830 has
"ti,lcdc1", AM3352 has "ti,lcdc2", OMAP2 has "ti,dss2", OMAP4 has
"ti,dss4", etc.

Then again, I'm not sure if the HW development of LCDC or DSS goes quite
that linearly. There are multiple SoCs that have OMAP3's DSS, but are
they the same DSS, or does each of them have a slightly different
version, without there clearly being a DSS version 3.1, 3.2, 3.3, etc...

 Tomi



--do5cVbKWao2VfPTf6bR5bFVntj6b1HD3G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR+1REAAoJEPo9qoy8lh71xxgP/R0h8n/v+iKXLYZQvlQqfe/Z
S4WkkctC22wWVhnXlCvafFF5qXgmLhGkEBCYbw2VXqqeU+9WcwEYoO53MLgQSpcU
cCCe3M3eOm1HCUNfZzWSRum9+8aztXIGu9japdBNOh0fhAbW1qLmZvQ+NL3XbzFa
rO9XauO2j7haafm3lqJtLYi5O07xNXrUCtOVwRyXmcZLa3QVNLsPCQoYstu/ezaI
n0++U0/MxTgzrnwKphO83I+xdZWRDUiYRc32KsKY0vvUafG2iY/RhsdjsUzzxBn1
mrXEzKH580GwJQ5va2325UtR1rFTDivoE8fllW/uh9yTnBXh6zSQ3JZNQUGHoIK1
WntpSg9jBnNosWDTSq1lTZ3+iJAcS2kBYmzlau0waFH2j2vNqBDD8vgZePxTXCLZ
teBPWAywWQYfuL3sZwenRFPcnE+o5X9bMjzK+a9Ne2RKSJe5opFY6hgFE5YEwEv8
XlTFHN6y5hXP68nAcU9p4juAswEhzXhoqXf1JMVXtvnCKz4Md+tUDvWhGRg1tHM1
oOmSFNtzvb3xJolxEFLdkGcmuZ+MIPEpGAjC8Vl+KhWU0vznhb5PvkD+ZCDHPw92
/SDfazDKFUjMDtprVLJ8GjynFsrnV5jloZv5SMBzfcfhySeRoKyc+spWneyCntPV
GdLI+BfPARGm1I7AITWs
=NUvp
-----END PGP SIGNATURE-----

--do5cVbKWao2VfPTf6bR5bFVntj6b1HD3G--
