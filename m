From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 08 Sep 2015 10:41:03 +0000
Subject: Re: [PATCH 1/3] leds: Add of_led_get() and led_put()
Message-Id: <55EEBB3F.4040908@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="C76lKnh16PpcavPbTQndubDwAu3qn4NbV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com>
 <1440502442-19531-2-git-send-email-tomi.valkeinen@ti.com>
 <55DC6CB9.5060301@samsung.com> <55ED848F.2060906@ti.com>
 <55ED9B01.5030003@samsung.com> <55EE89CF.8060308@ti.com>
 <55EEA8B2.3040808@samsung.com>
In-Reply-To: <55EEA8B2.3040808@samsung.com>
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

--C76lKnh16PpcavPbTQndubDwAu3qn4NbV
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 08/09/15 12:21, Jacek Anaszewski wrote:

>> The "static struct class *leds_class" from led-class.c, in one way or
>> another. of_led_get() needs to go through the led devices from the cla=
ss.
>>
>> For now I just removed the "static" from it, so that I can use it from=

>> of.c.
>=20
> I think we can go in this direction. I've skimmed through existing
> class drivers and found similar examples (e.g. tty_class, rtc_class).

Yep.

>> Sorry, I didn't get that one. How does the backlight driver's
>> depend/select affect this?
>=20
> OK, I confused something here. Backlight driver should depend on
> LEDS_CLASS by defining "depends on LEDS_CLASS" in backlight Kconfig.
> It should also depend on OF. In case of this driver the no-ops would be=

> only for the purpose of making the kernel image smaller, as the driver
> probe will fail without them anyway. Nevertheless, there might be added=

> other drivers in the future, using of_led_get{put} API which would like=

> to make some decisions basing on whether LEDS_CLASS or/and OF are
> turned on. No-ops would be of use then.

I agree.

>> What do you mean with "waste"?
>=20
> I used 'waste' because we would be wasting time here for the call which=

> can be avoided at no cost. Of course if compiler will decide to inline
> it.
>=20
>> In this case there's no need to get more performance by inlining
>=20
> Why so?

Reserving and freeing resources are rarely hot paths. The functions in
question are usually called in a driver's probe and remove. Saving a few
CPU cycles there doesn't really matter, so I think readability is the
important part here.

>> and inlining forces the users of led_put to include module.h to compil=
e.
>=20
> We could include module.h from leds.h.

Yes we can. And I can do that in my patch. I don't agree with the
solution but neither do I really have a problem with it =3D).

 Tomi


--C76lKnh16PpcavPbTQndubDwAu3qn4NbV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV7rs/AAoJEPo9qoy8lh71c4gQAIBxFC5lz3bajRT3fVvk3N4C
Lc1bv0g6ODpIpNVuI/obanP3pow3wm5LJwrzn0h7w3KTeXvyM8o0aMPM8oCxs307
7jyq96W41ikLQzIqSX+C1kZOBsMjj85Gj7P/kvqicCPaZKKYllI/fBKp1qzBI7H8
kdH8QFIVQ4WD0Iod3tuygxTYY56hoYo5gfcO0anyShdeGdC1gDAuC/vdNdPftazs
t55HsZ2OjZO5Z9aVg9XHyEZbuWjGW7ybwcXknfcMc3olJkgpcTX4yR9pXYO3u6xu
l+7xyHoozr4qDWkruOD58CoiOY4tilErgKzhLtceDb4CD8/Fwh4IjVRBPahqAzps
I8H/CO5WoAVipEwYwjNQe3Kmm22aI+OJTJlxHECi7feJxnvKTxIDcemwQONS23+1
1zGU6DDwGCQkn7zFqE2ZrDg4k54PbcsVp4jzzrhG3EljV3757yD8YRfAgU+qHf1s
lJ6AGixk4ysjyzb0FlZgaYANSrOenf3WavSVJx7Xvsz6act+83aPexPaot6woDV9
H87FKaE/Pvabx49p6iLZ7H/WfuIa0zFHeMz2FEQGXJy3o7bbTQhhjJbmppnyFWMY
O+TRuHNutp5l3MdBMrtJVTXb2c0CP06NdY8swfkJJglZjE1miKXNgLPEyO6bdI4z
biMFq3OfCFfw07VHN/vt
=e7Zx
-----END PGP SIGNATURE-----

--C76lKnh16PpcavPbTQndubDwAu3qn4NbV--
