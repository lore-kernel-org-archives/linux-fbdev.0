From: Stuffed Crust <pizza@shaftnet.org>
Subject: radeonfb: Add ATOM BIOS parsing v5b/v6 (rebased
	patch)
Date: Wed, 6 Sep 2006 18:00:27 -0400
Message-ID: <20060906220027.GA30385@shaftnet.org>
References: <20060905153713.GA22789@shaftnet.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1843299873=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GL5XG-00008v-3h for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Sep 2006 15:06:18 -0700
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]
	helo=shaft.shaftnet.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GL5XC-0001Uw-HK
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Sep 2006 15:06:18 -0700
Received: from shaft.shaftnet.org (localhost [127.0.0.1])
	by shaft.shaftnet.org (8.13.1/8.13.1) with ESMTP id k86M0S7w032169
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 6 Sep 2006 18:00:28 -0400
Received: (from pizza@localhost)
	by shaft.shaftnet.org (8.13.1/8.13.1/Submit) id k86M0Rvn032168
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 6 Sep 2006 18:00:27 -0400
In-Reply-To: <20060905153713.GA22789@shaftnet.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net


--===============1843299873==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-Off-By:  Solomon Peachy <pizza@shaftnet.org>

Below is v5b of the ATOM BIOS patch.  Changes from v5:

 * LVDS/DFP with attached DDC port can be queried
 * LVDS/DFP won't be misdetected as CRT if a DDC port is connected.

  http://www.shaftnet.org/users/pizza/radeonfb-atom-2.6.17-v5b.diff
  http://www.shaftnet.org/users/pizza/radeonfb-atom-2.6.18-v5b.diff

Meanwhile, I've rolled in some other work to create v6 of the patch,=20
this time against 2.6.18-rc6 only:=20

  http://www.shaftnet.org/users/pizza/radeonfb-atom-2.6.18-v6.diff

Changes from v5b:

(Note -- many of these changes were taken in part from an older patch by
 Claudio Ciccan; I kept what was relevant and tossed the rest)

 * Added many new radeon PCI IDs (X300/X600/X700/X800/X850)
 * R4x0 series gets R300 tweaks (from Xorg)
 * Cap VRAM to 128M (Not really sure why.. related to mmap bugs?)
 * Add default_dynclk to builtin argument parsing.
 * Expanded the register mmio size to max (64k vs former 16k)
     (was there a reason why it wasn't already maxed?)
 * Initialization tweaks for R300 and RS300 (from Xorg)

I'd really like to see the v6 patch (or its successors) go in to 2.6.19,=20
as the existing radeonfb driver simply won't work with newer radeon=20
cards -- to say nothing about its multihead detection quirks.

So, I encourage everyone with a radeon card to give this new driver a=20
whirl, especially if you have an X-series radeon board or if you were=20
having head detection problems with the existing driver.=20

Please run this with CONFIG_FB_RADEON_DEBUG on, so if something goes=20
wrong I can get it fixed up. =20

There at least one known corner case where things could go wrong
(LVDS/DFP port has an associated DDC port, but no EDID information is
available) but I'm already working on that.

See also:

  http://bugzilla.kernel.org/show_bug.cgi?id=3D6215

Ciao,

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org	=20
Melbourne, FL                          ^^ (mail/jabber/gtalk) ^^
Quidquid latine dictum sit, altum viditur.          ICQ: 1318344


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFE/0T7PuLgii2759ARAtPKAKDGrcKpdwiXXYngoWsW+0V/bg6RewCgwFvV
8rhJDa5SnSGkhbyJnRhFdlc=
=012p
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--


--===============1843299873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1843299873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1843299873==--
