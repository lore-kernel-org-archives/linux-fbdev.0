From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 30 Aug 2013 11:52:52 +0000
Subject: Re: [PATCH 0/4] video: da8xx-fb: numerous bugfixes
Message-Id: <52208794.8040708@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="d39JXns3Ml8V34b1kbFrv3vWiADdjgvWf"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1377294773-25678-1-git-send-email-detheridge@ti.com>
In-Reply-To: <1377294773-25678-1-git-send-email-detheridge@ti.com>
To: linux-fbdev@vger.kernel.org

--d39JXns3Ml8V34b1kbFrv3vWiADdjgvWf
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 24/08/13 00:52, Darren Etheridge wrote:
> In developing a driver for an HDMI encoder to be attached to the LCD co=
ntroller
> on TI AM335x SoC I ran across a number of bugs in the da8xx-fb.c fbdev =
driver.
> Two of them appear to have been in the driver for a while (02 and 04), =
one of
> them is a deficiency where some LCD controller version 2 features have =
not been
> utilized (03) and the last one was introduced in the last patch series =
that I
> submitted for this driver (01).
>=20
> These patches do not change the behavior of the AM335x EVM's platforms =
LCD
> panel even though the current values set by the driver are wrong.  I gu=
ess LCD
> panels (at least the one used on AM335x EVM) must be fairly immune to b=
ad
> timings coming from the LCD controller.  However the HDMI encoder simpl=
y will
> not work without these fixes, and quite possibly other LCD panels could=
 behave
> the same way.
>=20
> These patches apply on top of the patch series called:
> "video/da8xx-fb fbdev driver enhance to support TI am335x SoC"
> that was submitted by me.
>=20
> Darren Etheridge (4):
>   video: da8xx-fb fixing incorrect porch mappings
>   video: da8xx-fb: fixing timing off by one errors
>   video: da8xx-fb: support lcdc v2 timing register expansion
>   video: da8xx-fb: fix the polarities of the hsync/vsync pulse
>=20
>  drivers/video/da8xx-fb.c |   35 +++++++++++++++++++++++++----------
>  1 files changed, 25 insertions(+), 10 deletions(-)
>=20

These look good to me, queuing for 3.12.

There was a space missing between 'if' and '(' in one of the patches, I
fixed that.

 Tomi



--d39JXns3Ml8V34b1kbFrv3vWiADdjgvWf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSIIeUAAoJEPo9qoy8lh71t3sP/2mlgop1PujloYgKLYVbNFCN
weEV6yAMd1lhIdwgFlOVckPRDKI69Jlo/+pPdADJKIT3U0pNpjyE+CtlpQOFGxR3
HsWVgz2SxCe0LROWsTK7+Hc6lnact5HZhzrolmly6wRkI2xEnP+mm0RQU/AIErW5
Q/dk7wM+GhVrxaIxLwslTHrdKpjLuh62ker/8w+gq6TfJovoEbOiteUEBjgpiB/u
G233TEBoBTj5Z+Rcx/ng08MN3+yJs9ugxAzJIbCRun4twvK68Xvf5Bg/cWqVuYoL
DtzOLTkCTPSpqzft5ykOeJlaXLxh0TPLcpcu+3FhfHzrMs0Qd3x5wttK0Yznr4Wi
hiIE3trLAT/QX98PM1Gga8ICOqUVPr/DVZudUtZucWnRqtzm+fpNeN8vhBFQy88P
zunF6TrpZbHB8hNqUt5LS2/SC9Q0ULp5aHG3/5B+XLmL/NBx+54dP98SQGsWqxLo
SdH/ju3c2M1L2shVPNg3/Bq++TnidogHcgvvj1C/i1R07QrOzNmIq2UB54u1dol8
4gi7cO3bRwhf0prIR63JGow07EqtnF103cQEHgRbPuqxHYsHe1nwXueiMW5Qz5bg
VHFBxzDzbfjsMsRqVHNzRX88GC7wyvvBg/pyGYAyeymkgrsgy145KTClWzW5B/l6
IrsLfeiT2I3xW4SyPNwn
=GPqs
-----END PGP SIGNATURE-----

--d39JXns3Ml8V34b1kbFrv3vWiADdjgvWf--
