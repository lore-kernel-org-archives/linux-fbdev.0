From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Re: [linux-2.6.10] radeonfb / oops
Date: Fri, 4 Feb 2005 20:42:04 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502042040530.25309@pentafluge.infradead.org>
References: <200502030925.09942.pluto@pld-linux.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CxAHM-0006zK-VI
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Feb 2005 12:42:12 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CxAHJ-0006Aq-9G
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Feb 2005 12:42:12 -0800
Received: from jsimmons (helo=localhost)
	by pentafluge.infradead.org with local-esmtp (Exim 4.43 #1 (Red Hat Linux))
	id 1CxAHE-0006bJ-B6
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Feb 2005 20:42:05 +0000
In-Reply-To: <200502030925.09942.pluto@pld-linux.org>
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
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net


Ug. You have to many video drivers enabled. For one you both radeons=20
enabled, there is a older driver, and VESA and vga16fb. You need to select=
=20
one driver only. They all conflict when they try to access the hardware.

On Thu, 3 Feb 2005, [utf-8] Pawe=C5^B Sikora wrote:

> >  > Hi,
> >  >=20
> >  > Could You look at this: http://lkml.org/lkml/2005/1/29/67
> >  > Help will be appreciated.
> >=20
> > From: James Simmons <jsimmons@ww...>
> > Re: [linux-2.6.10] radeonfb / oops  =20
> > 2005-02-01 12:54=20
> >=20
> > Can you post your config?
> > =20
> > On Tue, 1 Feb 2005, Pawel Sikora wrote:
> >=20
>=20
> I've tested kernel without grsec and fbsplash and it still oopses.
>=20
> --=20
> /* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. =
*/
>=20
>                            #define say(x) lie(x)
>=20


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
