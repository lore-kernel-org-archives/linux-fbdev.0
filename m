From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [linux-2.6.10] radeonfb / oops
Date: Fri, 04 Feb 2005 16:59:53 +1100
Message-ID: <1107496794.2362.90.camel@gaston>
References: <200502030925.09942.pluto@pld-linux.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CwwWW-0001kr-QG
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Feb 2005 22:00:56 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CwwWV-0002yX-AF
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Feb 2005 22:00:56 -0800
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j145qVgJ005097
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 3 Feb 2005 23:52:32 -0600
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
Content-Type: text/plain; charset="iso-8859-1"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2005-02-03 at 09:25 +0100, Pawe=B3 Sikora wrote:
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
> plain text document attachment (.config)

You seem to have built both the old and new radeonfb's ... can you
remove the old one ?

Ben.





-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
