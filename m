From: Keith Packard <keithp@keithp.com>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Thu, 06 May 2004 18:20:24 -0700
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <E1BLu2K-0000aT-00@evo.keithp.com>
References: <20040507005040.18258.qmail@web14925.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1832957872P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Thu, 06 May 2004 17:50:40 PDT."
             <20040507005040.18258.qmail@web14925.mail.yahoo.com> 
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: James Simmons <jsimmons@infradead.org>, Nicolas Souchu <nsouch@free.fr>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>, Keith Packard <keithp@keithp.com>

--==_Exmh_1832957872P
Content-Type: text/plain; charset=us-ascii


Around 17 o'clock on May 6, Jon Smirl wrote:

> A proposal has been made that OpenGL be promoted as the primary base graphics
> API on Linux. Then things like Cairo and the xserver be implemented on top of
> OpenGL.

I respectfully disagree with this plan.  OpenGL should be the sole API for 
accessing the graphics card for systems which support it, but I encourage 
application developers to continue coding to the X API so that there 
aren't unexpected "surprises" when run on a machine which doesn't support 
OpenGL.

That the X server will use OpenGL to talk to these graphics cards is an 
implementation detail which shouldn't be visible to applications.

-keith



--==_Exmh_1832957872P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.3.1 11/28/2001

iD8DBQFAmuRYQp8BWwlsTdMRAuYvAKDHc8BSBO3muNdSwaPNeCuywUwWDACePHry
Q48SmdOoNxARiFaLaENI+rQ=
=irT2
-----END PGP SIGNATURE-----

--==_Exmh_1832957872P--


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
