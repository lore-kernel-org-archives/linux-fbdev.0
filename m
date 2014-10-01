From: Mark Brown <broonie@kernel.org>
Date: Wed, 01 Oct 2014 17:17:04 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20141001171704.GG4273@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="emC2J5fP5T/4de5w"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140829143812.GC31264@ulmo> <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929161101.GS16977@sirena.org.uk>
 <20140930060312.GE29874@ulmo> <20140930180036.GI4273@sirena.org.uk>
 <20141001081443.GC18463@ulmo> <20141001122008.GW4273@sirena.org.uk>
 <20141001124852.GB21733@ulmo>
In-Reply-To: <20141001124852.GB21733@ulmo>
To: linux-arm-kernel@lists.infradead.org


--emC2J5fP5T/4de5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2014 at 02:48:53PM +0200, Thierry Reding wrote:
> On Wed, Oct 01, 2014 at 01:20:08PM +0100, Mark Brown wrote:

> > I think you're setting constraints on the implementation you want to see
> > which make it unworkable but I don't think those constraints are needed.
> > You're starting from the position that the DT needs to be updated witho=
ut
> > the bootloader

> No, what I'm saying is that what the simplefb driver expects and what
> the bootloader sets up may diverge as resource drivers are added to the
> kernel. The DT /could/ be updated without the bootloader. You may only
> be able to replace the DTB but not the bootloader on a given platform.

Sure, but doing that and also having the bootloader write part of the DT
=66rom scratch with no cooperation from the rest of the DT doesn't seem
like the way to robustness.

> >                and that the DT must not contain any hint of simplefb as
> > shipped separately.

> Well, I don't think it should because it describes the same resources
> that the device tree node for the real device already describes. But
> perhaps this is one of the cases where duplication isn't all that bad?

If we were worried about this wecould also do it by referring to
those nodes and saying "get all the resources these things need" rather
than duplicating the references (this might make it easier to work out
when the system is ready to hand off to the real drivers).

> >                     That's never going to work well as far as I can see
> > but doesn't seem like an ABI stability issue, or at least not a
> > reasonable one.

> It would work well under the assumption that the kernel wouldn't be
> touching any of the resources that simplefb depends on. If that's not a
> reasonable assumption then I think we can't make simplefb work the way
> it's currently written.

I can't see how that's reasonable unless the kernel has some way of
figuring out what it shouldn't be touching.

> > Either the bootloader needs to be updated along with the DT

> I thought we had decided that this was one of the big no-nos. But
> perhaps I'm misremembering.

It makes things more fragile so it's not desirable, no.

--emC2J5fP5T/4de5w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULDcPAAoJECTWi3JdVIfQsnQH/3DYXJ1k9v9grjj0McGkTOv7
Wo+uU3AyLatwCBxxtgrJdo9p3h3mOjvN75EeVfAy/N4wmFASPRarufPc2hroZVSZ
QxALBD1a+qLJKsP1wfbHAdQde8yBNb/sbGpAjTFn2lekjYI09JthEbNnAsKmLTzl
GKd4FGCME3JRtkZFW2FffwGKgR4G4ARG5U1S59YXfgFr2IC7iGuJi3O/49WRhG8I
gCrnfZ8kfGUpJd3YWxxIMDeo+URF29NTEzRfkhpV9P2Xdy4THSSuexSRLlysPHya
WyjhHh4S3h/NX7t7tsbO/VthbJSrpGl3m6lSGtjX0/mr2QV3yn5jM/W9/V47GvY=
=MbxF
-----END PGP SIGNATURE-----

--emC2J5fP5T/4de5w--
