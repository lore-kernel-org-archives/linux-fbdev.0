From: Pawel Moll <pawel.moll@arm.com>
Date: Tue, 30 Oct 2012 15:58:52 +0000
Subject: Re: [PATCH v3] video: Versatile Express DVI output driver
Message-Id: <1351612732.6199.4.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1350405036-17997-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1350405036-17997-1-git-send-email-pawel.moll@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello again Florian,

On Tue, 2012-10-16 at 17:30 +0100, Pawel Moll wrote:
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

It's just a polite a friendly nag regarding this patch - it's been 2
weeks since I posted this version (and 1.5 month since the first one)...

Does it look good enough or completely wrong?

Cheers!

Pawe=C5=82


