From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 04 Jan 2012 07:50:56 +0000
Subject: Re: [PATCH] video/omap2. dispc_mgr_enable needs runtime PM
Message-Id: <1325663456.1875.14.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-np/MFQNWjF2ymvqJZL8H"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20111230123755.384a5b5c@notabene.brown>
In-Reply-To: <20111230123755.384a5b5c@notabene.brown>
To: NeilBrown <neilb@suse.de>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-np/MFQNWjF2ymvqJZL8H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(dropping the Tony and Kevin, as they're probably not interested in
this)

On Fri, 2011-12-30 at 12:37 +1100, NeilBrown wrote:
>=20
> When dispc_mgr_enable is called during shutdown the device might
> be asleep, which causes problems.  So ensure it is awake.

How does this problem happen? dispc_mgr_enable(channel, false) shouldn't
be called if the device is asleep, and thus dispc_mgr_enable() shouldn't
use dispc_runtime_get.

 Tomi


--=-np/MFQNWjF2ymvqJZL8H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPBATgAAoJEPo9qoy8lh71jgIP/0yvVpmxrWdfFy42uHDZTGA+
toPqFy0swbf729slqWArBUyxsnke/0fjp62xolyH+vXCDwnwP3PujL2qgF6emcLn
uhHjgI3g2AQopApYjGx4GAZoHVuzjKlEbW/jDY7e5It2p+5NOQDTnyyxC6WfsbgD
1S8Wna36G+oOX3Qgbzflz0w5x4CucSIxMvcgIYstmA5HSrOXiHSMLP5sSFyuAmcc
T+gYt8Mc28kLFsreX+UR+coZrq+Yj9Vpqpj3CAMVZEiuTY/8DsCshptUjFzt4x7Z
DFRmRc7N9EDA518vnXAwa1lUEcYIgCANuur3WJPPDd7oigx1aK49XoRE6t7Eza+B
IATWPptunY+Oq7clCfZFznCYmNAjWVqV+twmSx4WA7luqYC6d2km/JH4P98ZOwcs
pyaDH6zONOfXhoWFgfEQ3MImWaGfbAprAF/xPky8+fir1uYpR2nRi9mVeyTTSq/V
UdbUB/hRjbJ/dCqCoJC1ZJOoSwT78GdJKYlV/QCsM07+QdsKiqWOs+wjkuvMbvLb
7ehROYkjT0rui+KL2hzk6mNtXaEdK777xoQeGh/5Z/NyLKxtiW2HpWpFYSnBZvaA
DxTDv8NLlW02ZgtQefNWcYiJYX1OKoK/SHQ7cBfpKHtjgYEejs8TsNXDVVFORHmu
ErGxbKHInQr2zbpiv3dr
=8gY6
-----END PGP SIGNATURE-----

--=-np/MFQNWjF2ymvqJZL8H--

