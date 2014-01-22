From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 22 Jan 2014 08:41:55 +0000
Subject: Re: [PATCHv3 00/41] OMAPDSS: DT support v3
Message-Id: <52DF8453.7030501@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AgHv0g4DX2lgITqGmPg4bxLV8kbJCdjuG"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
 <52DEE6B0.20106@ti.com>
In-Reply-To: <52DEE6B0.20106@ti.com>
To: linux-arm-kernel@lists.infradead.org

--AgHv0g4DX2lgITqGmPg4bxLV8kbJCdjuG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2014-01-21 23:29, Nishanth Menon wrote:
> Tomi,
>=20
> On 01/21/2014 04:56 AM, Tomi Valkeinen wrote:
>> Hi,
>>
>> Here's version 3 of the DSS DT series.
>>
>> The previous version can be found from:
>>
>> v1: http://permalink.gmane.org/gmane.linux.ports.arm.omap/108249
>> v2: http://permalink.gmane.org/gmane.linux.ports.arm.omap/108866
>>
>> The main changes to v2 are:
>>
>> - DT Binding documentation
>> - OMAP2 DSS support
>> - Split DSI register space
>> - DSS nodes disabled by default
>> - Hack to have generic DT bindings but OMAP specific drivers (for now)=

>>
>> This series can also be found from:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss=
-dt-review-3
>>
> http://slexy.org/view/s20JhteOFR is my quick build test report -> few
> checkpatch and build bisect issues would probably need fixing.

Thanks. Shouldn't make trivial changes, and then not run a full
commit-by-commit compile test...

I fixed the issues and pushed the branch again to work/dss-dt-review-3.
The fixes are minor, so the already posted series can be reviewed.

 Tomi



--AgHv0g4DX2lgITqGmPg4bxLV8kbJCdjuG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS34RXAAoJEPo9qoy8lh71JzkQAILQOThMuQQ7go86pEzYDWlj
wDpXsf1FaJL9WcUqRsSihV3jNGvs7bcXEuOf22mwqIw45uZqSbwixElA9Uac9L4S
f97a6Qx+iJJF1cbpgrsSSfvGk1RKLFARHwZwSouBO1hVaitT/+QHKFwLK6mi3Kqi
5yU0B4kADFVkcWXrKPu+SyDbC9br2+I1iMN2jzFZLCfEXiI8YPPISD8HqRBA+fbp
voA5Yx1uMqqlKHIvcdjdK8tVKxogmHI5uPTV7oqE30F6ldGww8aWO/P2iqI5LG+I
euy1acy0gLJ8wSn8APyKS9+rfihIgXX0vtWThWqdmeyP42YTgUog+WqE6A0h6EAK
Lf9dubne7x0g36FhjMuccqoko+bLg7kqM/TBnq44SBZ2bRlFhYOHnIOcWj6ZXm0J
C7hg+BPPb+r5EU47ngEqC3NX73nXe6dZjrCdCYUTcEh9et2U7hhJSDzIvQJ84wG4
TQyVmq7dX+UDLPStgjHrNPc85NwyCS+o0NL2yBkCfYBF69vGTIM05+wJvej+sZh+
2l7PJaLaQhE0yLk/tqaa1c6gqOaYlWi2U6Lfhq9AjjuXHL9RhlUcdHW+B268lZYL
r97A3zj2g8+E2pWRB3Q0/paEy87Nc+SuOxSGBbGxOAvaNck4Rpe5FHu4BRo6ircN
OdqA85sK41AezbOLOQXK
=QuRv
-----END PGP SIGNATURE-----

--AgHv0g4DX2lgITqGmPg4bxLV8kbJCdjuG--
