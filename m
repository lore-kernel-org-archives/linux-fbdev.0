From: Stuffed Crust <pizza@shaftnet.org>
Subject: Re: [patch] [radeonfb] Radeon Mobility X700 (M26) and ATOM bios support
Date: Thu, 5 Jan 2006 15:13:37 -0500
Message-ID: <20060105201337.GA5789@shaftnet.org>
References: <20060103204404.GA23313@shaftnet.org> <1136455156.4840.76.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eubhv-0001NV-Jt
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 Jan 2006 12:27:35 -0800
Received: from rrcs-24-73-230-86.se.biz.rr.com
	([24.73.230.86] helo=shaft.shaftnet.org ident=[mRnVInwRhHX7yrCYWWtDakHr0wMeP/FF])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Eubhu-0001gS-8V
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 Jan 2006 12:27:35 -0800
Received: from shaft.shaftnet.org (localhost [127.0.0.1])
	by shaft.shaftnet.org (8.12.11/8.12.11) with ESMTP id k05KDbPC005916
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 5 Jan 2006 15:13:37 -0500
Received: (from pizza@localhost)
	by shaft.shaftnet.org (8.12.11/8.12.8/Submit) id k05KDb69005913
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 5 Jan 2006 15:13:37 -0500
Content-Disposition: inline
In-Reply-To: <1136455156.4840.76.camel@localhost.localdomain>
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


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2006 at 08:59:15PM +1100, Benjamin Herrenschmidt wrote:
> Inresting. I started doing that (and updated the pre-ATOM BIOS code too)
> but never finished... One thing you could do that would be useful is
> move the various BIOS code to separate function and setup function
> pointers that can be set based on the BIOS type instead of the endless
> stream if (atom_bios) xxx else yyy. That way, it will be cleaner and
> I'll be able to more easily add other variations like retreiving infos
> from Open Firmware on ppc etc...

Will do.  I'll probably get to it during the weekend. =20

Off the top of my head there's LVDS info, PLL, Connector, and TMDS=20
detection/mangling to be split out; anything else?

 - Solomon
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL 					=20
Quidquid latine dictum sit, altum viditur.

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDvX3xPuLgii2759ARAg+hAJ9D3uzrTHtRhEz+cXjAjPDtNbMnNwCg0WEv
E4h98aojLue90CeZHv69Sus=
=W9vf
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
