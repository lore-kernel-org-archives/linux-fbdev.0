From: Pawel Moll <pawel.moll@arm.com>
Date: Mon, 19 Nov 2012 13:56:17 +0000
Subject: Re: [PATCH v3] video: Versatile Express DVI output driver
Message-Id: <1353333377.3303.7.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1350405036-17997-1-git-send-email-pawel.moll@arm.com>
 <1351612732.6199.4.camel@hornet>
In-Reply-To: <1351612732.6199.4.camel@hornet>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Arnd, Olof,

One of the important parts of the VE update is the display muxer
driver...

On Tue, 2012-10-30 at 15:58 +0000, Pawel Moll wrote:
> Hello again Florian,
>=20
> On Tue, 2012-10-16 at 17:30 +0100, Pawel Moll wrote:
> > Versatile Express' DVI video output can be connected to one the three
> > sources - motherboard's CLCD controller or a video signal generated
> > by one of the daughterboards.
> >=20
> > This driver configures the muxer FPGA so the output displays content
> > of one of the framebuffers in the system (0 by default, can be changed
> > by user writing to the "fb" sysfs attribute of the muxfpga device).
> >=20
> > It will also set up the display formatter mode and keep it up
> > to date with mode changes requested by the user (eg. with fbset
> > tool).
> >=20
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
>=20
> It's just a polite a friendly nag regarding this patch - it's been 2
> weeks since I posted this version (and 1.5 month since the first one)...
>=20
> Does it look good enough or completely wrong?

I've asked the framebuffer people 3 times about this but got no comment
whatsoever:

https://patchwork.kernel.org/patch/1473091/
https://patchwork.kernel.org/patch/1601781/

so I assume there is no problem with merging this code ;-) Therefore,
would you be so kind to pull this single patch? Without it the 3.8
kernel will not be able to show anything on VE's display...

The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:

  Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git vexpress-drivers2

for you to fetch changes up to 357e174056d44c6614afec6c5ace1c2aea2ef0bb:

  video: Versatile Express DVI output driver (2012-11-19 11:12:40 +0000)

This is the very last thing for 3.8 merge window from me.

Thanks and regards

Pawe=C5=82


