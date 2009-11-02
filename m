From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Tue, 3 Nov 2009 00:58:28 +0100
Message-ID: <20091102235827.GC28292@localhost>
References: <1257199759-2941-1-git-send-email-agraf@suse.de>
	<20091102223249.GC22301@localhost>
	<D295329B-4DE0-4935-8C6B-D45042E72826@suse.de>
	<20091102235116.GA28292@localhost>
	<6C8638F3-7AC7-44CC-A86E-C26E29350BD8@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8840275844883887895=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <santiago@crfreenet.org>) id 1N56oG-00049m-69
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 02 Nov 2009 23:59:40 +0000
Received: from smtp1.kolej.mff.cuni.cz ([78.128.192.10])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N56mE-0004pb-4B
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 02 Nov 2009 23:59:40 +0000
In-Reply-To: <6C8638F3-7AC7-44CC-A86E-C26E29350BD8@suse.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Alexander Graf <agraf@suse.de>
Cc: linux-fbdev-devel@lists.sourceforge.net


--===============8840275844883887895==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2009 at 12:53:08AM +0100, Alexander Graf wrote:
>> Advantages might be on Qemu side (like ability to run in text-only
>> mode without need to change console on virtualized sytem).
>
> Oh, so we could use the curses frontend. That's a neat idea.
>
> But that also means we'll lose the penguin, right?

Yes :-)

--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrvciIACgkQw1GB2RHercPvjgCfXTdpfxZG80DvP5KH2PQ5JWQ0
j5sAniqLRAS7klvq4hw7Ns8C/4f6xr3g
=Nxp9
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--


--===============8840275844883887895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--===============8840275844883887895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============8840275844883887895==--
