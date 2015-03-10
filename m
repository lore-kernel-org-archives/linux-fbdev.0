From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 Mar 2015 10:49:19 +0000
Subject: Re: [PATCH 7/8] fbdev: ssd1307fb: Add sysfs handles to expose contrast and dim setting to userspace.
Message-Id: <54FECC2F.8080804@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="vbC68NMEWDxVXAwhsSrIKioEhRUJ1G2UR"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de> <1423261694-5939-8-git-send-email-niederp@physik.uni-kl.de> <20150207114329.GQ2079@lukather> <20150207174244.25987977@maestro.intranet> <20150209085239.GX2079@lukather>
In-Reply-To: <20150209085239.GX2079@lukather>
To: Maxime Ripard <maxime.ripard@free-electrons.com>, =?windows-1252?Q?Thomas_Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, linux-kernel@vger.kernel.org

--vbC68NMEWDxVXAwhsSrIKioEhRUJ1G2UR
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/02/15 10:52, Maxime Ripard wrote:
> On Sat, Feb 07, 2015 at 05:42:44PM +0100, Thomas Niederpr=FCm wrote:
>>>> +static struct device_attribute device_attrs[] =3D {
>>>> +	__ATTR(contrast, S_IRUGO|S_IWUSR, show_contrast,
>>>> store_contrast),
>>>> +	__ATTR(dim, S_IRUGO|S_IWUSR, show_dim, store_dim),
>>>> +
>>>> +};
>>>> +
>>>
>>> I would have thought this was something accessible through the
>>> framebuffer ioctl.
>>>
>>> Apparently it's not, at least for the contrast, so maybe it should be=

>>> added there, instead of doing it for a single driver?
>>
>> I think the contrast setting for an OLED display is much like the
>> backlight setting for LCD panel. Since there is also no ioctl to set
>> the backlight of an LCD I wonder if the contrast of an OLED should hav=
e
>> one.
>=20
> It's too much of framebuffer interface debate for me here. Tomi?

We have backlight and contrast already in backlight-class and lcd-class
(drivers/video/backlight/backlight.c and drivers/video/backlight/lcd.c).
Are those something that could be used here instead of custom sysfs files=
?

 Tomi



--vbC68NMEWDxVXAwhsSrIKioEhRUJ1G2UR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/swvAAoJEPo9qoy8lh71R50P/04IVpBL0R0XP7N/AXoDf0vU
D7nBdTkTx3mRi6l03tdN38wpLbft8SUwUvqWHX3UPY/0/nKMyAt7qGQWwtL6Qra6
ZH5DDLPD4bxeB35x97GivuKbGzF87VgiUcovlpNBBurtLc0gd/AEVv2Y2Zpe/Bwk
dKh28YMVmfzD8BPiMMbuVkV60DZcd4wQ1NKbICmUI5ZWkvxr09BMsZDl+ZBaWjw5
Y/eucwdiDcB5E+QMsYaOZRtMyOXdx+wAcIPnOwC1cE88ekrImoHLJ81OwREPP6Qo
VWQgyZOr2bP2zrKIJ3zrIU6MGjAAZqLAlhUdBI5VRChuYPUtL+9QeLP3DGxBhV4g
2ynPdGQIDt8tA+ibwoiQ5Fur4vblytscfja6Y3YEgrTZwo0fBcdgzMdtVgIerI3Z
HUmGklndopETqqzNNA3PT+ky4ZxO3xBTZYr1up3L0LEOF/a7WkkrlYctf9wkUf4y
G8MsORZ6x1LYwHBzyLxgmAftYG6FpmVtRWgtESG9vRQuaIapVPZOsXYhtBW4EK2Y
g8LggEXgw7G5mkEbpQzyxnJa62/jB2HGB/FN+XcuLTiAFuQ0/SHoG2AFeZ1liLN4
YtMw4UcJM2b+9V7UlKC/gfIgM8lrjisRE6feRhhMapR235lMQ4kzy61yPG5cEH/C
fSqhlnYM4ePSWc6GQ2H9
=wAG6
-----END PGP SIGNATURE-----

--vbC68NMEWDxVXAwhsSrIKioEhRUJ1G2UR--
