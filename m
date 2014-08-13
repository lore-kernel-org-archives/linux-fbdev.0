From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 13 Aug 2014 17:01:06 +0000
Subject: Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140813170106.GT15297@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="kG2acDqmwoBDcCHP"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org>
In-Reply-To: <53EB9471.3090204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org


--kG2acDqmwoBDcCHP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
> On 08/13/2014 01:17 AM, Luc Verhaegen wrote:
> >This claims and enables clocks listed in the simple framebuffer dt node.
> >This is needed so that the display engine, in case the required clocks
> >are known by the kernel code and are described in the dt, will remain
> >properly enabled.
>=20
> I think this make simplefb not simple any more, which rather goes
> against the whole point of it.
>=20
> I specifically conceived simplefb to know about nothing more than
> the memory address and pixel layout of the memory buffer. I
> certainly don't like the idea of expanding simplefb to anything
> beyond that, and IIRC *not* extending is was a condition agreed when
> it was first merged. If more knowledge than that is required, then
> there needs to be a HW-specific driver to manage any
> clocks/resets/video registers, etc.

I'm sorry, but how is that not simple? clocks enabling is step 1 in a
driver in order to communicate somehow with the controller. Reset is a
different story, because arguably, if simplefb is there, the
controller is already out of reset.

And I don't see why video registers are coming into the discussion
here. The code Luc posted doesn't access any register, at all. It just
makes sure the needed controller keep going.

> The correct way to handle this without a complete DRM/KMS/... driver
> is to avoid the clocks in question being turned off at boot.

Which is exactly what this code does, using the generic DT bindings to
express dependency for a given clock. How is this wrong?

> I thought there was a per-clock flag to prevent disabling an unused
> clock?

No, last time I heard, Mike Turquette was against it.

> If not, perhaps the clock driver should force the clock to be
> enabled (perhaps only if the DRM/KMS driver isn't enabled?).

I'm sorry, but I'm not going to take any code that will do that in our
clock driver.

I'm not going to have a huge list of ifdef depending on configuration
options to know which clock to enable, especially when clk_get should
have the consumer device as an argument.

> For example, the Tegra clock driver has a clock initialization table
> which IIRC was used for this purpose before we got a DRM/KMS driver.
> That way, all the details are kept inside the kernel code, and don't
> end up influencing the DT representation of simplefb.

I don't really see how the optional usage of a generic property
influences badly the DT representation of simplefb.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--kG2acDqmwoBDcCHP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT65nSAAoJEBx+YmzsjxAglrUP/Aohf9FisKzsAr0/NzCBLl8c
BLHMGp0OHelOKDZ5PIz5oFTfU5N5xlGYfnMgeQlP+pPr4V4Kx7JFI8A+IRMscGbL
yA+Hpl1kBEXMfEVXhvOpWL1On7AEcL+Zo1KA2C3GDNI0CtVIvwokaIXutv6qURIV
z+93nuHl9vqKCdLKR8zN5wO1w0qK9mJMS208LFfqCa68EMnRhmoZ/HBrP1R8tt2w
UhD/9sBwQIvTohJIUlKxZwxDjvklMe7fkC3v8BRzBiFpU1wXLTgcK4l+n8C6A7kO
nuJi9F0UUt8kQNKr/lL5kZYjswU8m9FJ2MQ078TRGR/SR9L5MlysRn5RGfIwhzYf
fOehQNaAphtyfUUM8uhihpiJyI+t//KMBQY8JDH3qk/BO/mh1vfXyYuxU9cXtqbG
JXxaARaapet/f+D77+zd7x3GpWD606hkrNz1Wze5sDf7u8MJKEeqhqc/cJrQ/bai
d2iOL+nHCI6ATfpuJuZx/OX7OWq368s/9DQtcjH6GDALNuL4NYK90FcVV1VSVwaZ
XqxmnsHEZMacPBZ0sRs5CDWGZ1pm3jIyQjKQOBT+aBgC7OOSG6usHqt8E3v0WI7D
c0HLEU/VyRAyyl/a6JtvkMxiZOdPyaaSuEGyokfAH/RAneccyxY81NL2j/yIdnDJ
Dm4A3865kn1/l5cqAKzX
=E2bv
-----END PGP SIGNATURE-----

--kG2acDqmwoBDcCHP--
