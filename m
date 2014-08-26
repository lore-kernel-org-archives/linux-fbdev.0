From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 26 Aug 2014 08:26:27 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140826082626.GE17263@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Qz2CZ664xQdCRdPu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <53FB46FF.1010208@redhat.com>
 <20140825145303.GC14763@ulmo.nvidia.com>
 <20140825150705.GB15297@lukather>
In-Reply-To: <20140825150705.GB15297@lukather>
To: linux-arm-kernel@lists.infradead.org


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2014 at 05:07:05PM +0200, Maxime Ripard wrote:
> On Mon, Aug 25, 2014 at 04:53:06PM +0200, Thierry Reding wrote:
> > Hmm... that's true. But we already have a way to deal with exactly this
> > situation for regulators. There's a property called regulator-boot-on
> > which a bootloader should set whet it has enabled a given regulator. It
> > can of course also be set statically in a DTS if it's know upfront that
> > a bootloader will always enable it. Perhaps what we need is a similar
> > property for clocks so that the clock framework will not inadvertently
> > turn off a clock that's still being used.
>=20
> Except that such a property won't work either.

Of course it won't work if it's designed not to work. The solution to
that is to design it in a way that it works and does exactly what we
want it to do.

> Regulators with regulator-boot-on will still be disabled if there's no
> one to claim it. Just like what happens currently for the clocks.

I was somewhat surprised by this, but it can indeed easily be verified.
It seems to me somewhat at odds with the definition of such a property.

Mark,

You've probably not read the whole backlog, but the discussion revolves
around hand-off of resources from firmware to kernel (via DT in this
case). If firmware initializes a device (display controller in this
particular case) and enables resources needed by the device to work
properly then in order to properly hand over resources from firmware to
kernel we need a way to communicate the state of these resources. For
regulators the regulator-boot-on property is specified to do exactly
that. However the implementation will automatically disable a regulator
marked boot-on if it hasn't been claimed by any driver after the
initcall stage completes.

I find that rather odd since I always assumed that a regulator marked
boot-on would not be touched by the core at all, assuming that firmware
set it up properly and that it would be required (even if not explicitly
claimed).

The issue that this causes is that we can't properly hand-off devices
initialized by firmware because the regulator will be disabled after the
initcall stage and then enabled when the driver loads. In case of
display the result will usually be flicker. The same applies to other
types of resources (in this case clocks).

Two categories of drivers have this issue: drivers built as modules (or
that defer probing) and therefore won't be probed until after initcalls
have run and generic low-level drivers that take over firmware devices
(simplefb in this case) that don't know anything about the resource that
the devices need.

Also Cc'ing Mike, perhaps he has ideas on how to solve this problem for
clocks specifically.

Thierry

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/ESyAAoJEN0jrNd/PrOhRC4P+wfWQa3JGrzp+hEWk3efxg+Z
Hc9wyWgIalLSnilL8NT8nWxPgscdOLlwBvqQRz4GZSd+AF8p9wprcFyrOls9QO7g
8hJsz1+TwpR2/p68UKsuGq4EwmHOkmNEGLjuEJmVFz58L2yWPbRQIl4rYTmEBYI9
ZNHQUC1iCL9Gazf9Q1a9EFAjbwPdXHzdNH2FldUTjrM80ddJnASagANpb1TVbZue
yLl/HKxarczVMLMSHWDZI+lzdoBbNzPUJJrWlUTJr4Coiz6vAGoT+3VvIJcsMBuc
GUGRmcLMvE5t/9rogBYIkzhQGdjeLLNwj/SspwRTlexr/a0J2Ya4GS35Q/HIn1Mh
XwDVoZVXuC0iiGTfnee0Q3c4cM3DgtptJ6Vwz27oSu8QW3uPqrjctwT8H+DFrYyR
hp+lr5g/v5FkzTn7PVgaFKMHXRRynj4rar9zmc8ukCpwrFqQhwuakdJKP8rnDC7C
/wAsPtHht8eXhtoBdSZ8r+mnrPIv2ENRK3xDHYwe02iPtNEUvSbcBozL8IdfAeOz
V5lAbbgO4cLxQ0dM+hO0uDkUERSt1jznyTCPOVbjgQ33JGyux3rE0R+zp6mMYnO9
69johxzu1Mis8FNFdEbS6M1aEtfQBKnzELt7FdXzQ1+NWRuDU5nnVoIzejpIGRFA
8GgP1Au8hJN/k5JRSoda
=/ywg
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
