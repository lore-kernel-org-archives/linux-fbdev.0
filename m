From: Fredrik Noring <noring@nocrew.org>
Subject: Re: [PATCH] rivafb sync polarity problem?
Date: 19 Jan 2003 17:55:30 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042995331.1071.23.camel@localhost.localdomain>
References: <1042980943.12192.34.camel@h9n1fls20o980.telia.com> 
	<1042993221.978.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailg.telia.com ([194.22.194.26])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18aIiR-0003d3-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 19 Jan 2003 08:54:35 -0800
In-Reply-To: <1042993221.978.4.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Ani Joshi <ajoshi@shell.unixbox.com>

s=F6n 2003-01-19 klockan 17.25 skrev Antonino Daplas:
> The dotclock should be in picoseconds.  The above will translate to
> roughly 16MHz only.

Yep. The corresponding modeline in XFree86 4.2 is:

  Modeline "768x288" 16.0 768 848 902 1022 288 290 292 312 -hsync -vsync

It's a mode designed for regular PAL TV output (through RGB-SCART) and
it works excellent with XFree86 4.2. The corresponding modeline for NTSC
looks like this:

  Modeline "768x240" 16.0 768 848 902 1022 240 243 244 261 -hsync -vsync

Hopefully, rivafb will support interlace some day and then these
modelines will also work:

  ModeLine "768x485" 16.0 768 848 902 1022 485 491 496 525 -hsync -vsync in=
terlace
  ModeLine "768x576" 16.0 768 848 902 1022 576 580 585 625 -hsync -vsync in=
terlace

(PAL and NTSC respectively.)

For some reason, rivafb will not render any of these modes properly a.t.m.

	Fredrik




-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
