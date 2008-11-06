From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: Epson S1D13A04 video driver
Date: Thu, 6 Nov 2008 21:43:43 +0100
Message-ID: <20081106214343.e36eb441.kristoffer.ericson@gmail.com>
References: <0AF7234EE71C18419A2CFFFB8EF9C17CD431C1@cine2k1.cs.myharris.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2799116245490097849=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kristoffer.ericson@gmail.com>) id 1KyAln-0006aK-B8
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Nov 2008 19:43:55 +0000
Received: from ug-out-1314.google.com ([66.249.92.169])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KyAli-0000i3-BX for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Nov 2008 19:43:55 +0000
Received: by ug-out-1314.google.com with SMTP id 36so1101314uga.17
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 06 Nov 2008 11:43:48 -0800 (PST)
In-Reply-To: <0AF7234EE71C18419A2CFFFB8EF9C17CD431C1@cine2k1.cs.myharris.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Kimble, James" <jkimble@harris.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

--===============2799116245490097849==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__6_Nov_2008_21_43_43_+0100_+WkQ5IISo2oVM01W"

--Signature=_Thu__6_Nov_2008_21_43_43_+0100_+WkQ5IISo2oVM01W
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Nov 2008 07:40:43 -0500
"Kimble, James" <jkimble@harris.com> wrote:

>=20
> I'm working on project that needs to utilize the Epson S1D13A04 device
> on a Coldfire processor based system running the Linux 2.6.25 kernel.
> The driver I see in the kernel sources had the name of Thibaut Varene in
> it and he told me you are the current maintainer of this driver.

I took maintainership as of 2.6.27. I've CC'ed linux-fb since thats the
relevant mailinglist.

>=20
> The driver in the 2.6.25 kernel supports the s1d13xxx series of chips
> but there's a good deal of variation in this series (register
> assignments and sizes, memory size, etc.). Can you tell me if there is a
> driver more specific to my chip (the S1D13A04)? I've begun the process
> of porting the existing driver to work with my chip but it's a pain. I'm
> really trying to save myself some time.

Without looking at datasheets of your platform I would say that
you would be best of sticking with the s1d13xxx driver. The reason for
me taking maintainership is that there have been very little progress in
the driver for the last year and it's in need of updates. The goal
is to make it a truly 13xxx driver.

So far I've started to familiarize myself with the driver and also
added some revision detection (it was locked to one revision).=20

If there is something obvious lacking in the resources supplied
to the driver thats where I would start. Can you give some more specific
details on what you need?

Best wishes
Kristoffer

>=20
> Any help or documentation you can offer would be greatly appreciated.

By documentation you mean? If you are looking for examples using the
driver you can check jornada720.c. It should give a clear picture
of howto supply the driver with framebuffer, memory areas and also
some register initial values.

>=20
> Thanks,
>=20
> James Kimble
>=20
>=20
>=20


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Thu__6_Nov_2008_21_43_43_+0100_+WkQ5IISo2oVM01W
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkTVv8ACgkQPQls10ERAGfpOwCg45nitqottRwpeLllDePZLVFa
VpkAoLz/Ki3WCCsHVmItg0hMvpMf2iy0
=6eJy
-----END PGP SIGNATURE-----

--Signature=_Thu__6_Nov_2008_21_43_43_+0100_+WkQ5IISo2oVM01W--


--===============2799116245490097849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============2799116245490097849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============2799116245490097849==--
