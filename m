From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 27 May 2015 10:15:30 +0000
Subject: Re: [PATCHv6 00/10] Cleanup and add support for SSD1305
Message-Id: <55659942.9060400@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="jShgjoGoeg6iWivn5d1Tdxnhmr1WiMQAX"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de> <1427826436-21783-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1427826436-21783-1-git-send-email-niederp@physik.uni-kl.de>
To: =?UTF-8?B?VGhvbWFzIE5pZWRlcnByw7xt?= <niederp@physik.uni-kl.de>, plagnioj@jcrosoft.com, maxime.ripard@free-electrons.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--jShgjoGoeg6iWivn5d1Tdxnhmr1WiMQAX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 31/03/15 21:27, Thomas Niederpr=C3=BCm wrote:
> Hi,
>=20
> this patch series is the result of making the ssd1307fb driver work wit=
h
> a Newhaven OLED display using the Solomon SSD1305 controller. To achiev=
e
> this the intialization code for the SSD1306 and the SSD1307 is merged
> and based on DT configuration to reflect the various possible wirings
> of the SSD130X controller (04/10). Based on these changes it is straigh=
t
> forward to add support for the SSD1305 controller (06/10).
>=20
> While working on the driver I realized that it was not possible to
> correctly mmap the video memory from userspace since the address handed=

> to the userspace app is a logical one where it should be a physical one=
=2E
> Patch 01/10 fixes this. Furthermore the memory reserved by kzalloc is
> not page aligned while the address handed to userspace is aligned to th=
e
> next page frame. This problem is fixed by using __get_free_pages() in 0=
2/10.
>=20
> Furthermore a module parameter is added to set the delay for the
> deferred io update (07/10). Also the backlight class is implemented to =
make
> the contrast setting available in userspace (09/10).
>=20
> changes since v1 (thanks to Maxime for the feedback):
> - dedicated patch for fixing smem_start address
> - remove page reserve upon vmalloc
> - remove return value check upon display turn-off at module unload
> - use a module parameter refreshrate rather than delaydivider
> - allocate fbdefio dynamically
> - use sysfs_create_groups to create sysfs entries
> - remove contrast, vhcom and dclk properties from DT since they are
>   not part of hw description. The contrast module parameter was added
>   to set contrast at load time. vhcom and dclk stays at it's default
>   values for now.
> - add new DT properties to in tree users of ssd130X
> - rebased to apply on top of linux-next
>=20
> changes since v2 (thanks to Maxime again):
> - free memory allocated by vmalloc on driver unload
> - set default values in the init code to the ones of the existing ssd13=
07
>   init code
> - added two ACKs (Maxime Ripard)
>=20
> changes since v3:
> - use backlight class rather than dedicated sysfs files to set the=20
>   contrast (Thanks to Tomi Valkeinen)
> - remove [PATCHv3 08/10] fbdev: ssd1307fb: Add module parameter bitsper=
pixel
> - add new patch to blank the display (unreviewed)
> - allocate video memory through __get_free_pages() rather than vmalloc
>   (Thanks to Geert Uytterhoeven)
> - minor rewordings of the commit messages
>=20
> changes since v4 (thanks to Maxime):
> - added two ACKs (Maxime Ripard)
> - fixed typo: s/REFRASHRATE/REFRESHRATE
> - updated the documentation to make clear the unit of com-offset
> - move addition of the module parameter contrast to a separate patch (0=
9/11)
> - fix indentation errors
> - get rid of device_id in the device_info struct
>=20
> changes since v5:
> - remove [PATCHv5 09/11] fbdev: ssd1307fb: Add module parameter to set
>   the initial contrast
> - remove unnecessary variable initialization in the deviceinfo struct a=
s
>   pointed out by Maxime
> - make the variable dclk_div hold the actual divider rather than the
>   corresponding bit value
> - remove ret variable in ssd1307fb_blank() (thanks to Olliver Schinagl)=

> - fixed bit mask for com_invdir as indicated by Olliver
> - change initialization of the charge pump as suggested by Olliver
> - change the default value for prechargep2 to 0x2 (thanks to Olliver)
> - change DT property name "com-sequential" to "com-seq"
> - added one ACK (Maxime Ripard)
> - added Tested-by Olliver Schinagl

I have queued this version for 4.2, with all the acks.

 Tomi


--jShgjoGoeg6iWivn5d1Tdxnhmr1WiMQAX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVZZlCAAoJEPo9qoy8lh71wc0P/A1AxsQpNPBrCbQwWBttI884
7prSSqZIs0Hicr5lM6jWdSKS1qbhg73Vf77aWKHWoqYITtwFVc7ub+hw/KSPdkJL
oqAOLO183hkqMGCIfMzWqDFBdyEQ2m/0Hi3zkV6gmHYfjxtzHOgH1+hPkQyw3EPD
71XACzLO/xs2Ain9W8LqySt6+3VJUZZ+IAiduFGuDU80KzObckwkm+BRs6uTOh4y
Qqhb7QMuSIrabS8Tg9J3V9fcf5PyiGeK1UUNEp2mY/+7l8rxo7C/kQmxcOavQ4TO
yW1/4fQroqLnoECLphymLsd9oou1nZc/fNPNzJCpbLL3tI2bNWDE9nAXamq62egr
Qg391Tx04LksTdwp1dywrqC9y79nJLjgCJjoXbn3ndg4hGmNaQCtuI0eXi39fRHa
K34PZnffKdzqODdW0vO7J1jho2PKHjBXwGppb8MnITCNrCIWM7lydzgh3sN9h5lV
78MA4wE+NPtyUy1il3WMnMfynJIyexb9Rbpf8mDpVVHKo/31/E7aKxbYxisySpjG
ozwBpBEnTTT/LtvjuepVF8uRDwAACtT8qkKghqMtflyhZGfz5llcw7sRFFQtG2xT
858QF19A77RiKCE7Ur0r1JsvE3SJPPXyFB2RsYb94BAxi3MNEXriFvQCJ7KQHqT7
RnSm8/ihJ8dwW5a2D6sJ
=5p7t
-----END PGP SIGNATURE-----

--jShgjoGoeg6iWivn5d1Tdxnhmr1WiMQAX--
