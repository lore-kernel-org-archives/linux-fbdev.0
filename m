From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 17 Dec 2013 07:37:35 +0000
Subject: Re: [PATCH 0/4] OMAPDSS: DT support for N900 panel
Message-Id: <52AFFF3F.7020807@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="cPvjumn88P4BSuaTdf5t7fRvvCQLTusJB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386958650-2404-1-git-send-email-sre@debian.org>
In-Reply-To: <1386958650-2404-1-git-send-email-sre@debian.org>
To: Sebastian Reichel <sre@debian.org>
Cc: Sebastian Reichel <sre@ring0.de>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

--cPvjumn88P4BSuaTdf5t7fRvvCQLTusJB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 2013-12-13 20:17, Sebastian Reichel wrote:
> Hi,
>=20
> This patchset adds DT support for the N900 panel. The patchset is based=
 on
> Tomi's work/dss-dt-2 branch [0]. I suggest to send the DT changes throu=
gh
> Benoits queue, since I have more N900 DT changes for 3.14. Also the pat=
ch
> editing the rx51 boardcode can be dropped, since the file is removed in=
 3.14.
> I included those two with this patchset, since they are needed to test =
the
> other two patches.
>=20
> I did not include a documentation for the DT API, since the omapdss
> documentation is still missing.
>=20
> I have successfully tested this on the N900.
>=20
> [0] https://git.kernel.org/cgit/linux/kernel/git/tomba/linux.git/log/?h=
=3Dwork/dss-dt-2

I added N900 display DT support on top of my v2 series, including
pinmuxing. Can you check if it looks right and works?

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss-dt=


 Tomi



--cPvjumn88P4BSuaTdf5t7fRvvCQLTusJB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSr/8/AAoJEPo9qoy8lh71kXgP/jN78DPvtXCN38e2AwGJjbRm
8oDmodWlC8iGqb63om4UmugzQuPR6JzR2DIfSzTljbQn17zsIg21dztqP9xOmoF4
dpndTSrL22yT7bRHjijWNiX79LyvDARKim8vRrzsKyxi2K2St9bLi8NPZF7gD9nZ
hagtEDJAmpMRzbyKpibY62lfbJVALK9ZSIIXMgw+wjI4oJBAPBIorg7ak2UYNZDO
QBHeRLuIXXXTbqvwFGNr1P3FQ305lmbcCKJpsPGCXwCXMPSD2kOLHqbhzdDqnQZt
1+0nQx5sOcunXBYCzMXWt6SIiwJ/aAuTY4S8FSzZCzjVbgdLFCTx+5LSwwqUFcHi
Oz9qSR4THgtSC1JRmSofqgF8Cpg5BT8qkXdCgKyjKC5tEzPxrSbe5cU4XZUC4ECY
ild32Lqw0YPVGDy4HhNJCao7t4RlYjPBBPpxRvYBklODuxQz6XOcvVDoyj/3vnr+
PwP3q474O+dbyyNPqFMb9QhYv589r4Do4TWgobepCMPBsPqDLgooi9u+w2/4yQCC
vs1xd6MO0mOMON0bkx9kElvZxEStT+1Hq6VO6mPTV55niUxlRGSFlfmtaKGuKGLL
APYkWpYWJOqMDywlNJQKiKh58zsOMaoaltFh3pCOjLxlRCI9nC2iB/GBCxVHFqoL
1y/itl5K+/0FlbDmmPlR
=hjfG
-----END PGP SIGNATURE-----

--cPvjumn88P4BSuaTdf5t7fRvvCQLTusJB--
