From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 24 Feb 2016 11:21:51 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <56CD924F.50108@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="muk5thKvOXpBV2E8sCeU1FnMj6JL1L47L"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <56CC2D39.80909@ti.com>
 <CAFEAcA9U3V04o2_93bS5G7+k=UT7kTWt4=v7t1Ju0X9W=5oo9A@mail.gmail.com>
 <56CC546A.9070705@ti.com> <20160224104638.GL19428@n2100.arm.linux.org.uk>
In-Reply-To: <20160224104638.GL19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org

--muk5thKvOXpBV2E8sCeU1FnMj6JL1L47L
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24/02/16 12:46, Russell King - ARM Linux wrote:
> On Tue, Feb 23, 2016 at 02:45:30PM +0200, Tomi Valkeinen wrote:
>> My opinion is that the bootloader should be responsible for telling th=
e
>> kernel what hardware there is on the board. For busses like PCI we hav=
e
>> proper probing mechanism with global unique identifiers for the device=
s,
>> and nothing is needed from the bootloader.
>=20
> Exactly, but that is _NOT_ the case here, because we're not talking
> about an on-board display.

Ok, what is it then? I'm not familiar with the boards in question.

When does a display become an on-board display? All the panels I have
can be disconnected quite easily, but I still consider them as on-board
displays.

>> In the Versatile case the panels are kind of probeable, but not in the=

>> same sense as PCI: all that can be probed on Versatile is a board
>> specific ID, which in itself doesn't tell what kind of panel there is.=

>> In addition to the ID we need board specific tables listing the detail=
s
>> of the panels.
>=20
> That argument does not stack up.  Just because you've plugged in a
> network device does not mean that the kernel can drive it: the kernel
> needs a device specific driver, which is determined by looking at the
> IDs.  There is no standard network driver PCI interface.

Yes, but you can connect the network device to any board with a PCI bus
and it works. Here, if I'm not mistaken, the displays are built for this
single board, making them board specific.

So sure, someone could build boards with the same connector, allowing
you to connect the same displays. If that's the case, then CLCD should
be taken out of this picture, as the board could have something else
than CLCD as the display controller.

>> I think one of the core questions here is: do we want to start adding
>> board specific drivers to the kernel, instead of dealing with it in th=
e
>> bootloader when possible? My understanding is that we've been trying t=
o
>> reduce board specific code from the kernel.
>=20
> That's not really the question, because that question assumes that it
> isn't already present, which is not true.  The code is already present.=

> The question is how to deal with this from the DT perspective.

Yes. As I commented in this (or the other thread), I'm looking for a
proper generic solution which can be recommended for all new boards.
When we know what that is, we can see if and how that could fit into
Versatile's case. Versatile is not the only board with the exact same
problem.

I wouldn't be at all surprised if the final solution is to just go with
Linus' current patches for Versatile, as everything else would break
compatibility or be overly complex.

But I cannot accept that as a general solution for all similar cases
going forward, especially when moving to DRM world, that's just bad SW
design.

 Tomi


--muk5thKvOXpBV2E8sCeU1FnMj6JL1L47L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWzZJPAAoJEPo9qoy8lh71Lg0P/3l84G4pE7G+FYgZKvf+UI2N
oHmp/2aIZbjp0CzpJOZW8KiFXzQhj6iH2auH2C5JYX6N8/+d+s79XZXYyPb478pS
HAdUQcehQMZbkXMrAc9ajWehgVSkCVebB1Nsw1ujrGHHkrALOe2PgonXJUHYZu7J
WVE/rlq8a4FqoGDaC23O7cQxksBfxNFZm8UDsHyAcXtfhmYvmgMXDZw+EzW+Rf5b
ZUicb/GoHTh8HHT98QOGcDrB29vmKG8XGXgiUQZsKSt3YikMbY0N7kxV0qAdXS9g
4XTmOfSPcyOqQCWiJVHQeMfe2x2X7Zvdmlgv88EeDA+D96DPJiOX5xXi61YMmoMj
WGAk2Lvy0QeTFRZdd56czix01K01gUcC343BqoUujEzYEYNJ0sB7mPXfCd+JKDh1
+Kx/cz6trPgGbP4HksenjEqWxjnFTJSnzhWiblsvq29wa5KehpsdeRj/94qqGH5U
Qarp5WsB+xhYMAIDoBl2ooQh7qBYWHeYfzASSqST3ZJoqBIWfEzWO5KHjGPrUzZU
srepjGlTpxHi3W/Y8qygQSmVhKyuvFooklHzcU3WcOWGu8Ie/4LG9MebsLx71SI1
vIT/lOrWptb/DHF7X781d11CVWrCxk++EGJljC0ksRzMlpsfZfvkHK6HNFsa8kpM
8fKHwzsYEDr1soyItpwv
=Ne/T
-----END PGP SIGNATURE-----

--muk5thKvOXpBV2E8sCeU1FnMj6JL1L47L--
