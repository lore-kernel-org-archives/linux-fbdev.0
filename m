From: Frans Pop <aragorn@tiscali.nl>
Subject: Re: [atyfb] No display on Sparc Ultra 10 with kernel 2.6.10-rc2 or later
Date: Thu, 17 Feb 2005 15:16:05 +0100
Message-ID: <200502171516.14390.aragorn@tiscali.nl>
References: <200502140251.00645.aragorn@tiscali.nl> <200502170702.58630.adaplas@hotpop.com> <200502170724.36195.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9319971.t4USBE9oAj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
In-Reply-To: <200502170724.36195.adaplas@hotpop.com>
Resent-Message-ID: <PZr9sD.A.EjC.vcKFCB@murphy>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:debian-sparc@lists.debian.org>
List-Help: <mailto:debian-sparc-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-sparc-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-sparc-request@lists.debian.org?subject=unsubscribe>
List-Archive: <http://lists.debian.org/debian-sparc/>
To: adaplas@pol.net
Cc: "David S. Miller" <davem@davemloft.net>, debian-sparc@lists.debian.org, sparclinux@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

--nextPart9319971.t4USBE9oAj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 17 February 2005 00:24, Antonino A. Daplas wrote:
> > Try this patch and let me know.
> >
> > video=atyfb:comp_sync:<n>,vert_sync:<n>,hor_sync:<n>
> >
> > n = 0 (low), 1 (high)

I've tested with the following combinations:
- append="video=atyfb:comp_sync:1,1024x768@70"
  Works perfectly: csync is high and good display.
- append="video=atyfb:comp_sync:1,hor_sync:1,vert_sync:0,1024x768@70"
  csync is high, but for some reason not hsync; display is good.
- append="video=atyfb:1024x768@70,comp_sync:1"
  Same results as first test.

The sync settings were checked with 'fbset -i'.

> BTW, the mode string should always be the last parameter, ie;
>
> video=atyfb:comp_sync:1,1024x768@70

Hmmm. Wonder why you say that (considering the result of my last test).

Should these new options also be documented in Documentation/fb/?

Cheers,
Frans

--nextPart9319971.t4USBE9oAj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCFKcugm/Kwh6ICoQRAjf6AKCzH+tGfg76/gtIivwxlSr/YOKBBQCdEBVa
frEiiLsOoSmRNgskjpEVgIc=
=+fYK
-----END PGP SIGNATURE-----

--nextPart9319971.t4USBE9oAj--
