From: Michal Januszewski <spock@gentoo.org>
Subject: Re: [announce 7/7] fbsplash - documentation
Date: Thu, 10 Mar 2005 01:16:48 +0100
Message-ID: <20050310001647.GA19784@spock.one.pl>
References: <20050308021706.GH26249@spock.one.pl> <200503090117.12755.arnd@arndb.de> <20050309020527.GA20294@spock.one.pl> <200503091640.10421.arnd@arndb.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9BMD-0002Ck-5F
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 16:16:53 -0800
Received: from ipp23-131.piekary.net ([80.48.23.131] helo=spock.one.pl)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D9BMB-0004Hc-C4
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 16:16:53 -0800
Content-Disposition: inline
In-Reply-To: <200503091640.10421.arnd@arndb.de>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2005 at 04:40:09PM +0100, Arnd Bergmann wrote:

> Ok, I now saw that you call call_usermodehelper with wait=3D=3D1. Why is =
that
> necessary? If you don't wait there, you don't need any hacks around the
> console semaphore, because the helper will simply wait for change_console
> to finish.

That could work, assuming that:
a) the helper can always finish unpacking the image before=20
   change_console releases the semaphore
b) the console is not redrawn at one point before change_console is=20
   finished (I'm sorry, I don't have time to check that right now)

If one of this assumptions is wrong, we would end up with first=20
displaying the wrong background picture and then quickly painting
the new one (I doubt this would make a good impression on the user..).
 =20
> > What are the alternatives to the ioctl? A relatively clean way of
> > feeding the data back to the kernel would be using sysfs. However, to
> > make it sane we would have to export the various components of struct
> > vc_splash in /sys/class/tty/tty<x> (otherwise, we would probabky have
> > to pass aggreaget data types through a sysfs entry -- something that is
> > IMO much worse than an ioctl). That however could be a little
> > problematic -- tty_class is currently defined as a class_simple.
> > To add entries other than the standard 'dev' we would have to define a
> > completely new class, right? That sounds like a rather intrusive
> > change..
>=20
> Right. I don't think that sysfs is the right interface for this problem.
> For a short moment I had the idea that you could write an escape sequence
> to the tty device, but that would race against the regular output.
> An ioctl on the tty device is probably the best you can do here, but
> if that's not possible, creating a misc device in order to do ioctl on it
> is a rather ugly hack.

Agreed, that might not be the nicest thing to do, but it just seems
there isn't much of a choice in this situation.

I'm going to be away for the next 10 days or so. When I get back I'll
start testing some of the proposed changes. Maybe by using things like
firmware_request it would at least be possible to make the splash
interface a little simpler.

Live long and prosper.
--=20
Michal 'Spock' Januszewski                        Gentoo Linux Developer
cell: +48504917690                         http://dev.gentoo.org/~spock/
JID: spock@im.gentoo.org               freenode: #gentoo-dev, #gentoo-pl


--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCL5HvaQ0HSaOUe+YRAnzqAJ9bqACc3XEtkdfeXFg+UrW/LBk0XACbBojl
kc5B9zJWuw0VIf6by+UsuG4=
=X6Ka
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
