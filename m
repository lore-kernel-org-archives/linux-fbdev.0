From: Martin Waitz <tali@admingilde.org>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Mon, 18 Oct 2004 13:39:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20041018113929.GB3618@admingilde.org>
References: <416E6ADC.3007.294DF20D@localhost> <87d5zkqj8h.fsf@bytesex.org> <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be> <87y8i8p1jq.fsf@bytesex.org> <20041017120728.GC10532@admingilde.org> <20041018083632.GE3065@bytesex>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S266170AbUJRLkf@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041018083632.GE3065@bytesex>
List-Id: <fbdev-devel.lists.sourceforge.net
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Linux Kernel Development <linux-kernel@vger.kernel.org>, penguinppc-team@lists.penguinppc.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Mon, Oct 18, 2004 at 10:36:32AM +0200, Gerd Knorr wrote:
> On Sun, Oct 17, 2004 at 02:07:28PM +0200, Martin Waitz wrote:
> > On Fri, Oct 15, 2004 at 03:13:13PM +0200, Gerd Knorr wrote:
> > > You have a application running which uses the framebuffer device, then
> > > suspend with that app running.  You'll have to restore the state of
> > > the device _before_ restarting all the userspace proccesses, otherwise
> > > the app will not be very happy.
> >=20
> > As long as the app only interfaces with the framebuffer device and not
> > directly with the hardware it won't notice.
>=20
> Well, mmap("/dev/fb") will just map the gfx cards memory into
> the applications address space, so they _will_ interface with
> the hardware.

but still through a driver which can take care of this access.

> > The apps data will simply not show up on the screen until the
> > usermode helper finishes.
>=20
> Whenever writing to the gfx memory before finishing the initialization
> is harmless or not probably depends on the hardware, I'd better not
> count on it ...

when the application tries to access the framebuffer memory then
the driver is asked to map the corresponding page.
If the hardware does not cope with framebuffer access while it
is not correctly initialized, then the driver can defer those
mappings until the userspace helper is run.

--=20
Martin Waitz

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBc6twj/Eaxd/oD7IRAoboAJ9KreNPAGUNdcMAOn1yQiEAKqKeggCdEP9g
Qb0rzXaKA2dW8M8EnE6UfrY=
=EH4+
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
