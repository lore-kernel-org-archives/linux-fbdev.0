From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Aug 2014 22:00:56 +0000
Subject: Re: [PATCH v7][ 3/5] video: mx3fb: Introduce regulator support.
Message-Id: <20140822220056.GE24407@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="4loEm8vkm2dPEmEM"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394788369-5096-1-git-send-email-denis@eukrea.com>
 <1394788369-5096-3-git-send-email-denis@eukrea.com>
 <20140317062026.GZ17250@pengutronix.de>
 <5397083D.4090400@eukrea.com>
In-Reply-To: <5397083D.4090400@eukrea.com>
To: linux-arm-kernel@lists.infradead.org


--4loEm8vkm2dPEmEM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 10, 2014 at 03:29:33PM +0200, Denis Carikli wrote:
> On 03/17/2014 07:20 AM, Sascha Hauer wrote:

> >This patch adds regulator support for the display of a i.MX3 IPU. The
> >problem Denis has to solve here is that he needs to get the regulator,
> >but the display devicenode doesn't have a struct device associated with
> >it, so he cannot provide one to regulator_get(). One way out here could
> >be a of_regulator_get(struct device_node *). Mark, would this be ok with
> >you?

> Here, the display devicenode has no struct device associated with it like
> mentioned above.
> Because of that, retriving the regulator from the devicetree, for instance
> like regulator_dev_lookup() does, would require a different approach.

> As I understand it, what happen in regulator_dev_lookup when
> regulator_get(NULL, regulator_name) is used is the following:

> Since the struct device is NULL, it skips the struct device based lookup,
> but also the devicetree lookup (it uses dev->of_node for that)
> At the end it falls back on a match on the regulator name to find it.

> would keeping regulator_get(NULL, regulator_name); in the driver instead be
> better for now?

It would be much better to have an actual device to get things for,
using a hard coded regulator name is very much deprecated.  Using a hard
coded name is fragile and we don't have support for mapping this
properly in the device tree.

--4loEm8vkm2dPEmEM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT972VAAoJELSic+t+oim97YYQAJaMabhWT+llhsEfZGgklo48
nR41iWFFTGyhTUN6QrRzeJYWZDqMsvpUcB+HLEC/FMWAQ22o50RqmNAUKhCssfSN
TFYpcd/IkNKPe2Zgesvb/qYZ6wsn8V7Wjhhvq7YsCEHz9eY9fVCyuWa4NHVksJVg
ZcHd7Rdg5TV5BElnxe3IbkAqJVRMP+NBFU9ksSi9QX/IEw1FFCyprEDtiUsZZeMz
Vp82jn/YSCtWtWSb0RxHGkU1KAIgrzwpkwOxxAlhb04p2F4q2g6qQ0RhqKOWhQ3h
jx4j5VRl7orJ7ZeI+SRGHwcd3roDG9MaGW6cl/xUzDVgB4hMPS6UPs83GU6Wjsxu
maRvsElvKvtKblndme+gFSmgt7pPnj3ea2AXGqTriD5V7PZjoZaCrYfvpeY/cxsa
gYSo8/yesz4Jk+KzwyBbctRxDnZ33SIpEAy31o7joO0zf2oAILjTfpMUZTNnaEk6
zOB/po1pteRAj8W5gQiJt9euTy3QliMEJmgj5iSrgn68oPt+9jGAa7VSFdb7/mEZ
+IL1kzHmVaIqevBjkrnogHD+ZrqeyKj5l5mmbV11u+yrmHKmpDqJmcsa343MTg8u
D4QDdHkeS5qJ9TwDjNl1NG7lVbSTEa3VpQQFk6SyzMtcbl9M896tVPXdiLX2+QEB
plHTYWKOaGKUwTYnPk6W
=VMrw
-----END PGP SIGNATURE-----

--4loEm8vkm2dPEmEM--
