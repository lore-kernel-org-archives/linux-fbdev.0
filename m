From: Valdis.Kletnieks@vt.edu
Subject: Re: 2.6.21-rc2-mm1 - fb_ddc_read() not defined
Date: Fri, 02 Mar 2007 11:51:51 -0500
Message-ID: <200703021651.l22Gpp01008083@turing-police.cc.vt.edu>
References: <20070302030026.5eef0c92.akpm@linux-foundation.org> <200703021603.l22G37Sa022890@turing-police.cc.vt.edu>
            <Pine.LNX.4.64.0703021630040.3216@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1172854311_6664P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992610AbXCBQwL@vger.kernel.org>
In-Reply-To: Your message of "Fri, 02 Mar 2007 16:31:02 GMT."
             <Pine.LNX.4.64.0703021630040.3216@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Antonino Daplas <adaplas@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

--==_Exmh_1172854311_6664P
Content-Type: text/plain; charset=us-ascii

On Fri, 02 Mar 2007 16:31:02 GMT, James Simmons said:

> > > nvidiafb-bring-back-generic-ddc-reading.patch

> To have a patch to cleans things up. Give it a try
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index b8f0a11..855a09e 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig

Queued up for the next time I build a -mm kernel.  This build of 21-rc2-mm1
has been up for 33 minutes already, so it may be later tonight (when I try
to get my Intel 3945 wireless card working with the new 80211 stack).

--==_Exmh_1172854311_6664P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFF6FYncC3lWbTT17ARArtCAKDLHmajzcRE5CDN0faKZvFWXkJcsQCgwvy8
oRtvBZN3tAQK69JKF4ep2L0=
=E5W8
-----END PGP SIGNATURE-----

--==_Exmh_1172854311_6664P--
