From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 30 Aug 2013 09:47:52 +0000
Subject: Re: [RFC 00/22] OMAPDSS: DT support
Message-Id: <52206A48.8040401@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="P6AOCXNVlxgIXSoL3PwQiUHh6Fg1XA0oU"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com> <20130813075449.GS7656@atomide.com>
In-Reply-To: <20130813075449.GS7656@atomide.com>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

--P6AOCXNVlxgIXSoL3PwQiUHh6Fg1XA0oU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/08/13 10:54, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [130809 01:46]:
>>
>> So as is evident, I have things in my mind that should be improved. Ma=
ybe
>> the most important question for short term future is:
>>
>> Can we add DSS DT bindings for OMAP4 as unstable bindings? It would gi=
ve us
>> some proper testing of the related code, and would also allow us to re=
move
>> the related hacks (which don't even work quite right). However, I have=
 no
>> idea yet when the unstable DSS bindings would turn stable.
>>
>> If we shouldn't add the bindings as unstable, when should the bindings=
 be
>> added? Wait until CDF is in the mainline, and use that?
>=20
> I don't think we should add any temporary bindings as it's going to be
> a pain to support those in the long run. I suggest you initially just
> stick to established bindings for the basic hardware IO address and
> interrupts etc, then those should still be valid with the generic panel=

> bindings later on.

I don't understand what does it matter if the bindings are temporary, or
basic established bindings. In both cases the DT data needs to be
changed when the CDF is taken into use.

Well, one difference is that the temporary bindings would give us
working display, but having only basic bindings would not. So I don't
see any reason to add only the basic bindings. Or how would it work?

 Tomi



--P6AOCXNVlxgIXSoL3PwQiUHh6Fg1XA0oU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSIGpIAAoJEPo9qoy8lh716HoP/jOaxTPZzct/XmOpFiHK+Jub
0Z3c82vlpTB3Cu/wBTGml15Cpry7i0qiU2wnbJMC16Fj4+ft3Ojiu7n8eA/fPuz5
43T9BqN4oka0+981hbrcSO7vQndgK6tPsfxqZ6cBwWeHNdCvjnJip5EAFtZlwL5Z
+cjJ9C6NXoHRaN+bNiOzN7t9nNmw/oIraKuGZNCH2xdbbO7jgVtCGHmgeJfc7Pbp
aH109D/98xO3Fs9DVWtVFHQm6dSeCVdxTf63kUyWJuMLhfjuaS5B2CnxbD1ClIcL
QVMwTJrb9J5mZwfAI4UnrLGZ1Mx81HBImzwErg+wLtLgH/HsnVZmaU5JHc3cTwIL
vV6dIqPFLAg/Inqy4LZ2vSgcnZijWSLRcuWPMNGIOkvwtgiNiqZYBhWUC0MszwJF
d5DUexYebq2BjKmUW5TA8wc1CZypaqQK89ml7k8jXfI632dqygzQuqkwXjQ+wMqm
fkKWUd2rbomLgDA/cow1YOdbZc93mknzajvOHRNZ30r8NiaTt6A6on+wB7Td1vj3
k3WIWDRW6nPnzOyCQ3NZrttvRCIQmuvgPNI9rvN1u5aWVg5PL3rlpVqolfvbfpyH
VdnkoLiV0cinQW1ykhbKpKoJaoYvSLebhHR9wxc1jmX7RqY1SSOQGZ5dp9Wx6Vhx
C7ZIYQGTzqhMMRO12o38
=V+UN
-----END PGP SIGNATURE-----

--P6AOCXNVlxgIXSoL3PwQiUHh6Fg1XA0oU--
