From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 20 Jul 2015 07:47:39 +0000
Subject: Re: [RFC PATCH 01/15] pwm: add the pwm_is_enabled() helper
Message-Id: <20150720074738.GB29614@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="z6Eq5LdranGa6ru8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-2-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1435738921-25027-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2015 at 10:21:47AM +0200, Boris Brezillon wrote:
> Some PWM drivers are testing the PWMF_ENABLED flag. Create an helper
> function to hide the logic behind enabled test.
> This will allow us to smoothly move from the current approach to an atomic
> PWM update approach.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/core.c            |  4 ++--
>  drivers/pwm/pwm-atmel-tcb.c   |  2 +-
>  drivers/pwm/pwm-atmel.c       |  6 +++---
>  drivers/pwm/pwm-bcm-kona.c    |  4 ++--
>  drivers/pwm/pwm-ep93xx.c      |  4 ++--
>  drivers/pwm/pwm-imx.c         |  2 +-
>  drivers/pwm/pwm-mxs.c         |  4 ++--
>  drivers/pwm/pwm-renesas-tpu.c |  2 +-
>  drivers/pwm/pwm-tegra.c       |  6 +++---
>  drivers/pwm/pwm-tiecap.c      | 10 +++++-----
>  drivers/pwm/pwm-tiehrpwm.c    |  6 +++---
>  drivers/pwm/sysfs.c           |  2 +-
>  include/linux/pwm.h           |  5 +++++
>  13 files changed, 31 insertions(+), 26 deletions(-)

Applied, thanks.

Thierry

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrKeaAAoJEN0jrNd/PrOhc14P/RiKITxyp073jXK27CmFIP5S
wMIn9P1/I7Hd1CWNgg0iTEwqYaFP7qAQ9zHpPrRHlk7Fg4xIGTMiLJpIyRaWAsDm
GUUsLUrKzW4LfNKAdVzOZzryD4PE+0Pkf3ULFgM9+tmBXgYjj9pjtaDnc6ExOkV3
FLF2uuyfhaA0cABsfq/dtvz2UEk/zRGCL/Bk2tEPpGo3g5j3YXkySt7YMJsULMoo
yoRKkPOpVagi8WMaPJEhcpPFiYuiupgkRXdO8M/R9+fykoQHVuUFuDybRO1J6OVt
ulwDh96zE3Jm9VTnrknN7c3YzlU3/5WxsDuH+PaOUqM7YgH827rC5JtQnhpia3SC
BQ/yQv8s9Ap8x1ZxUkbC0TVz/XBB98sEc4ki9K48PrluQBpyxN5NaIG7Dq4WwfFq
aO9FLY0nWjUaaJ6dj69LOn62Tg+V7DbCqOGsdNJ+82Hzh3cRYq5ir4+38/lCDFjy
u8BxoSz9uzWO4UVzo6eqmmecC1XPDo8EFL0Bk9RvIktYwdTmVjx31dvfNUgtJQ1Y
yjGZJvcotNYyaGBGpeDf01E4mefpJ2ckIcOM9ea+fCFiUGGLtES/nEb4oeCABRLg
Kr+w/QR4WufWcXpwdJZe5YMiYHByDhv3Y9EztzdH7QLa+HZ7q4ihLiZnOwIXo/t5
rNSktU4mCpj2FyzlfnjM
=FMP6
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
