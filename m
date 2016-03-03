From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 03 Mar 2016 11:40:22 +0000
Subject: Re: [PATCH] video: fbdev: sis: remove unused variable
Message-Id: <56D822A6.9040601@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wDKbi4LxPKGtobOXUccbgG0hXvjBXN0SN"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1456768949-27318-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1456768949-27318-1-git-send-email-sudipm.mukherjee@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Thomas Winischhofer <thomas@winischhofer.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

--wDKbi4LxPKGtobOXUccbgG0hXvjBXN0SN
Content-Type: multipart/mixed; boundary="rJLVWST2HVSsbRpls1BfiwGwWOQsWQC9d"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Thomas Winischhofer <thomas@winischhofer.net>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Message-ID: <56D822A6.9040601@ti.com>
Subject: Re: [PATCH] video: fbdev: sis: remove unused variable
References: <1456768949-27318-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1456768949-27318-1-git-send-email-sudipm.mukherjee@gmail.com>

--rJLVWST2HVSsbRpls1BfiwGwWOQsWQC9d
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29/02/16 20:02, Sudip Mukherjee wrote:
> The variables modeflag and resinfo were only assigned some value but
> were never used.
>=20
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>  drivers/video/fbdev/sis/init301.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Thanks, queued for 4.6.

 Tomi


--rJLVWST2HVSsbRpls1BfiwGwWOQsWQC9d--

--wDKbi4LxPKGtobOXUccbgG0hXvjBXN0SN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW2CKmAAoJEPo9qoy8lh71qcQQAIfTvccSfP17yu8H+8wuangw
ty62WqjhuqUZ50pKTwFpr2gbmJr9Mp8hR0aESp6msUfilF3oPo4OEDI1jCKXsrz/
dQQvKvjdfGNAsJUXXd/LeQNy0WqAL8jEiLscGyfljmoJUG/CzxrkGBlggvjiTSCL
BsN8KjeG9JfYrwLkB1gJGqp13coithMttwyIrrPolzMAQ6nhJYCNGrdXahwJwcqf
pJBaP2pw0CWTbJeT5DutlWO8wewLCaJY1n9g8xACuy8aDGup9zaIYxo5E098W46T
otWXSGmzD/zYYzSabXnlRD/okYJRZefnR6y/+gvPzfEhmWdIx76BB8pI+ikN9ZMZ
SCzvBFVhIK77nom5YpKCtMflFzElR1+R3CpWK5dKw9lnJfV//LLFj6jmhmarvnqE
mdrtEFrsftGuuCKzsN6ngvaocKyCpgqBnNJQ7MLuyOVBMgfAfgcmmOmLxCjG38zP
Zs8U3QihA+EltFB4BGaE7Moh+gIP9kCGezRyymEIG39r/4k2wmr9lCl6ByaaV+Mh
wOdBR9QyXN6ENz1H6uQyll7MoFLwaConhXKyyxUP1/Tdxna/joqFL6GJPSGerJ17
UAH14sNynsa25GNme3HTHKjNMts7ahuzOEywoWSGeugobbPxeGZXp2edzhX4Yrdl
QOtUFmBQZ6JC53Dq+7Oh
=QEYx
-----END PGP SIGNATURE-----

--wDKbi4LxPKGtobOXUccbgG0hXvjBXN0SN--
