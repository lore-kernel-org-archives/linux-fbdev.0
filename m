From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 08 May 2014 09:39:12 +0000
Subject: Re: [PATCH v2 2/3] ARM: dts: oma3-gta04: Add display support
Message-Id: <536B50C0.7030002@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0X6NiaduQ530BqCsLEa230vGmNPsx4d1r"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398284120-4986-1-git-send-email-marek@goldelico.com>	<1398284120-4986-3-git-send-email-marek@goldelico.com>	<5369DAC6.6050608@ti.com>
 <CAAfyv36L_vh+iwrqsePsF8oOxOJ=JXUAk2nJ6F120w+0ivAn8w@mail.gmail.com>
In-Reply-To: <CAAfyv36L_vh+iwrqsePsF8oOxOJ=JXUAk2nJ6F120w+0ivAn8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--0X6NiaduQ530BqCsLEa230vGmNPsx4d1r
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/05/14 10:21, Belisko Marek wrote:

>> Did you try this on 3.15-rc? The above is not right, and I don't think=

>> it works. You need 'port' node for the dpi_out endpoint.
> This patches was tested against 3.15 series and it works. I'l recheck.

Ah, we still have some code that makes that work. But it's against the
bindings documentations, and that code will be removed. So better add
the port node.

 Tomi



--0X6NiaduQ530BqCsLEa230vGmNPsx4d1r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTa1DAAAoJEPo9qoy8lh717lUQAJlZNBw7np66+7mlexo9qudI
Rkf4xodGxwpdsx9yc6UxayUZ2cllCyM8eMsDsDwzQvtOwMluIY7qa5PrpABTSDcO
NADo80/NLLDkJCelL2G9Dq61Vb4wLyKTZwqvgYVHJUBan7e0XqrKBNEnB/dHvAGM
3QeinB+swFc5FQJczNVF2wIAbvUBmQwz2r8oFxheAgewwDO+mf8Jett2wqteU0Rd
2dajhWOcH4rrIsrv8QfkR9pQKmUlAQMev7gJqAuDpZ0EhakPHvKmgGP6zy/e3f74
yow8S8r8yPc23Hoj6ZYoPAwFKTrxFH4zUMUiNxP0syheSARg3mhMWaD9l43PQyPy
PfqlFz4dgnNB94WZjdg8dU+gtR946wWphv1nUsdwCPtUU0C+z/BPolkR+HBIq4+D
F4HSxTZRLhOCe86uftk1L/0v4PNO6SCcyBcL+7fY0n6s1NU2al7134kEgQJcYs+8
ruFk1IsH/yKfKM4560VEpRXTmK65wgZ0surfk/+lalfkJKJ1KWWFjJvyVZPKnK6N
5Ma3Ws2YFJ6V+EgoHf5hthFTBi+gn6YFAAahsq/tnuGRgeV6v1cyN8A+kj4JLnlc
F2HbjmJX2n+V6G13GmdN8/j7B8XAB4U82izO/JUUIOq7zOv7Zfm0Ki1VJ0L6lnXW
Jr+ailpb96Z0dfaDAwOk
=GPMt
-----END PGP SIGNATURE-----

--0X6NiaduQ530BqCsLEa230vGmNPsx4d1r--
