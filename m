From: Valdis.Kletnieks@vt.edu
Subject: Re: [Linux-fbdev-devel] [PATCH 1/2] fb: add support for foreign endianness
Date: Tue, 19 Feb 2008 19:47:08 -0500
Message-ID: <28238.1203468428@turing-police.cc.vt.edu>
References: <20080205154432.GA8749@localhost.localdomain> <20080214224942.a0cb6218.akpm@linux-foundation.org> <20080215164542.GB16810@localhost.localdomain> <Pine.LNX.4.64.0802171030330.6848@anakin> <20080218081847.e9e65f2f.krzysztof.h1@poczta.fm> <19805.1203355811@turing-police.cc.vt.edu> <47BA162C.5000807@anagramm.de> <1203381353.6740.59.camel@pasglop> <47BABD3A.7010102@anagramm.de>
            <20080219040530.7b1d115d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1203468428_762P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764122AbYBTAss@vger.kernel.org>
In-Reply-To: Your message of "Tue, 19 Feb 2008 04:05:30 PST."
             <20080219040530.7b1d115d.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Clemens Koller <clemens.koller@anagramm.de>, benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Krzysztof Helt <krzysztof.h1@poczta.fm>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>, Anton Vorontsov <avorontsov@ru.mvista.com>

--==_Exmh_1203468428_762P
Content-Type: text/plain; charset=us-ascii

On Tue, 19 Feb 2008 04:05:30 PST, Andrew Morton said:
> On Tue, 19 Feb 2008 12:27:54 +0100 Clemens Koller <clemens.koller@anagramm.de
> wrote:
> > That's not an issue in my case. The SM50x can be connected to
> > either an PCI or some Local/CPU-whateverbus IF.
> > I.e. on the MPC85xx PowerPC, PCI and LocalBus are separate bussses.
> > If the sm501 is attached to the MPC85xx' PCI like any other video card,
> > the PCI config-space is can be accessed as usual, whereas the framebuffer
> > memory area is byte-swapped compared to other common video cards.

> Anyway, my head is now officially spinning.  Did anyone actually have a
> reason why we shouldn't proceed with Anton's patch?

Clemens answered my question regarding the real-life existence of hardware
that would benefit.  I'd say if Anton's patch works on Clemens' hardware and
otherwise passes review, we should proceed...


--==_Exmh_1203468428_762P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFHu3iMcC3lWbTT17ARAgx+AJ9YtUuSqdwZPFqbnGpbTcc9N06N2gCg7Iec
i+s8lb/JdlR1Xt4QqbkH1fg=
=iDDy
-----END PGP SIGNATURE-----

--==_Exmh_1203468428_762P--
