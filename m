From: Branden Robinson <branden@debian.org>
Subject: Re: Bug#226973: Re: Bug#226973: xserver-xfree86: [glint] second card at wrong resolution
Date: Thu, 1 Apr 2004 11:41:06 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040401164106.GB17894@deadbeast.net>
References: <20040114211246.GA31567@scowler.net> <20040114211643.GA6793@iliana> <20040330153247.GB11287@scowler.net> <20040330165738.GC31639@lambda> <20040330230203.GA2568@scowler.net> <20040330230829.GA5257@lambda> <Pine.GSO.4.58.0403311011400.22944@waterleaf.sonytel.be> <20040331161002.GB16669@scowler.net> <20040401064122.GH16695@deadbeast.net> <20040401065102.GB637@lambda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B95Ff-0000sy-IA
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Apr 2004 08:41:11 -0800
Received: from dhcp065-026-182-085.indy.rr.com ([65.26.182.85] helo=redwald.deadbeast.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B95Ff-0006kv-9u
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Apr 2004 08:41:11 -0800
Content-Disposition: inline
In-Reply-To: <20040401065102.GB637@lambda>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Clint Adams <schizo@debian.org>, 226973@bugs.debian.org, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 01, 2004 at 08:51:02AM +0200, Sven Luther wrote:
> On Thu, Apr 01, 2004 at 01:41:22AM -0500, Branden Robinson wrote:
> > On Wed, Mar 31, 2004 at 11:10:02AM -0500, Clint Adams wrote:
> > > > If your graphics controller is limited by memory bandwidth, the max=
imum pixel
> > > > clock depends on the number of bits per pixels, since larger pixels=
 mean more
> > > > memory bandwidth.
> > >=20
> > > I'm unclear on the differences between 24 bpp and 32 bpp and how this
> > > relates to internal pixmap format.
> >=20
> > Some hardware uses a "packed-pixel format"; that is, 4 24-bit pixels are
> > encoded in 3 32-bit words (what Intel calls "DWORDS", I think).
>=20
> Yeah, DWORDS, because they are stil living in the era of 16bit hardware :)
>=20
> > Other hardware tosses in a zero byte with every 32-bit "DWORD" transfer.
>=20
> Well, the permedia2 should support both formats, depending on chosen
> mode.

Well, maybe this is what is going on.  Maybe Solaris is using a
packed-pixel format, and XFree86 is using zero-padded format.

That is, assuming it's the RAMDAC's job to understand the pixel format,
and that some part isn't stuck in front of it to give it a standardized
format.  I wouldn't know.

--=20
G. Branden Robinson                |     That's the saving grace of humor:
Debian GNU/Linux                   |     if you fail, no one is laughing at
branden@debian.org                 |     you.
http://people.debian.org/~branden/ |     -- A. Whitney Brown

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iEYEARECAAYFAkBsRiIACgkQ6kxmHytGonyFEQCdFF38BuMRefrfAnfFneP63gYO
EecAoIIUgARJE03L2Yjh6HTUelun4TPY
=mQ2x
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
