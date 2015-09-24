From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Sep 2015 12:27:01 +0000
Subject: No more new fbdev drivers, please
Message-Id: <5603EC15.9090605@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EhSr3wpUGubA9ipFD5RNT7K3rq4LxipCK"
List-Id: <linux-fbdev.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Arnaud Patard <apatard@mandriva.com>, Dave Airlie <airlied@redhat.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

--EhSr3wpUGubA9ipFD5RNT7K3rq4LxipCK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

fbdev is (more or less) maintained, but it's a deprecated framework. All
new Linux display drivers should be done on DRM.

So let's not add any more new fbdev drivers.

I will continue to maintain the current fbdev drivers, and I don't mind
adding some new features to those current drivers, as long as the amount
of code required to add the features stays sensible.

I see we have three fbdev drivers in staging: xgifb, fbtft and sm750fb,
and the question is what to do with those.

xgifb was added in 2010, and is still in staging.

fbtft looks like maybe some kind of framework on top of fbdev, with
fbtft specific subdrivers... I didn't look at it in detail, but my gut
says "never".

SM750 hardware seems to support multiple outputs, hardware overlays, 2D
accelerator... I think it's pointless to write an fbdev driver for such
a HW, as it's not possible to use those features with fbdev (without
custom API).

So, without spending too much time looking at those drivers, and without
speaking to the authors, my initial suggestion is to remove them.

 Tomi


--EhSr3wpUGubA9ipFD5RNT7K3rq4LxipCK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWA+wVAAoJEPo9qoy8lh71CWkQAISiDT1paqqW9dcKO7Vzj4rR
iFGxO0gv7oP1L7kP7vjZzNa6b5V+TXNBOZAmO1XAykJszo6Tr5Pez9duL+CeLEqB
mcQARBtX00bV46Bnlsk7DcySf2L5LhgjVMxKM5TBqwiEH7dDxV9DVFkdZAImslfB
neWesyZclEDtqxYELZEdRtFWeJcNvXj08YPrWv/2NPd9nR0w+O/dXxZ9qI/UnMjY
CpzpUI/h/bzOPBdjT/96Gf+MQoKCgbPBcaaFYj4X+Fnc5WZ2498EnKp3sgiFC35o
JOdicCXrTsyQFYzkbiTXEO3J79tknhT7xPqzNZZjWC+RMX1vE6tRTGYspZAzxVtd
Kp1Da6wVTXRdzCHtiokqz/o4COnNsmFMMfw59RKIZYrcW1ywVvmahRWdVL2T4IYQ
pRAWjvTRa0jQJ8/kLTZkOjwyq/Q+4XT2u3wM+NDHYpIY+y+mMlCSWh2Q2eJ7Lxci
Vone4S4BOtmeFbHYqrmNOWXzty6WyTN8GH9JCMOIWjWICAE3RCculmpkZhE6wc80
qqyBYArrJH+Cw5XbdhoMSs9bYPEXAc7P8Hwtii0pNHe5rAOWUdWjgod4l7Ox+Qsd
zp1sbUF3xg5LVinH3Xo+8b9PmljpP+EY9fckgy6WLLKADY+TMEK7yjSmqF18bkH9
zgyTlggewdOxhvfqcTbV
=kOXm
-----END PGP SIGNATURE-----

--EhSr3wpUGubA9ipFD5RNT7K3rq4LxipCK--
