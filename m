From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Tue, 3 Nov 2009 00:51:17 +0100
Message-ID: <20091102235116.GA28292@localhost>
References: <1257199759-2941-1-git-send-email-agraf@suse.de>
	<20091102223249.GC22301@localhost>
	<D295329B-4DE0-4935-8C6B-D45042E72826@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2882645882715572437=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <santiago@crfreenet.org>) id 1N56fL-0003hy-0P
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 02 Nov 2009 23:50:27 +0000
Received: from smtp1.kolej.mff.cuni.cz ([78.128.192.10])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N56fE-0002PG-UW
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 02 Nov 2009 23:50:26 +0000
In-Reply-To: <D295329B-4DE0-4935-8C6B-D45042E72826@suse.de>
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


--===============2882645882715572437==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2009 at 11:42:11PM +0100, Alexander Graf wrote:
>
> Am 02.11.2009 um 23:32 schrieb Ondrej Zajicek <santiago@crfreenet.org>:
>
>> On Mon, Nov 02, 2009 at 11:09:19PM +0100, Alexander Graf wrote:
>>> When we want to create a full VirtIO based machine, we're still =20
>>> missing
>>> graphics output. Fortunately, Linux provides us with most of the =20
>>> frameworks
>>> to render text and everything, we only need to implement a transport.
>>>
>>> So this is a frame buffer backend written for VirtIO. Using this and=20
>>> my
>>> patch to qemu, you can use paravirtualized graphics.
>>
>> Just a note: it might be useful to allow paravirtualized graphics to
>> handle text mode. In that case, it can be done in fbdev layer using
>> tileblit operations.
>
> Is there any real driver implementing this already? I'd prefer to copy =
=20
> from working code instead of writing my own :-).

Yes, for example s3fb and vt8623fb (struct fb_tile_ops).

> Also, we still need to keep the local frame buffer copy in sync so we =20
> can mmap and read from it, right? So it's not really worth it =20
> probably...

Advantages might be on Qemu side (like ability to run in text-only
mode without need to change console on virtualized sytem).

--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrvcHQACgkQw1GB2RHercMLXwCfdxbFfsnCapDOehs67Vrbo5Vy
9G0AnA9lB7q4TM8Y39EbfQl/nIamh9BN
=Q0dD
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--


--===============2882645882715572437==
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
--===============2882645882715572437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============2882645882715572437==--
