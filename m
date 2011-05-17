From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Date: Tue, 17 May 2011 16:25:42 +0000
Subject: Re: i80 (Intel 8080-like) command interface to LCDs - how to implement
Message-Id: <201105171825.43506.heiko@sntech.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201105171359.43658.heiko@sntech.de>
In-Reply-To: <201105171359.43658.heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

Am Dienstag 17 Mai 2011, 13:59:40 schrieb Heiko St=FCbner:
> I'm trying to find the best way on implementing an i80 interface
> (especially the command mode) between a s3c2416 and an AUO-K1900 (epaper
> controller).
>=20
> On the host side it is usable at least in all Samsung SoCs following the
> S3C2443 and on the device side I've found, apart from the K1900, for
> example the ili9320 and STM32F10xxx displays controllers using this
> interface.
>=20
> It looks a bit like a cross between SPI and I2C but fits neither category=
 -
> at least for my understanding.
after some more thoughts while cycling home, would it be sane to implement =
it=20
as spi devices like:

lcd-ctrl <->i80_device (spi_device) <->spi-layer <-> i80_spi_master

i80_device would implement the message logic as described below
i80_spi_master would control the registers=20

the write-enable/read-enable bit settings can be determined by the directio=
n=20
of the transfer, but how do I determine the value to set for RS?

The idea I had was to set bits_per_word to n+1, i.e. the register has 18 da=
ta=20
bits and I would use the 19th bit do transmit the required RS setting.

Does this look at least halfway plausible?

Thanks
Heiko

[rest of this mail included as I have just added spi-devel to the recipient=
s]
> pins/pins consist of:
> CS ... chip-select
> RS ... control or data register select
> WE ... write enable
> RE ... read enable
> D0-Dn ... data 0-n for variing values of n
> (I've seen up to 18 data bits)
>=20
>=20
> commands can look like:
> (* set command mode)
> * set chip-select
>=20
> * set RS to control (mostly low)
> * set WE to high
> * write command to D
> * unset WE
> * set RS to data
>=20
> * set WE
> * write data to D
> * unset WE
> * set WE
> * write data to D
> * unset WE
> ...
> * set RE
> * read data from D
> * unset RE
> ...
> * unset chip-select
> (* unset command mode)
>=20
> the fourth possible state (read-control) is also used by the ili9320.
>=20
> looks a lot like an i2c-transfer, i.e. something like
> {
>   { WC, 6001 }, //for write-control
>   { WD, 576 }, //for write-data
>   { WD, 12 }, //for write-data
>   { RD, *buf } //for read-data
> }
> could represent the above command-sequence.
>=20
>=20
> So, is this a new bus type or does it fit somehow into spi or i2c or some
> other bus-type I don't know yet? Or, does code for i80 exist somewhere I
> haven't looked yet?
