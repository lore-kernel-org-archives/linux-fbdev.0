From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
Date: Thu, 18 Jun 2015 15:31:25 +0000
Subject: Re: [PATCH] nvidia/noveau: Fix color mask
Message-Id: <20150618173125.3ae0047c@wiggum>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/oQx8F2UhgJTKw0cSMVP2gah"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150617190508.5205e8af@wiggum>
 <CAKb7UvjUdOSrYE4L3AqE3Q06mXyyon42U26o9t3M5XLYz2aJmw@mail.gmail.com>
In-Reply-To: <CAKb7UvjUdOSrYE4L3AqE3Q06mXyyon42U26o9t3M5XLYz2aJmw@mail.gmail.com>
To: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: linux-fbdev@vger.kernel.org, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>

--Sig_/oQx8F2UhgJTKw0cSMVP2gah
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jun 2015 20:47:17 -0400
Ilia Mirkin <imirkin@alum.mit.edu> wrote:

> On Wed, Jun 17, 2015 at 1:05 PM, Michael B=C3=BCsch <m@bues.ch> wrote:
> > The expression (~0 >> x) will always yield all-ones, because the right
> > shift is an arithmetic right shift that will always shift ones in.
> > Accordingly ~(~0 >> x) will always be zero.
> > Hence 'mask' will always be zero in this case.
> >
> > Fix this by forcing a logical right shift instead of an arithmetic
> > right shift by using an unsigned int constant.
> >
> > Signed-off-by: Michael Buesch <m@bues.ch>
>=20
> Confirmed that this does indeed happen with
>=20
> #include <stdio.h>
> int main(int argc, char *argv[]) {
>   unsigned mask =3D ~(~0 >> (32 - (argv[1][0] - '0')));
>   printf("%08x\n", mask);
> }
>=20
> I guess fbdev/nvidia/nv_accel.c was the source of all this, as the
> code is identical, and it probably came first.


If anybody is able to help me in creating a working semantic patch
(coccinelle) for this, that would be great.

I found this using a very hacky and incorrect spatch (some
version is attached). It throws many false positives, doesn't find all
such bugs and does not create correct patch output (especially the
#define related rule is just meant as a hint).

Some basic thoughts that come to mind that could possibly be statically
checked somehow are:

- right shift of promoted variables. That is stuff like this:
  u8 x, y =3D 0x0F;
  x =3D ~y >> 1;
  /* x is 0xF8, not 0x78 as someone might expect. */
- Also check this for typedef'ed types where promotion takes place (that
  are smaller than int)?
- right shift of signed constants (like in this case). That probably is
  wrong in most cases.
  How to check signedness of constants in spatch? (123 vs 123U)
  Is that even possible?
- Also detect this stuff, if variables/constants are hidden via #define
  or such:
  #define REGVAL	0x0F
  writereg(REGISTER, ~REGVAL >> 1);

Probably more stuff could be checked. Ideas are welcome. :)

--=20
Michael



@@
u8 e;
expression s;
@@
- ~e >> s
+ (u8)~e >> s

@@
s8 e;
expression s;
@@
- ~e >> s
+ (s8)~e >> s

@@
u16 e;
expression s;
@@
- ~e >> s
+ (u16)~e >> s

@@
s16 e;
expression s;
@@
- ~e >> s
+ (s16)~e >> s

@@
char e;
expression s;
@@
- ~e >> s
+ (char)~e >> s

@@
unsigned char e;
expression s;
@@
- ~e >> s
+ (unsigned char)~e >> s

@@
short e;
expression s;
@@
- ~e >> s
+ (short)~e >> s

@@
unsigned short e;
expression s;
@@
- ~e >> s
+ (unsigned short)~e >> s




@@
constant c;
expression s;
@@
- ~c >> s
+ (unsigned int)~c >> s





@sh expression@
identifier val;
expression shift;
@@
val >> shift


@@
expression e;
identifier sh.val;
@@
- #define val ~e
+ #define val e


--Sig_/oQx8F2UhgJTKw0cSMVP2gah
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVguRQAAoJEPUyvh2QjYsOeFgP/2JlxYvHctn/tSy2WNr7y9t6
a42rF+TZIkgCCroi28txNWdfpmwW37WYyhPx9T/vJJtspqH+U44M7gLBH8ru9jGc
SJt9gPdgll2l37CvAzIhIcZIKdlpNNlCFmNXpXM3JeAfQbRaFggJAVGaSHo1UMPO
bmDnTXKFRevXSc9f8EcCMxT/g1RKvoIPzgcQCxU9h94gw3ayxQY8PpGNQiiTw5Yc
6PlB3LA3+b4RjIohz+mSmoFK3Lqb7fNhbEdJAD/h7kH7kIyOnSfU7YkKBQsdLKEo
PpjJuosEVFbSxS0V+CFHWTrCXGeLpXM4ofSuIMNZPuC+GTL+VfVAoMIjTntZAOmx
vbvpP1CWCbxd5g32mDUEFvFVdcAUf67/Airh3QGMWMb7/HnbTGW2cJ4VJffbDiXj
Uzn9VZ5QjMRL648VN/lzZ09rBSnbBsXwkeRsHRu46MS2khQH99xLDU2iSd8DLY0J
Hc84Lj04NwOm/gNPK8Ro8ABtsaLeYQi3kU1T1sE65TTgwyvM3DqMTb7reuNy1AJX
FIobt90JrPn5tg8IdduBIw6PLJjKCmatHkyuaqmZta1PBEHitESDD7/tsvxkSwWc
f81iYhHrdSL56P2U2xjXXsaaOja9xFWIO0fpEeFGi4MBOA9nN81HF6Zs3ucn001t
KNQ7Ox6RigLpdOoGMkz+
=CL6R
-----END PGP SIGNATURE-----

--Sig_/oQx8F2UhgJTKw0cSMVP2gah--
