From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: /dev/fb device files are not created.
Date: Sat, 26 Jun 2004 17:35:07 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040626153507.GJ20632@lug-owl.de>
References: <1088247505.40dd56d1e5047@webmail.quest-innovations.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gDE3EnWm8Y4j2VPT"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BeFD1-00034E-J9
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 26 Jun 2004 08:35:15 -0700
Received: from dvmwest.gt.owl.de ([62.52.24.140])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BeFD0-0000pM-QN
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 26 Jun 2004 08:35:15 -0700
Content-Disposition: inline
In-Reply-To: <1088247505.40dd56d1e5047@webmail.quest-innovations.com>
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


--gDE3EnWm8Y4j2VPT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-06-26 12:58:25 +0200, Jaap van den Handel <jaap@quest-innovati=
ons.com>
wrote in message <1088247505.40dd56d1e5047@webmail.quest-innovations.com>:
> I'm still working on the frame buffer driver for the vga solution my comp=
any =20
> has developed. I created a test program which prints the memory addresses.

Where's actual source code for that? What kind of device is that? PCI
based? Is it used on PCs? I've never ever seen that piece of hardware,
there's no pointer to hardware docs, not even a name for that device
so that anybody could google for it...

> when I create the files manually, the vfb.o and our own driver both seem =
to=20
> return address 0x00000003 I think this cannot be ok.

Right, looks wrong. From all the data provided about the device and it's
driver, the best guess for a base address is to read
(BITS_PER_LONG =3D=3D 32? 4: 8) bytes from /dev/random...

> Is there somebody who knows what the problem might be?

Not until you put source code on the table and...

> Confidentiality Note:
> This e-mail and any attachments are confidential and the information here=
in
> is property of Quest Innovations B.V.. If you are not the intended recipi=
ent(s) of this e-mail,you are hereby notified that any dissemination, distr=
ibution,=20
> copying, use of or reliance upon the information contained within this e-=
mail=20
> or attachments is unauthorized and strictly prohibited. If you have recei=
ved
> this e-mail in error, please notify us immediately by returning it to the
> sender and delete this copy from your system.
>=20
> Quest Innovations B.V.

drop this silly BS on publically accessible, web-archived mailing
lists:) If it's added to any email sent out from your company, maybe
you'd ask to officially use something like a @gmx.net based email
address for kernel development; if you're intending to build a
proprietary driver, don't expect too much help...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--gDE3EnWm8Y4j2VPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3ZerHb1edYOZ4bsRAjNlAJsH0kzTdoa7lWLvhxN50KT6tm742QCeIbwV
nwy6yMfBJ2DoRpaoYUgWDeM=
=YRvr
-----END PGP SIGNATURE-----

--gDE3EnWm8Y4j2VPT--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
