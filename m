From: Martin Waitz <tali@admingilde.org>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Sun, 17 Oct 2004 14:07:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20041017120728.GC10532@admingilde.org>
References: <416E6ADC.3007.294DF20D@localhost> <87d5zkqj8h.fsf@bytesex.org> <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be> <87y8i8p1jq.fsf@bytesex.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S269050AbUJQMIS@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87y8i8p1jq.fsf@bytesex.org>
List-Id: <fbdev-devel.lists.sourceforge.net
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Linux Kernel Development <linux-kernel@vger.kernel.org>, penguinppc-team@lists.penguinppc.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Fri, Oct 15, 2004 at 03:13:13PM +0200, Gerd Knorr wrote:
> You have a application running which uses the framebuffer device, then
> suspend with that app running.  You'll have to restore the state of
> the device _before_ restarting all the userspace proccesses, otherwise
> the app will not be very happy.

As long as the app only interfaces with the framebuffer device and not
directly with the hardware it won't notice.
The apps data will simply not show up on the screen until the
usermode helper finishes.

--=20
Martin Waitz

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBcmCAj/Eaxd/oD7IRApmhAJ45kTqnLsgLQHd8x9hUTFZmCxAHYwCggy7v
Qh14l7v0bNmkxsgj9b2qazQ=
=61cb
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
