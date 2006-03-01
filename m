From: Stuffed Crust <pizza@shaftnet.org>
Subject: Re: Re: [patch] [radeonfb] Radeon M26 and ATOM bios support (take 4)
Date: Wed, 1 Mar 2006 15:36:11 -0500
Message-ID: <20060301203611.GA14351@shaftnet.org>
References: <20060103204404.GA23313@shaftnet.org> <1139952530.7903.31.camel@localhost.localdomain> <20060222221916.GB17359@shaftnet.org> <20060223060939.GA27224@shaftnet.org> <1140677458.8264.24.camel@localhost.localdomain> <20060223223619.GA14458@shaftnet.org> <1140736521.8264.49.camel@localhost.localdomain> <20060301033338.GA20460@shaftnet.org> <1141184789.4157.30.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FEY3d-0004m0-W0
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 01 Mar 2006 12:36:25 -0800
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86] helo=shaft.shaftnet.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FEY3c-0000Oa-Lr
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 01 Mar 2006 12:36:26 -0800
Received: from shaft.shaftnet.org (localhost [127.0.0.1])
	by shaft.shaftnet.org (8.13.1/8.13.1) with ESMTP id k21KaBpX015061
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 1 Mar 2006 15:36:11 -0500
Received: (from pizza@localhost)
	by shaft.shaftnet.org (8.13.1/8.12.8/Submit) id k21KaBG6015060
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 1 Mar 2006 15:36:11 -0500
Content-Disposition: inline
In-Reply-To: <1141184789.4157.30.camel@localhost.localdomain>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 01, 2006 at 02:46:29PM +1100, Benjamin Herrenschmidt wrote:
> Or just write a small howto and I will do the job :) I've been very busy
> lately mostly due to my newborn child, thus I didn't help more than

Congratulations (and my condolances :P) on the kid!

> that, but I'm really interested in your work. I also want to bring along
> a bunch of fixes like the memory mapping fixes I've been doing on X.org
> radeon driver recently.

I often get lockups in a radeonfb console, could that be related=20
to the mmap stuff you've been fixing?

> In fact, we need a way to provide the driver with the full connector
> mapping I think, in case it can't be obtained from the firmware.

I have a crude "bootstrap the connector table via ddc probing" but it=20
has problems with secondary heads as well, and obviously without ddc it=20
won't work anyway.  Either the user provices a connector table or we=20
pray the defaults, one way or another, are sane.  :)

Of course, once a non-detectable layout is known, we can add it into an
appropriate driver table.

> module option is the easy/cheap way but sucks in some ways... sysfs per
> device instance is nice but a bit "too late" unless we have a way for
> the driver to re-probe... which is a good thing to have anyway since we
> might finally deal with screen hotplug :)

MM, that would be nice.. but I don't want to think about the console
interactions required for display reconfiguration.  That said, the new=20
code is capable of re-detecting at any time, but I'm sure the radeonfb=20
core has issues.

> I'll look at your stuff in more detail asap and will then let it simmer
> in -mm if I'm happy enough for at least a kernel version...

I'm about to mail out v5 of the patch.

 - Solomon
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL
Quidquid latine dictum sit, altum viditur.

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFEBgW7PuLgii2759ARArXbAKCPpujRhHlO+Vd411PJ/5kGjDaiMgCeKLlN
QfJDI/xdFM8qmhhtteq4DyI=
=+cF4
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
