From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Tue, 3 Nov 2009 00:57:33 +0100
Message-ID: <20091102235733.GB28292@localhost>
References: <1257199759-2941-1-git-send-email-agraf@suse.de>
	<20091102223249.GC22301@localhost>
	<D295329B-4DE0-4935-8C6B-D45042E72826@suse.de>
	<5B01907D-86BE-4693-81BA-23CB81B8B047@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6280903830778924561=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <santiago@crfreenet.org>) id 1N56lb-0003I8-Mo
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 02 Nov 2009 23:56:55 +0000
Received: from smtp1.kolej.mff.cuni.cz ([78.128.192.10])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N56lL-0004xN-Lt
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 02 Nov 2009 23:56:45 +0000
In-Reply-To: <5B01907D-86BE-4693-81BA-23CB81B8B047@suse.de>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, qemu-devel <qemu-devel@nongnu.org>, Anthony Liguori <anthony@codemonkey.ws>, kvm list <kvm@vger.kernel.org>


--===============6280903830778924561==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2009 at 12:24:15AM +0100, Alexander Graf wrote:
>> Also, we still need to keep the local frame buffer copy in sync so we
>> can mmap and read from it, right? So it's not really worth it
>> probably...
>
> But then again we could just try to be closer to a real graphics card. =
=20
> What if we'd set up a memory region on the host that is basically our =20
> graphics frame buffer? For S390 we could just append the graphics memory=
=20
> to the guest's memory.
>
> We could use that as backing buffer in the qemu graphics frontend and as=
=20
> frame buffer in the Linux fbdev layer, similar to what real graphics=20
> cards set up.

Using shared memory pages between host and guest seems like a natural
way to implement paravirtualized graphics card. Most things are
straightforward, only a little problematic thing is when fbdev=20
is mmaped from guest to userspace - you have to detect writes
and notify host that it changed.

--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrvce0ACgkQw1GB2RHercP9swCfR8R9+phVoIUB2pG+3AMCPJDn
J8sAn0FpRm3LSI9y6ycFug0gCsU8lY2n
=6PAz
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--


--===============6280903830778924561==
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
--===============6280903830778924561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============6280903830778924561==--
