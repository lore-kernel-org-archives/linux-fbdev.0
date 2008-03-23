From: Frans Pop <elendil@planet.nl>
Subject: Re: vga16fb: blank screen with Intel
	GM965/GL960 on HP 2510p notebook
Date: Sun, 23 Mar 2008 02:26:37 +0100
Message-ID: <200803230226.38587.elendil@planet.nl>
References: <20080321163944.GA22068@deprecation.cyrius.com>
	<200803222035.08897.elendil@planet.nl>
	<20080322232708.GA32209@deprecation.cyrius.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0104810296=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JdEz2-0006x5-Sq for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 22 Mar 2008 18:26:49 -0700
Received: from hpsmtp-eml20.kpnxchange.com ([213.75.38.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JdEz2-0002IN-2L
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 22 Mar 2008 18:26:48 -0700
In-Reply-To: <20080322232708.GA32209@deprecation.cyrius.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Keith Packard <keith.packard@intel.com>

--===============0104810296==
Content-Type: multipart/signed; boundary="nextPart1575793.tYtD9qn0Jy";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1575793.tYtD9qn0Jy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 23 March 2008, Martin Michlmayr wrote:
> Anyway, you didn't answer my original question which was why the
> text-based d-i loads vga16fb.

The installer only modprobes vga16fb if vesafb is not active (well, it=20
actually does modprobe vga16fb when vesafb and/or fbcon are compiled in=20
[1], but that's the general idea), but that's not the problem here.

The kernel config is:
CONFIG_FB_VGA16=3Dm
CONFIG_FB_VESA=3Dy
CONFIG_VGA_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy

So VESA is compiled in.
The problem here is that /proc/fb doesn't show VESA when the regular=20
installer is booted, AFAICT because we boot with vga=3Dnormal. vesafb seems=
=20
to only be actually activated by the kernel during boot if you boot with a=
=20
vga mode that requires it.

The installer then runs its init scripts, specifically
/lib/debian-installer-startup.d/S40framebuffer-module-linux-x86, and that=20
ends up loading vga16fb because loading vesafb fails (as it's compiled in).
And thus you end up with vga16fb, basically because it's the only=20
framebuffer available _despite_ the fact that vesafb is compiled in...

Is there is a way to activate vesafb post-boot even when the system was=20
booted with vga=3Dnormal? If there is this could probably be avoided.

Also, does anyone know a way to test whether fbcon is compiled in or not?
We can of course test if fbcon is available as a module and assume it's=20
compiled in if not, but that's not a proper test that it _is_ present.

Cheers,
=46JP

[1] I've got a patch to fix that in D-I's rootskel.

--nextPart1575793.tYtD9qn0Jy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH5bHOgm/Kwh6ICoQRAmXXAJ9pirWogjhW0kS9f6FHqMOF2erCjACfSo3Z
tlVakqIbilJP1Bjo0orp70U=
=VDkm
-----END PGP SIGNATURE-----

--nextPart1575793.tYtD9qn0Jy--


--===============0104810296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0104810296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0104810296==--
