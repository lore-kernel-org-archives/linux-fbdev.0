From: Javier Marcet <javier-ml-gmane@marcet.info>
Subject: Re: [PATCH][FBCON]: Mode Switch in fbcon_blank()
Date: Sat, 3 Jul 2004 02:43:20 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040703004320.GA18288@marcet.info>
References: <200406301047.57423.adaplas@hotpop.com> <1088564019.1922.12.camel@gaston> <cc3d6r$d5v$1@sea.gmane.org> <200407022337.20156.adaplas@hotpop.com>
Reply-To: Javier Marcet <javier@marcet.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgYcq-0006A2-3G
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Jul 2004 17:43:28 -0700
Received: from www.marcet.info ([213.60.130.45] helo=mail.marcet.info)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BgYcp-0001Fz-CJ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Jul 2004 17:43:28 -0700
Content-Disposition: inline
In-Reply-To: <200407022337.20156.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Antonino A. Daplas <adaplas@hotpop.com> [040702 17:36]:

>> > Well... I don't know. It seem to work, so it's probably an acceptable
>> > workaround, but I'd like to find out what's wrong with doing it in bla=
nk
>> > precisely (that is what is the bug in XFree or in the kernel VT), since
>> > it's shared by many X drivers, I don't suppose it's a bug in them.

>> This was included in 2.6.7-mm5 -that's how I noticed it- and I had to
>> revert it.

>> I use radeonfb and when switching from X to console my two monitors will
>> go out of sync. The VT is actually there since I can type on it, but I
>> can't see anything on neither of my two monitors :(

>Grr, I was a little tentative about this patch, hoping against hope that it
>will work for all drivers, but you've proven me wrong.  Anyway, we now have
>at least 2 drivers that requires reinitialization at different stages, rad=
eonfb
>requires it at fbcon_blank() and rivafb at fbcon_switch().  And I really d=
on't
>know how to fix it except to look closely at X (and I dread looking at X's=
 code...)
>and the VT code (ditto).

>Can you try the patch below?  It works for the rivafb, hopefully it works =
for yours.

Hi Antonio,
sorry for not answering sooner, I thought I had done before leaving to
work.
Well, with this patch in addition to your original one, it works right
again with my radeon frame buffer & X :)

For me it's fine. Thanks for your help ;-)

If I can be of any help, trying further patches or whatever, please ask.


--=20
If A equals success, then the formula is _=08A =3D _=08X + _=08Y + _=08Z.  =
_=08X is work.  _=08Y
is play.  _=08Z is keep your mouth shut.
s		-- Albert Einstein

Javier Marcet <javier@marcet.info>

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.8 (GNU/Linux)

iEYEARECAAYFAkDmASgACgkQx/ptJkB7frwV/QCghbyOFJwJzN0PBDofScGdGxkb
dlEAn1cPqHE6AzZmojZqgbGi5JdYLgeR
=f31P
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
