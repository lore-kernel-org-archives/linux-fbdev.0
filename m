From: Felipe Balbi <balbi@kernel.org>
Date: Fri, 01 Feb 2019 13:20:35 +0000
Subject: Re: [PATCH 13/18] fotg210-udc: pass struct device to DMA API functions
Message-Id: <87a7jfodb0.fsf@linux.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190201084801.10983-1-hch@lst.de> <20190201084801.10983-14-hch@lst.de>
In-Reply-To: <20190201084801.10983-14-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>, John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: iommu@lists.linux-foundation.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@lst.de> writes:

> The DMA API generally relies on a struct device to work properly, and
> only barely works without one for legacy reasons.  Pass the easily
> available struct device from the platform_device to remedy this.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

In case you're taking the entire series:

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxUR6MACgkQzL64meEa
mQZcdw/+IrXhj2e5ZoNBjEAFCIYS3Ad0nXXzb9LocZ8HVA2Ill1N+x0u9dTCQj2A
d08tzuiwdLv0QP2YIpl9AVm+bmb0Fknee+ENoqjKhjbArhv1M2QY2XTdV3QZT1IN
CDY3zD0IN4mHHg+4rYyOHVXLu/vX2Yoh8vL9LFHJevlUcgPE0HPiwBsP0cNocYxv
5u+mdcIgNG5M352Yau0cZ+q5QKi0kycwKWdZsJL3X0cqAK8iS1IMwWGd1/hf6KnB
UrCRw/+NbCrv0SapHXrw+wJN3l/F/5HMTdh19pqq5yO1pRJOu2fcsv+/CKgyzYkT
lRsvuN0FUHj/7sMBK3f8BnKU0hQhyejVKQr0rbZ60rQfO/Dram9SVRFk97B/81xM
iwcMQhBD5Aw1gryOuoQx26knqH59lIjq0G7tf0j8xsQJZy2WqXJSrx6nBJRXsCzn
8qqdOKpK4uCkOrLCe+7yuYHaIicput48fxOjdtgnSFpKqlRNXEnMXYKGFrYmodFu
KVRdLd/muq/dGAfKgLwzCYVlHNvcsAs+Q2vpJ4IQuG9AYG5RDr9z3X4oQbFJccUd
YM7+vhctcxYzE+WqO96dq+mVcGl8hyidqRgpZ6BNDl34FO3W3ZrZNFQvwEkz0cfX
RfAUjYGlYlkDLcCpu3WrzurP1ByBfL8HfMMpqW/of9Z+nOb9rLQ=
=fqaM
-----END PGP SIGNATURE-----
--=-=-=--
