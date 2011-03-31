From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 31 Mar 2011 04:52:46 +0000
Subject: Re: [PATCH] s3fb: fix Virge/GX2
Message-Id: <20110331045234.GA15486@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201103292107.11969.linux@rainbow-software.org>
In-Reply-To: <201103292107.11969.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Ondrej Zajicek <santiago@crfreenet.org>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Tue, Mar 29, 2011 at 09:07:08PM +0200, Ondrej Zary wrote:
> Fix Virge/GX2 support in s3fb:
> - fix IDs: 86C357 is GX2, 86C359 is GX2+, 86C356 probably does not exist
> - add memory size detection
> - drive it the same way as Trio3D/2X
>=20
> The original IDs most likely came from S3 website which claims that:
> - 356 is Virge/GX2 with ID=8A10, driver included in Windows 2K, XP
> - 357 is Virge/GX2+ with ID=8A11, driver included in Windows ME
> - 359 is Virge/GX2+ with ID=8A12, driver included in Windows ME
> but:
> - google search for 86C356 only reveals references to Trio3D (probably
> because of a typo - Trio3D is 86C365)
> - my card is clearly marked as 86C357, Virge/GX2 and has ID=8A10
> - there is no driver for IDs 8A11 and 8A12 in Windows ME
> - there is a driver for ID 8A10 in Windows ME that says it's GX2 (357)
>=20
> Tested with #9 Reality 334 (86C357 Virge/GX2, ID=3D0x8A10).
>=20
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
>=20
Applied, thanks.
