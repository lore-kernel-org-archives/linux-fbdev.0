From: Arnaud FONTAINE <arnaud.fontaine@free.fr>
Subject: atyfb correction for 3D Rage Mobility L
Date: Wed, 21 Apr 2004 16:15:22 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <408681FA.50607@free.fr>
References: <E1BGIKG-0004pq-Dv@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig806206AC3DBA722877302E3F"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGIZR-0008AD-Lf
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 07:19:25 -0700
Received: from hourri.hittite.isp.9tel.net ([62.62.156.10])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BGIZR-0005p1-9M
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 07:19:25 -0700
Received: from localhost (unknown [81.185.254.103])
	by hourri.hittite.isp.9tel.net (Postfix) with ESMTP id BBC441576E7
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 21 Apr 2004 16:46:04 +0200 (CEST)
Received: from [192.168.1.3] (helo=free.fr)
	by localhost with esmtp 
	(Cipher TLSv1:RC4-MD5:128) (Exim 3.35 #1 (Debian))
	id 1BGIeS-0001YN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 21 Apr 2004 16:24:36 +0200
In-Reply-To: <E1BGIKG-0004pq-Dv@sc8-sf-list1.sourceforge.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig806206AC3DBA722877302E3F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,
I'm running a Debian sarge on an iBook SE with a 2.6.5 kernel.
My iBook contains a "3D Rage Mobility L" and I've had some troubles with
the atyfb: my screen was turning blank.

I've modified the MCLCK and XCLCK of the "3D Rage Mobility L" in
drivers/video/aty/atyfb_base.c :

# old version
	{ 0x4c4e, 0x4c4e, 0x00, 0x00, m64n_mob_a, 230, 83, 125, M64F_GT |
M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS |
M64F_MFB_FORCE_4 }


# new version
	{ 0x4c4e, 0x4c4e, 0x00, 0x00, m64n_mob_a, 230, 50, 50, M64F_GT |
M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS |
M64F_MFB_FORCE_4 }


I don't know if these settings are rights for every architectures, but
for powerpc it is.

Thanks in advance

Arnaud FONTAINE


--------------enig806206AC3DBA722877302E3F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAhoIAOm9y8/sAguwRAqNvAKCIxX/LVKRHWY4Eevxp8pgFjxTfXQCgwfu3
A7V+P1ErzxLz4cUhbrw6Dog=
=Mie/
-----END PGP SIGNATURE-----

--------------enig806206AC3DBA722877302E3F--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
