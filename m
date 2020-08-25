From: Wolfram Sang <wsa@kernel.org>
Date: Tue, 25 Aug 2020 07:10:33 +0000
Subject: Re: [PATCH] dt-bindings: Whitespace clean-ups in schema files
Message-Id: <20200825071033.GB1861@ninjato>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JYK4vJDZwFMowpUq"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200812203618.2656699-1-robh@kernel.org>
In-Reply-To: <20200812203618.2656699-1-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2020 at 02:36:18PM -0600, Rob Herring wrote:
> Clean-up incorrect indentation, extra spaces, long lines, and missing
> EOF newline in schema files. Most of the clean-ups are for list
> indentation which should always be 2 spaces more than the preceding
> keyword.
>=20
> Found with yamllint (which I plan to integrate into the checks).
>=20
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-clk@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-spi@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-remoteproc@vger.kernel.org
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> Cc: linux-input@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-mtd@lists.infradead.org
> Cc: netdev@vger.kernel.org
> Cc: linux-rtc@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

I trust you guys in figuring out the details, so for touching I2C:

Acked-by: Wolfram Sang <wsa@kernel.org>


--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl9EuWkACgkQFA3kzBSg
KbZbPA/+MqNMzGTVXT++2afD+v/Qkum1LRbeldro+e0ewQSps4tnW/eHg9RaemYr
BwxfsOZA+EJp0lGOnRM5/vhPMoInlSEwJSBlxtjratUScfPiR7D4ljKXGaUQv4IV
l9cXBZuOeLnSerxdYsuGrs8M0uqe4rAc3jt/FGD4rSgawNTN1HieFaQ0vq/0I5Gi
pyJv09alaosBuqNYc37Gqm9Ddk6xEJb8lvwrVqeS2ZGMFmfJuFlsuLKhwdgen/og
Wik6VZEjyUHJbyZgkcwMn6rTVTnopK7E0RYmdap35Bh6MAZ3auQ4eQU2tktY3L0G
+NL/ah9FAvmPH1RAR7KmXzZxVYX2ZoWm3AJVpCIvlc9toZI5NdOwdruT+KlTLHIY
T0vs7B3wqsrD4pHputHdDtf9iSZDB0FiTi44yJjReI72Yb47gDXXK7tOcewvq33Y
J9dv/HeT85ER8dZ3fCssLdOsIVSE5ZGaDGjP9M4hPo5ZqM5WlMcqW13gmBsEaY3W
quFFx4pgOXFmnO+7fCb0OIoySeTtgCMNqSwekaNsrbK8dBsFhMx62IzUwwCwL8ST
clLrMsK81BA4v5hiU1SXC5zAJJG1W0FEpGvIuQRa5YxW8goqwIJrEuvy8jWLhg1x
kB4BNFdQdBMg8xw0GSHGDhOZhIxgC5t/fvrbiLmqazzmbfCE1i8=
=71f2
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
