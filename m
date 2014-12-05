From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 05 Dec 2014 12:22:56 +0000
Subject: Re: [PATCH 3/3] video: fbdev: Validate mode timing against monspec
Message-Id: <5481A3A0.4000503@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="26DoRoQWskOjkEspv3rxgKTotwFQQQix8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417643369-20603-3-git-send-email-davidu@nvidia.com>
In-Reply-To: <1417643369-20603-3-git-send-email-davidu@nvidia.com>
To: linux-fbdev@vger.kernel.org

--26DoRoQWskOjkEspv3rxgKTotwFQQQix8
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03/12/14 23:49, David Ung wrote:
> fbmon may generate mode timings that are out of spec of the monitor.
> eg DELL U2410 has a max clock 170mhz but advertises a resolutions of
> 1920x1200@60 in its Standard Timings, fbmon creates a mode using the
> GTF timing calculation which gave it a 193mhz clock.

The above is not exactly true with the previous patches, as fbmon
doesn't calculate it with GTF, but looks it up from the DMT table.

I have to say it's quite odd that the monitor advertises a mode it
cannot display...

> This patch checks to see if the mode can be supported by the monitor
> by comparing against monspecs.dclkmax.

I don't know about this patch... It looks a bit messy, and only handles
a too high clock in the get_std_timing. We could as well get bad timing
from get_est_timing() or somewhere else.

And I don't know if get_std_timing() should even do such filtering in
the first place. I'd say it's supposed to return the mode from the EDID
block. Whether the monitor or the device actually supports the mode is a
separate thing.

Also, generally speaking, while I have no objection in fixing bugs in
fbdev, I'd wish everyone just moved to DRM if at all possible. So if
this starts turning into a bigger change, with possibilities for
regressions, we have to consider if the fix is important enough.

 Tomi



--26DoRoQWskOjkEspv3rxgKTotwFQQQix8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgaOgAAoJEPo9qoy8lh71otcP/RH2ofU402Fccamp2BCMMITj
1MQVTfYBLOn06ACxKbJUeTu6EcsbmxcLA8w+NHZcKJNHaE7YLEofw3g6fpwiMrS/
P8bWCqPPRV/XdnxJHmQrSuZOXiNcErp9kCbmPpa+ZikfOAbQLH6I5pQTBda43Y5K
MaOJvDGtrzWJZkpChpllM8eO+yeCVEM5+Od/kbYRjLILAuX1SygtA4uPxinM4bZk
7ocCcIMxj7Gb/b/Ck3SUnH2zvaWYmJZvZntMCFM8DKXuHAb1IN2Ugy/6P4RrCwHS
c7g4o/lD+cUg8sxUaUvNs47yEi6IQF+2QmTOKbRWFn0h7pYJDCThMCWcpRy/D/P4
UDiS0fctYiKkXubW1vN1NCVfR+KIGlPtleLcD2dhcwIibK4wkgSXdpfGZnFLQlD8
gAZnTZs/EXhRXRUG27LhHY64QSKoSrFIb5UWjECBiYtOXo+2IlQTM9HfkKhbwxQd
m22BHJXrg6k1wbCAI5/4i6aKmTOU10TKrAHwiTJNSNLYNaxG3pdqajCQKI9pja8p
H540sB5+/neCOZk+0FqJzq4kaWBknG+PHY1yybSAjpOPMslNSSIk7M3uGIiE73P8
9Whowlh72bST04sPUhJJYQJKM+f0I+V4l2BtkI+iDCvnHuEOcDX06/i7sBIUtleL
fSAzAwb9mX4Kh0yNlppA
=b/2k
-----END PGP SIGNATURE-----

--26DoRoQWskOjkEspv3rxgKTotwFQQQix8--
