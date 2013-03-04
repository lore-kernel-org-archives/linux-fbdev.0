From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Mon, 04 Mar 2013 09:15:40 +0000
Subject: Re: [PATCH 1/1] video: exynos_mipi_dsi: Convert to devm_ioremap_resource()
Message-Id: <20130304091540.GH13335@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ZPDwMsyfds7q4mrK"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362386440-17078-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1362386440-17078-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org


--ZPDwMsyfds7q4mrK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2013 at 02:10:40PM +0530, Sachin Kamat wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.
>=20
> devm_ioremap_resource() provides its own error messages; so all explicit
> error messages can be removed from the failure code paths.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Donghwa Lee <dh09.lee@samsung.com>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> ---
>  drivers/video/exynos/exynos_mipi_dsi.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>

--ZPDwMsyfds7q4mrK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRNGY8AAoJEN0jrNd/PrOhkDQP/RkiIofv/f39OZvzRnKmIPZF
PZBW31KqnQnLvevpRcvZRzXuWCzTTPH/iGN2bZX0ZFq/rLClJ3Bw7bSuoRYqe8wt
cH1/rd9jUimFmx7sVAx3gVpzRvvByO00Xu8+N8PeyieOaHFh8wjccGOBLy7aWFg8
U7BaXG+p4tvZ7JrsdnptvZ8YCh7ymxGOXFITwogEX7TleiJJEnL8QKjf1dy8llZg
INXUPbTnWMcuP2JOfRXG2rVtT4mJikMxWUKA0x2cmFSAIL1n/P7rRHKsZtb+Z5Op
BBkUjhogHsw7nfOpZng8n011ZL0i/GDZSxls31ABH2J+rD09K7Q5DjQTxW5VzTpZ
m2VfDvGuKepwh3kD5G1DPR0iV0i3sSBDT9VhLaFBNvrKcwcZ/nKTRAVFYb6wYQAs
t4xHdXlmanciqALBMGtgGNufh14krJbO0jOk8DkjGj4Q5nz4w8j+xszmft5deMwW
iqnGHyh+GOyBpCWngB4UPW8h2/5cP29q4dpGCkP1IMtLwR6QMu/Ws/uiJWf5KuzR
ugUO6OcQHqKG1tUOq+8iZ3570WvILa9VGUHlla2BF+DDr/QTUpRVUY+A57KmzAYJ
5pXdQB/0br2pLYJ4hmBiqEytsguGKLFDZR6+ZsiuO5NoYkDh/tYgpNv5Bj6ujy2s
9I3x0RVgGdQy3yfTibdE
=i0ZU
-----END PGP SIGNATURE-----

--ZPDwMsyfds7q4mrK--
