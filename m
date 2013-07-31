From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 31 Jul 2013 10:04:33 +0000
Subject: Re: [PATCH v2 00/24] video/da8xx-fb fbdev driver enhance to support TI am335x SoC
Message-Id: <51F8E131.5000803@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Fr8ot7VXhJA9fudcCN9XuDdMfHxL4ISAi"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375208791-15781-1-git-send-email-detheridge@ti.com>
In-Reply-To: <1375208791-15781-1-git-send-email-detheridge@ti.com>
To: linux-fbdev@vger.kernel.org

--Fr8ot7VXhJA9fudcCN9XuDdMfHxL4ISAi
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 30/07/13 21:26, Darren Etheridge wrote:
> Changes in v2:
> Addressing review comments from Tomi Valkeinen:
> 	Dropped readl/writel patch
> 	Many cosmetic changes to make code easier to understand
>=20
>=20
> This is primarily a resend of a series of patches that were original
> submitted to linux-fbdev back in January of 2013 for 3.8 by Afzal
> Mohammed. I have rebased them on 3.10 and also made sure they
> apply cleanly to the 'for-next' branch of linux-fbdev git.
> The patches enable use of the current mainline da8xx-fb driver on the
> TI AM335x SOC along with some bug fixes and cleanup.
>=20
> The original patch series can be found here:
> https://patchwork.kernel.org/project/linux-fbdev/list/?submitter=3D3910=
1
> if you want to see the history.

Comments on the whole series:

Most of the patches are originally from Afzal. I believe some of the
patches are unchanged, but some are changed by you. In cases like this
you should pick one of the following options for each patch:

- If the patch is unchanged, send the patch as it is, having From: Afzal
line there.

- If you have changed the patch, send the patch having From: Afzal line,
but marking in the description that you've changed it (and what you
did). This should be done if the changes are small.

- If you changed a lot in the patch, send the patch with yourself as the
author, signed off by only you, but mention that it's based on Afzal's wo=
rk.

The point here is that if you change the patch, it's no longer Afzal's
original patch. Afzal hasn't reviewed it, so signed-off-by Afzal is not
correct. You could've introduced horrible bugs in the patch, and I'm
sure Afzal doesn't want to see that a patch in the kernel introducing
horrible bugs is from him (when it is not from him).

Of course, if you have actively discussed the patches with Afzal, and
he's okay with all the changes you've made, then the patches are fine.

Another thing are the DT related patches. They should be sent to
devicetree@vger.kernel.org for review. And I think the DT patches should
be squashed into one, as they are quite short and having them as a whole
makes it easier to look at them. You could probably move the DT patches
to a separate series, so that we can merge the rest of the improvements,
and manage DT separately.

 Tomi



--Fr8ot7VXhJA9fudcCN9XuDdMfHxL4ISAi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR+OExAAoJEPo9qoy8lh71eMUQAJeJRKDhOXbRWahdcWOiVM4D
2l3MbK9UQhSVBFF/e/yoVTpmrpTZTTS7Xc47pmrHfywFVmO2ztEbsSLXV6mHWSXB
AKbN8xSSMOy8sX/pqvm3YrkqHoKamQrtsL81f6i/p1a2tcBYbQijf8kxVejyR+cs
ZH0zE8ataELzjqx1moG2P/a9oDMbrBmNYFWYpGMFLb0LvtOH2iVgYqI1ju1M2qb3
Lh28byWSLqFsx7NA5yEGcJH9ShPRo4OPdoI/qSZdoj1zSo7nQuXS5xC6m/J1SQK5
f7+hOW2DpuGCOUnaM2/A1ebkU+AEkqGPtJEXwzo+sztXT99PESm/4tympm7t9V/V
/tNDu9Z5p/GmC+GysDZuJVn9dVUiV8WtBvcDyibLc4NhX8NUTEsAJYeKqBtWn9Uf
EqYA2UV6VKalxVusVBV7OXwl5Gop0lzSAk9T5ziB8t2gAGNrtiA89WUDSAsj6Zz0
8LpU54ifREZElJlq/01xUl/1VGPPLp8+NYS6xfmFhD8XZGt2Qs2nlRb/EwxxGHww
+tQ5r+TKxdOv9mlTgPgExc1fZgR4rvP8cZRggwsxT0boWWFMurtA08qja3m6b+v0
OOCPRiBHnMjwFl87E/vQQLA/Ijc0SFHT/mSArYDS4sZiwUGxEVGFM3dnuKqYTBym
qPvES+0SX+UHFxryav1V
=BkCg
-----END PGP SIGNATURE-----

--Fr8ot7VXhJA9fudcCN9XuDdMfHxL4ISAi--
