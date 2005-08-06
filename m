From: Patrick McFarland <pmcfarland@downeast.net>
Subject: Re: CRTC scanout buffer types
Date: Sat, 6 Aug 2005 19:23:53 -0400
Message-ID: <200508061924.03205.pmcfarland@downeast.net>
References: <9e47339105080513195dee0804@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2539032.8uAJjZeX6Q";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-admin@lists.sourceforge.net>
In-Reply-To: <9e47339105080513195dee0804@mail.gmail.com>
Sender: dri-devel-admin@lists.sourceforge.net
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
To: dri-devel@lists.sourceforge.net, Jon Smirl <jonsmirl@gmail.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

--nextPart2539032.8uAJjZeX6Q
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 05 August 2005 04:19 pm, Jon Smirl wrote:
> I've included the scanout types for the R200, what other ones are
> supported by the various chips? For example I think the R300 can
> scanout in floating point.
>
> 4bpp Indexed
> 8bpp Indexed
> 16bpp aRGB 1555
> 16bpp RGB 565
> 24bpp RGB 888
> 32bpp aRGB 8888
> 16bpp aRGB 4444
> 16bpp aIndex 88
> 32bpp aRGB 2:10:10:10 palette bypassed
>
> Note, the r200 supports a lot more buffer formats, but these are the
> only ones valid for scanout.

What does scanout mean?

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart2539032.8uAJjZeX6Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBC9UaT8Gvouk7G1cURAn+0AJ9vL+wEtijLwQBbPIuzZnmh/AvFhQCgjp2R
0+HsK0IgDHXjD8+MWLcaaEk=
=MJq9
-----END PGP SIGNATURE-----

--nextPart2539032.8uAJjZeX6Q--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
--
