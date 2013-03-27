From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 27 Mar 2013 10:15:44 +0000
Subject: Re: [RFC 00/14] Add DT support to OMAPDSS
Message-Id: <5152C6D0.2010708@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enigA7353AD93A217F0EB80285DA"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
 <5152BC4A.1060804@ti.com>
In-Reply-To: <5152BC4A.1060804@ti.com>
To: linux-arm-kernel@lists.infradead.org

--------------enigA7353AD93A217F0EB80285DA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-27 11:30, Benoit Cousson wrote:
> Hi Tomi,
>=20
> On 03/27/2013 09:45 AM, Tomi Valkeinen wrote:
>> Hi,
>>
>> This is an RFC for OMAPDSS DT support. I've only added support for a f=
ew boards
>> and a few DSS outputs, but they should give quite a good range of diff=
erent use
>> cases. If these work well, I think the rest of the outputs and panels =
will be
>> ok too.
>>
>> The purpose of this series is to get comments about the dts changes. T=
here are
>> still work to be done, like adding DT binding documentation.
>>
>> Some notes:
>>
>> * DSS Submodules
>>
>> The DSS submodules are children of the dss_core node. This is done bec=
ause the
>> submodules require the dss_core to be alive and initialized to work, e=
ven if
>> the submodules are not really behind dss_core. Having the submodules a=
s
>> children will make runtime PM automatically handle the dependency to d=
ss_core.
>> I think usually a node being a child means that it's on the parent's b=
us, which
>> is not the case here. I'm not sure if that's an issue or not.
>=20
> FWIW, there is a L4_DSS interconnect. It is used internally to connect
> all the submodules to the DSS L3 port. So this representation is
> perfectly valid and does represent accurately the HW.

Ah, yes, I can see it mentioned in the OMAP4430 Block Diagram figure in
the TRM. No other mentions, though, I guess it's not really relevant =3D)=
=2E
But good to know that the DT representation is actually correct.

 Tomi



--------------enigA7353AD93A217F0EB80285DA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRUsbQAAoJEPo9qoy8lh71KVQP/1+gKSZ5FHtMU2av75dBQtL6
VDKZS29G6mpq3XGBxdsVaqiyi3CwWq530yT77INrz2igZZ0YukKJ6MAE5gn+gSJ8
F7rVkbaEAIxAM2BXY25nNM9qItwZCUuBKTP27nQM769yPeaNEpTuLmS0yqSbjpJh
ymjiAyQFCpPyluPhBNaAzHWm5WlVE5RGS1e6AZ0Yrfo+77K3l8X6/voKZfWl0+Gf
oQpjB/Sr2+hjgK2Bfr8SLZkSSJC8Yp59g3aqSGHpZvDUsOsqs91QZcciuuOKXHww
sPbypbE8SB/L8ZtsvhGSandmZi2iAlHfXFVC43fy8TdNzQvn2qfZ48rnX7VSy4sP
OcEs2ZjuA+bp8nGCTSXKHkMg5rSK+T2eQeqxXUm0q7seRKKKdjwxGOKJNw4+r56l
c4Yh2XhqfSPBac0MGpHOn4ob/4IYY4pTvl9tZjUHdm8MP3/WoHpIQkIxcg/Duvfl
nyQRv2P92OFwn0nd7bcVMURdt3sxDB7LiJ5jf6/8rjmokbTpfib0EOTcb5RZiT1r
iS3gsIFwv83T+5s8gaKdRsupFyqUGB+QAF47mHGJLK62ZQ4G4dlRwwWO/XiPXQ7o
MQPWWYsN4cMgez/YT84QSd3+lalDdEMKLBD7ArRRD9XqozLV3ci9xToSO282bb9O
ANsmUxDQIPYrQmhVjWuG
=dvEw
-----END PGP SIGNATURE-----

--------------enigA7353AD93A217F0EB80285DA--
