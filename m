From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Subject: Re: vesafb with special resolution?
Date: Sat, 16 Oct 2004 09:55:28 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041016075528.GD18311@charite.de>
References: <20041015190606.GN30583@charite.de> <200410160552.20443.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIjPa-0002WP-La
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 16 Oct 2004 00:55:34 -0700
Received: from mail.charite.de ([160.45.207.131])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CIjPZ-0006MB-T3
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 16 Oct 2004 00:55:34 -0700
Content-Disposition: inline
In-Reply-To: <200410160552.20443.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

* Antonino A. Daplas <adaplas@hotpop.com>:

> With the current vesafb incarnation, no. The vesafb driver currently
> selects the mode from a table of standard vesa modes provided by the
> BIOS, and 1280x768 is not standard.

OK.
=20
> Try vesafb-tng if you need a non-vesa standard mode.
>=20
> http://dev.gentoo.org/~spock/projects/vesafb-tng/

I patched my kernel and I'm rebuilding as we speak.

--=20
_________________________________________________

  Charit=E9 - Universit=E4tsmedizin Berlin
_________________________________________________

  Ralf Hildebrandt
   i.A. des IT-Zentrum | Netzwerkdienste
   Stabsstelle des Klinikumsvorstandes
   Campus Benjamin Franklin
   Hindenburgdamm 30 | Berlin
   Tel. +49 30 450 570155 | Fax +49 30 8445-4447
   Ralf.Hildebrandt@charite.de
   http://www.charite.de




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
