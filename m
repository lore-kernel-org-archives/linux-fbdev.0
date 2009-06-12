From: Jan Buecken <jbuecken@gmx.de>
Subject: Re: [Bugme-new] [Bug 13509] New: VT switch
	causes system to lockup
Date: Fri, 12 Jun 2009 12:26:56 +0200
Message-ID: <4A322D70.50702@gmx.de>
References: <bug-13509-10286@http.bugzilla.kernel.org/>
	<20090611160424.fd597dce.akpm@linux-foundation.org>
	<4A321414.20703@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6061219745606058722=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jbuecken@gmx.de>) id 1MF3yf-0001uR-08
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Jun 2009 10:27:17 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MF3yY-00030c-IG for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Jun 2009 10:27:16 +0000
In-Reply-To: <4A321414.20703@gmx.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Tobias Jakobi <liquid.acid@gmx.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, bugzilla-daemon@bugzilla.kernel.org, Michal Januszewski <spock@gentoo.org>, bugme-daemon@bugzilla.kernel.org, jb.faq@gmx.de, Andrew Morton <akpm@linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============6061219745606058722==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDAD061F1586CD0B0B2B37FF8"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDAD061F1586CD0B0B2B37FF8
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Tobias Jakobi schrieb:
> Andrew Morton wrote:
>  =20
>> hm, 2.6.27->2.6.30 is a large hop.
>>    =20
> Hi Andrew!
>
> Yeah, I know. I was going to build a 2.6.29 though, since the fglrx
> driver seems to have some problems with the 30 one.
> I'm going to check then if the problem also occurs with 29.
>  =20
I used the 29 before with uvesafb: There it was not a problem.
Seems to be a regression between 29 and 30.
>
>  =20
>> Perhaps you were using vesafb in 2.6.27 and you're now using uvesafb?
>>
>>    =20
> Nope, I can assure you that. :)
> The 27 kernel has uvesafb activated and is also using it. In fact I jus=
t
> used make oldconfig to port the 27 config over to 30 (I'm not using any=

> distro tools for kernel compiling, just plain make).
>
> Greets,
> Tobias
>
>  =20



--------------enigDAD061F1586CD0B0B2B37FF8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoyLXgACgkQn7AC1blpf4sogQCg0rN/Nmte/ImjfOGsh1KMYXzl
+7kAnjZj6yVZH9QxNIC+AlEihylCPoig
=/6CL
-----END PGP SIGNATURE-----

--------------enigDAD061F1586CD0B0B2B37FF8--


--===============6061219745606058722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============6061219745606058722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============6061219745606058722==--
