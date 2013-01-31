From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Thu, 31 Jan 2013 12:58:46 +0000
Subject: Re: [PATCH 2/4] pwm_backlight: Validate dft_brightness in main probe function
Message-Id: <20130131125846.GA11205@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358861996-27194-1-git-send-email-peter.ujfalusi@ti.com>
 <1358861996-27194-3-git-send-email-peter.ujfalusi@ti.com>
 <510A65BA.6090208@ti.com>
In-Reply-To: <510A65BA.6090208@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Andrew Morton <akpm@linux-foundation.org>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2013 at 01:38:18PM +0100, Peter Ujfalusi wrote:
> Hi Thierry,
>=20
> On 01/22/2013 02:39 PM, Peter Ujfalusi wrote:
> > Move the dft_brightness validity check from the DT parsing function to =
the
> > main probe. In this way we can validate it in case we are booting with =
or
> > without DT.
>=20
> Based on the discussion the rest of the series is going to be dropped, but
> what about this single patch?
> I think it is still addresses a valid issue, which is that in non DT boot=
 we
> do not check if the dft_brightness is within valid range.
>=20
> I can resend this patch alone since it is not going to apply on mainline =
as it is.

No that's okay. I've gone ahead and applied in manually.

Thanks,
Thierry

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRCmqGAAoJEN0jrNd/PrOhILEQALojqlnX8GbLmpn2xiCRyvD4
q3arHtnnNxqhJqXDNemH6rV/6ZjVhSzKR5ACsE3TSkJpv0dWZY3/y3kEyc8A2zQC
+VoaktoGDEi82c/fDMJxhfEKps0IDH4qWPwcXStBhQIpWr1LivZ3DJEtlfUfMrUD
JcbmmOzuoqe7a5orHJC8HiqC4MeNax6Q6V3pGjPRwqdJHAqz5pmZeVusFsaaLIjf
MkJXwmNmMTx5DesUk4mRJknMBH/hQYwqoFP/fngcCV5REeZHGgcT6ZEQ2JG7pmCq
7K1tReEFDMSC6WDZIKPJkBvCQy4ED0P8pDkshl8WC3IOms4RQxY7KW7OF9Vr4IVu
w+Qcz99ay4v5jr97yQZZoKwOODIh0h4QbIMu8yWOhPrwTxZOkfVdjI3kei1GRg7i
DabKKVfebmAzWksmE1lRv5wwZjNV17V/VQNNnZsJQ+OSct/oW5IvRl0bkCKUzyW9
sdcR80oXnsf7cUl+9/yIwxu9edo4v4A16Bz7UoZjvAJQIKTk6rjs1xgKCSo2/Uj1
aRxtB3OIQX41fYkRFDRVwIOzT1MFL550xQRnE478PrRkEwJZR2gvQmRMXzqnI6Zw
hQ1rHH6BlVQyPB4fBfXkiidOQLZM/ndGaN9y384m83xqjcvlMeHks3bDLIm3lVzl
f4uG/08NTFpTa4n3Ru1K
=iaGg
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
