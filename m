From: Martin Waitz <tali@admingilde.org>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Tue, 19 Oct 2004 18:57:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20041019165720.GF3618@admingilde.org>
References: <416E6ADC.3007.294DF20D@localhost> <20041018121033.GB5106@bytesex> <20041018202147.GA28720@hh.idb.hist.no> <200410182242.04749.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S269842AbUJSRFp@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200410182242.04749.oliver@neukum.org>
List-Id: <fbdev-devel.lists.sourceforge.net
To: Oliver Neukum <oliver@neukum.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Gerd Knorr <kraxel@bytesex.org>, linux-fbdev-devel@lists.sourceforge.net, Linux Kernel Development <linux-kernel@vger.kernel.org>, penguinppc-team@lists.penguinppc.org


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 18, 2004 at 10:42:04PM +0200, Oliver Neukum wrote:
> Am Montag, 18. Oktober 2004 22:21 schrieb Helge Hafting:
> > > On first access only, and even that only if the driver doesn't map the
> > > pages at mmap() time already. ?Not a single fb driver seems to map the
> > > pages lazy today, grepping in drivers/video for nopage handles shows
> > > nothing. ?I'm not sure you can actually do that for iomem mappings.
> > >=20
> > Isn't it possible for the driver to unmap the mapping when
> > suspending? ?Then you're guaranteed to get that first access.
>=20
> But what would you do then? Block everything that is using a terminal?

yes

but that wouldn't last long if you run the userspace helper as soon
as you are finished resuming.

One 'only' needs a method to give feedback while loading the image...
I guess we have to rely on the firmware here.
(Eighter it already sets an useable mode or provides a function that
can display test)

--=20
Martin Waitz

--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBdUdvj/Eaxd/oD7IRAqujAJoDEg5BLRKM51a58fZPgqcOdZZu2QCfRCoI
rVob2PU1RxE+a6bZQzT29CE=
=SVtM
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--
