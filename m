From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 18 Feb 2016 11:52:32 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <56C5B080.9090007@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Fd13j3gVa1J1jQvOhakRGTMHGaqJueeEx"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <56C438DA.5040109@ti.com>
 <CACRpkdZ+G17hmVP8AejL7NTqg7k0SBC5kgF55ASjD+kfuGFJhQ@mail.gmail.com>
 <20160217213250.GK19428@n2100.arm.linux.org.uk>
In-Reply-To: <20160217213250.GK19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org

--Fd13j3gVa1J1jQvOhakRGTMHGaqJueeEx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 17/02/16 23:32, Russell King - ARM Linux wrote:
> On Wed, Feb 17, 2016 at 05:17:33PM +0100, Linus Walleij wrote:
>> As Russell points out: it's a register that contains a number saying w=
hat
>> panel is connected.
>>
>> So it is plug-n-play and I want to preserve this in the patch.
>>
>> The alternative is to make one DTS per display type connected, but tha=
t is
>> loosing all the nice plug'n'play :(
>=20
> That's totally insane: we're talking about what's plugged in through
> an external connector.  It's not an "internal" device connector.
> These displays are external separate boxes to the board.
>=20
> We don't have separate DT files just because we plugged in a USB device=

> to a board., or a SDIO card, or an external HDD.

That's because USB, SDIO, HDD are all standard piece of HW, and any
probing can be done via the bus.

For panels we need DT fragments. The question is where these fragments
are and, possibly, who who loads them.

>> But if an overlay can do the same, I'm game for it.
>=20
> That's rather eww, because that means you need to either build the
> overlay into the kernel (which IIRC then ties the base DT file to
> that exact kernel) or it needs to sit in userland, which means no
> LCD display until userland is up and running.  It doesn't sound very
> satisfactory, IMHO.

I don't think there are any satisfactory solutions to this.

For me the eww'est option is what this patch does, adding lots of panels
to the .dts, even if the panels are not connected, and having a board
specific fbdev driver. On the other hand, it's easy solution.

One a bit more general question here is: who should know the details of
the board? Is it the bootloader, kernel or userspace? I think the aim
has been to make the kernel drivers generic, not board specific. If so,
it hints either towards the bootloader or userspace. If userspace, the
panels will only be enabled later, when userspace is up.

In my opinion the best option would be to use DT overlays, but so that
the bootloader would supply them, or construct the dtb. But afaik that's
not possible at the moment. And perhaps I think that's the best option
only because I don't work with the bootloaders =3D).

So, I don't like this, but I don't have a good suggestion how to do it
better with the infrastructure in place at the moment.

We (TI) are struggling with the same problem at the moment (we don't
even have detection capability in all cases), and so far I've refused to
start adding board specific hacks to the display drivers. So I'm very
interested to find a good solution to this too.

 Tomi


--Fd13j3gVa1J1jQvOhakRGTMHGaqJueeEx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxbCAAAoJEPo9qoy8lh71RPMP/2TSmv+RGUADKIjiJMmRuwZJ
m4/JOHpUfz7C+8KnOuDsTzy/UT8ewqrafT7pH3txKoXYJrxARHlX9ayvA+oaf6b9
cPBWaLahXjd9jC+jWbKAByplsPztXuh6n6/fCIREhuBgepZKewR3gs3NnZbBB81V
Vx90Cw1XoaSc00ojmfW8VAbD0SvYBQhNCzMzSfgpuKBPwHKdaTcFj7RlJ3ZxT9Jc
AXXRqHVfLm+NxO6I580CXbi2qa811UXXURDwHr7xvoNo8rquXwzb1AehBtm7heFj
g79qEq/kCYlGJCgGEWqeiElbdQuYb1eFQIebUE8kbtnIpTJLWt8VigcwiRal5Iow
0+jlULlP+vTEg88Q9tlVb+IJfpoLItyiWEKfRBSwJZvHpWRQoqQtbYNo64++trz5
/4Ua5exh7GywhABtk2IWC7zIwT8E+J8fYIzQdc6vsc3GFMZtdy2+sb+NL5pa8u/s
VTgz+iyFk063Dcs+1dIzZVtiiiHgszLfx7Pfl58UtqfPtDcYeKIoBnT+dpX8hTkZ
hx7bTpT+oW4UxCHlzoiD9+YMk/qstijlbzR/Zh7crT6UybZGHSVBc/iuHyX2SYnW
688zztIh738960T798h2Pi3gRS4+yQgiHiTH3eBdqaTBHFSVBZvwWoRvNelxHr4f
wuxroOVwrZnu0QUFERhm
=rDny
-----END PGP SIGNATURE-----

--Fd13j3gVa1J1jQvOhakRGTMHGaqJueeEx--
