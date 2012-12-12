From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 12 Dec 2012 18:05:19 +0000
Subject: Re: [PATCH v4] video: Versatile Express DVI output driver
Message-Id: <1355335519.19818.46.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353342376.3303.32.camel@hornet>
 <1353343147-15654-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1353343147-15654-1-git-send-email-pawel.moll@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Arnd,

On Mon, 2012-11-19 at 16:39 +0000, Pawel Moll wrote:
> Versatile Express' DVI video output can be connected to one the three
> sources - motherboard's CLCD controller or a video signal generated
> by one of the daughterboards.
>=20
> This driver configures the muxer FPGA so the output displays content
> of one of the framebuffers in the system (0 by default, can be changed
> by user writing to the "fb" sysfs attribute of the muxfpga device).
>=20
> It will also set up the display formatter mode and keep it up
> to date with mode changes requested by the user (eg. with fbset
> tool).
>=20
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Could I just politely remind about this one?

Pawe=C5=82


