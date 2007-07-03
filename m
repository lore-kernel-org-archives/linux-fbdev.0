From: Paulo Marques <pmarques@grupopie.com>
Subject: Re: [PATCH] pxafb: Add support for other palette formats
Date: Tue, 03 Jul 2007 19:18:40 +0100
Message-ID: <468A9300.7060608@grupopie.com>
References: <200707031607.08511.hjk@linutronix.de>
	<200707031845.57256.hjk@linutronix.de>
	<468A85A2.1070506@grupopie.com>
	<200707031944.21467.hjk@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <200707031944.21467.hjk@linutronix.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: =?ISO-8859-1?Q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

Hans-J=FCrgen Koch wrote:
> Am Dienstag 03 Juli 2007 19:21 schrieb Paulo Marques:
>> [...]
>> I don't see this as a good reason not to implement 18bpp support in=20
>> fbcon. "Just PXA270 18bpp devices" can be a lot of devices out there.
>=20
> I guess most hardware developers will connect their LCD with only
> 16-bit, use RGB565, and are happy with that. It's a pity that this
> requires a physically different wiring of the LCD.

Yes, this is not an option for me or all the OpenEZX users/developers=20
with 18bpp phones :(

>> Anyway, can fbcon work with 18bpp palette mode? If it does, then this=20
>> should be enough for most users of 18bpp pxafb users: have a console=20
>> with a palette mode and then switch to non-palette mode and run whatever=
=20
>> windowing system supports 18bpp.
>=20
> I need to run gtk-directfb, and I'd be surprised if libcairo could handle
> that...

I wouldn't be so surprised... at least the documentation of DirectFB has=20
this:

   DFBSurfacePixelFormat:
      ....
      DSPF_RGB18 ->  6 bit RGB (3 byte/ red 6@16, green 6@6, blue 6@0)
      ....

I assume the "red 6@16" is a typo for "red 6@12", since the "3 byte /=20
green 6@6 and blue 6@0" match exactly the 18bpp packed format. Even=20
more, the "DSPF_ARGB6666" format is described as having "alpha 6@18" and=20
"red 6@16" which is of course impossible. It only makes sense as "red 6@12".

So maybe this is supposed to work with DirectFB...

>> I guess that even if it doesn't support 18bpp palette mode now, it=20
>> shouldn't be that hard to implement (nor should it cause that much bloat=
=20
>> to fbcon).
>=20
> fbcon is not the big problem. But there's a lot of userspace stuff out th=
ere
> where they create graphics in their own buffers and blit it into the=20
> framebuffer when ready. Most of them are definitely not prepared to suppo=
rt
> this format.

If we can't provide a 18bpp pxafb kernel driver, then there is *no*=20
userspace stuff that will be able to work.

At least "some userspace" will be better than "no userspace". And we can=20
always use the power of open-source to bring 18bpp support to those apps=20
that don't support it currently ;)

--=20
Paulo Marques - www.grupopie.com

"The Computer made me do it."

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
