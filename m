From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 23 Dec 2015 08:32:16 +0000
Subject: Re: [PATCH 5/5] fbdev: omap2: panel-dpi: allow specification of a vcc regulator
Message-Id: <567A5C10.4030001@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="lgjSUPAXhpjQ4kI947keUfv1fJpEOWLSB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449753107-11410-5-git-send-email-uwe@kleine-koenig.org>
In-Reply-To: <1449753107-11410-5-git-send-email-uwe@kleine-koenig.org>
To: linux-fbdev@vger.kernel.org

--lgjSUPAXhpjQ4kI947keUfv1fJpEOWLSB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 19/12/15 22:41, Adam Ford wrote:
> Tomi,
>=20
> Do you have any thought on how to approach adding sleep/delay
> functions?  I have a display that requires a small delay before and
> after the enable gpio toggle.  I assume that some may require a delay
> after the regulator starts for it to be be ready.  For now I have a
> temp hack that just inserts a blanket 300mS wait, but I'd rather have
> something mainstreamed in the device tree, but I don't want to walk
> over someone else's work either.

I don't think it makes sense to add explicit entries for these, as we'd
just end up with lots of entries in the DT files for "wait-before-vcc",
"wait-after-vcc", etc.

There was a patch series some time ago, trying to add generic power
up/down sequences defined in DT. I don't think that ever got merged, as
there wasn't a consensus on the DT side. I can't find the series right
now, as I don't remember the author or the subject...

I think that kind of generic sequence framework would make sense, and
getting it merged without the DT side should be easier. Then the drivers
could have built-in sequences for certain panels.

 Tomi


--lgjSUPAXhpjQ4kI947keUfv1fJpEOWLSB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWelwQAAoJEPo9qoy8lh71WFMQAI78YuQQFbCeNo5Zl+TOmUxz
eegVFumJd4/GsYT5B1RINpUjrECUW7DzZgEnQ8mD6CJsF/RZ74T1rmuuEU1ChilE
TbryvbjtbIdlRS3Nz9RaDUDYxzbUG7X9ouTnpDJWgUXnCaY0tcvuISfDgcKDPblU
L1UKivptMGMwOLVqMX/pZBYpx9NBbiDNjl/8/pKHv6bfqZ5NZnd6lXJpgA++9gE/
3ZgrhmYw46qwW+eJm3ZBIViHO8QGWFFT+dZuiLTTaVZhhJ2I5g4/ykp+dz/qd+it
vcQ9pgVCWQOGM0nA4HDUdfPHoPt6jMfxfms3DcVJDerwKpYU3PU0jUn1H7lhoxZl
T3/u1E4Ou970ntE8U951+wv4iL7Eai1I0F2Gcuhpm8JTvmKxdv+X1okPx1Kkc8NZ
SqqNj5dJktq+w6IRze+5oJInF9pwlbnADXmq6QdyXIp7sJw/mXlXWjEOClpuY/Me
2FEKRwK4F2CPiVB3W2VyXgMhMj9IS1IUT3lqhYrTaAphFF/wLRbcqL9wjHPHhM6x
4FD8an+bpvle7jtkWVGlIdhwew/3+UcH5WCc3XkywYN0b++f/eT1ulFUBbAt+R08
zGH8AXqNhIqSzkyLZtZER0Z0gG95+vEMvcnQNoQbatdRiGMUa5PlsVXCUISBMMWI
sLZyCcrhtNnmQdN/uwgw
=Oc4M
-----END PGP SIGNATURE-----

--lgjSUPAXhpjQ4kI947keUfv1fJpEOWLSB--
