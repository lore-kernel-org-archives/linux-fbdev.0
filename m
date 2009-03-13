From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [RFC] allow for PAL/SCART video timings
Date: Sat, 14 Mar 2009 00:15:00 +0100
Message-ID: <1236986100.4376.7.camel@mattotaupa.wohnung.familie-menzel.net>
References: <1236701836.4068.85.camel@mattotaupa.wohnung.familie-menzel.net>
	<20090311223542.bfa9d1a9.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5925251017042926822=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1LiGb8-0003bs-3R for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Mar 2009 23:15:26 +0000
Received: from b186.blue.fastwebserver.de ([62.141.42.186] helo=mail.gw90.de)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LiGat-0000vA-Ou
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Mar 2009 23:15:21 +0000
Received: from f053037133.adsl.alicedsl.de ([78.53.37.133]
	helo=[192.168.178.20])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1LiGap-0004x3-06 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Mar 2009 23:15:07 +0000
In-Reply-To: <20090311223542.bfa9d1a9.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net


--===============5925251017042926822==
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-7jcl95G/UhZ0nxN1nTDP"


--=-7jcl95G/UhZ0nxN1nTDP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Krzysztof,


thanks for your answer.

Am Mittwoch, den 11.03.2009, 22:35 +0100 schrieb Krzysztof Helt:
> On Tue, 10 Mar 2009 17:17:16 +0100
> Paul Menzel <paulepanter@users.sourceforge.net> wrote:

[=E2=80=A6]

> > After your response, we would clean up the patch and resubmit. I=E2=80=
=99m
> > afraid, I did not find clear instructions how to do it. The DRI website
> > [3] mostly still talks about CVS. Is this message from Dave [4] the up
> > to date one?
> >=20
> > What repository should I use for cloning drm-intel [5] or drm-2.6 from
> > Dave?
> >=20
>=20
> I think that the linux-next tree is the best repository to base patches o=
n.
> The drm patches are not directly related to the fbdev layer (I can be=20
> wrong for the intel driver, though)

I created a repository [1] based on linux-next and pushed the (old)
patches there before I start cleaning up. We will report back.


Thanks,

Paul


[1] http://git.hellersdorfer-jugendchor.de/?p=3Dlinux-next.git;a=3Dsummary

--=-7jcl95G/UhZ0nxN1nTDP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkm66PQACgkQPX1aK2wOHViExgCfSDQ8pfxDZxkFdzQNW4p474FB
5HAAn3gJem5PqBaPOn8gv9ivxFkgl456
=QPVY
-----END PGP SIGNATURE-----

--=-7jcl95G/UhZ0nxN1nTDP--



--===============5925251017042926822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
--===============5925251017042926822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============5925251017042926822==--
