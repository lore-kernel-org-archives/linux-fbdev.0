From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 12 Feb 2014 07:25:53 +0000
Subject: Re: [PATCH 1/2] video: exynos: Remove OF dependency for Exynos DP
Message-Id: <52FB2201.7010407@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="qdqgQb59gW2PWTNTFUeIFCco2eXQEQ5M3"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org

--qdqgQb59gW2PWTNTFUeIFCco2eXQEQ5M3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/02/14 09:08, Sachin Kamat wrote:
> On 11 February 2014 19:57, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote=
:
>> On 11/02/14 14:01, Sachin Kamat wrote:
>>> On 10 February 2014 17:48, Tomi Valkeinen <tomi.valkeinen@ti.com> wro=
te:
>>>> On 17/01/14 06:32, Sachin Kamat wrote:
>>>>> Exynos is now a DT only platform. Hence there is no need
>>>>> for an explicit OF dependency. Remove it.
>>>>
>>>> But the driver still depends on OF, doesn't it? I don't think it's v=
ery
>>>> good for the driver Kconfig to make presumptions about what ARCH_*
>>>> depend on.
>>>
>>> Depending upon nested dependencies is redundant IMHO.
>>
>> Well, a driver should be independent of the underlying arch. In
>> practice, we have ARCH dependencies, as many of the devices only exist=

>> on that arch. But I think the drivers should still be designed to be
>> arch-independent, as far as possible (omapdss compiles fine on x86).
>>
>> If the driver depends on OF, it should depend on OF in the Kconfig, no=

>> matter if the arch also depends on OF.
>>
>> I don't really care if the EXYNOS_LCD_S6E8AX0 has OF dependency or not=
,
>> but to me this just looks unneeded cleanup, cluttering git logs, and i=
n
>> my opinion it's even going to the wrong direction.
>=20
> Your argument makes sense. Upon further experimentation I found that ev=
en the
> Exynos video drivers are ARCH independent (i.e., they build on x86 too)=
 and do
> not need to depend on OF for compilation. So I believe, we can remove b=
oth these
> dependencies. What is your opinion?

Indeed, the driver doesn't even seem to call any of_* funcs. Looking at
the commit f9b1e013f1c6723798b8f7f5b83297e2837aaef7 (video: exynos_dp:
remove non-DT support for Exynos Display Port), it kind of sounds to me
that the OF dependency was put there just to prevent non-DT use.

I'm fine with removing OF dependency, if the commit description is
updated to say that it can be removed as the driver doesn't actually
depend on OF at all.

As for the ARCH dependency, I think we should keep it. I once removed
ARCH_OMAP dependency from omapdss, but Linus wasn't impressed when his
kernel compilation started to ask him if he wants to enable OMAPDSS
this, OMAPDSS that =3D). So I think it's fine to keep ARCH dependencies i=
n
cases where the driver is clearly used only on some architecture.

However, you can use COMPILE_TEST kconfig option if you want to compile
test on other archs. I.e.:

depends on ARCH_EXYNOS || COMPILE_TEST

 Tomi



--qdqgQb59gW2PWTNTFUeIFCco2eXQEQ5M3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS+yIBAAoJEPo9qoy8lh71j/wP/1ltEWrejkxV1hJ/YO+/X9bf
HCniHhg5Bsp555kX+nkuiFCQPVNfABlB9Q7hCslllQVoWm9cuiZUDNeqmsVsviRb
wjOK6tSlsue517jImM9MkRac347/dK/2uzHkNgiEV/UIctim6W3tv3Wuv33QQJAQ
7TjjJQ5VTxpZqhuSZArRVZKZeHB9NIQAfuuSbMxpdZF7anMeNdmJsY1xrz2WvcVq
jfmKWshsNJCMzWAm0oGoNxYx9mCqtnOsWpQ1Z2eO9QFYE4ddSSV8P53ycZZLXy6r
NqiJBduquuSdHISFGdi59Rm0IE26a6GfkF/L3IrnwXeHLi4yaDc5EceKclaJzxX/
ioME/z1XJtLlNHuKsSOTZraVQhy8xGVwyHM/ol73ZdgNjTAc81o8YsXF4LzpiTnD
RrXWitLC/MJNmNKr03BGssB5UinsX4FcEUwp+jgE0Jfdj/1hHZodRQ2iu2RlfyOO
6UvFE7b0K35LFlSOApa3RoiZChS+puAZCACCYmXib4GB57g22xCPLZRdpNs8AQ3M
N2QWQn55z8sVt3oduqCscHWe1XtKX70Stbq2yXNrh+ziiejmE2q8wfr0gfPdsaeZ
d/ycotIG2EA3Vw+Jh05lLa9tC6hSxFuBB9AMJwTsLnvccbkjUCIMqsil9AbXQpzT
JSPlHpU5/Fca+/36xzn6
=Omb7
-----END PGP SIGNATURE-----

--qdqgQb59gW2PWTNTFUeIFCco2eXQEQ5M3--
