From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 15 Dec 2011 08:09:41 +0000
Subject: Re: [PATCH 2/2] offb: Add palette hack for qemu "standard vga"
Message-Id: <1323936581.21839.68.camel@pasglop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1323907109.21839.28.camel@pasglop> <4EE9A6A5.2050600@suse.de>
In-Reply-To: <4EE9A6A5.2050600@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org

On Thu, 2011-12-15 at 08:49 +0100, Andreas F=C3=A4rber wrote:
> Am 15.12.2011 00:58, schrieb Benjamin Herrenschmidt:
> > We rename the mach64 hack to "simple" since that's also applicable
> > to anything using VGA-style DAC IO ports (set to 8-bit DAC) and we
> > use it for qemu vga.
> >=20
> > Note that this is keyed on a device-tree "compatible" property that
> > is currently only set by an upcoming version of SLOF when using the
> > qemu "pseries" platform. This is on purpose as other qemu ppc platforms
> > using OpenBIOS aren't properly setting the DAC to 8-bit at the time of
> > the writing of this patch.
> >=20
> > We can fix OpenBIOS later to do that and add the required property, in
> > which case it will be matched by this change.
>=20
> Just let me know what's needed for OpenBIOS.
> Is this just for -vga std as opposed to the default cirrus?

Yes. Cirrus isn't the default on mac99 and on pseries (tho I will
eventually add a SLOF driver for it as well).

For OpenBIOS I was thinking about just sending you a patch :-) But if
you have more time than I do, what is needed is:

 - Set the 8-bit DAC bit in the VBE enable register when initializing
the card (0x20 off the top of my mind but dbl check). Remove your >> 2
in your palette setting.

 - Implement color! so prom_init can set the initial palette (but that's
not strictly necessary).

 - I assume that the VGA device already has a device_type of "display",
can be open()'ed from the client interface and will have the necessary
properties to be used by offb (width, height, linebytes, depth, and
address if fits in 32-bit (if not, ignore it, offb will pick the largest
BAR)).=20

 - Stick "qemu,std-vga" into the compatible property of the vga PCI
device.

Cheers,
Ben.


