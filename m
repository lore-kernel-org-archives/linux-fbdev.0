From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 17 Jan 2014 09:03:09 +0000
Subject: Re: [PATCH 1/2] video: exynos: Remove OF dependency for Exynos DP
Message-Id: <52D8F1CD.6010503@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="K3D8JrMdLwKVRV4T9ubIWFnsFvQC0fkUl"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org

--K3D8JrMdLwKVRV4T9ubIWFnsFvQC0fkUl
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2014-01-17 06:32, Sachin Kamat wrote:
> Exynos is now a DT only platform. Hence there is no need
> for an explicit OF dependency. Remove it.

Is Exynos a DT-only platform in v3.13? Or only in v3.14?

 Tomi



--K3D8JrMdLwKVRV4T9ubIWFnsFvQC0fkUl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS2PHNAAoJEPo9qoy8lh71VC0P+QEK+SU2OD7H0hzJJxWTj2VJ
qQmpNGNfI0ucJ6rrxlH27ypyxaw9NvLHUaCke7sqWpU05za9hISDr2ewv7bQPV2F
wKmU1ITEQARRJKZ4nyisq80qmR/GefyJHRJ4WPjJe4zv7m11YyNH9nxRLB+00Cho
fTj2gO+0W6+qANVh6VtiXAA907ZUMly58NRGoFP5yCaMSWdmBEaLq61Bp6na0049
igOQ/CA61Nf0BppefCYs4MaWA0T9EseZMupB5KzkyxAfwgr6T/Np7Q8wPFS8Svkc
PfgUvF+Z0Zf5SQCDaG1Ue6dE2ZssajhelupoDbQXR7nrZcFt4B1bfvugO+0K+DR3
mOLXY/vnYlgIbLAyT4MhEgWbwFhF5otFmDqmghmfiykC1rLyqB7dGPOMwH77CdgU
p1z0k9Iq8MyaM6g1NIO4dVbQSmVc5E4Jql/c1jziFSMipksKvOwL0vuWew/sX/JO
MejYsWbns88Zkqvb3/OgveSVUmGM450brr35SylabGP0bv8JnZEwTtykNkk0sZhx
EufWpUqXGZwCi8xH1Cc2/1V+1YyTx+oQQww7Or4iaAJ1At9qgqoADvc0yZDvwhIx
v2HAyXJIJ6OpMoE2DxS6jIQqas/qpajh1MAV9vF8gs/w+/YFyzeWxj6wmp1Qn3/Z
B7gAQCzpE/E/zAJV87pH
=AE8G
-----END PGP SIGNATURE-----

--K3D8JrMdLwKVRV4T9ubIWFnsFvQC0fkUl--
