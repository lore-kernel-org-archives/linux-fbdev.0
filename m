From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: video dir reorg
Date: 16 Jan 2003 21:14:10 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042748050.11409.35.camel@thor>
References: <20030116035231.36507.qmail@web14910.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from netline-be1.netline.ch ([195.141.226.32])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ZGP2-00012z-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 16 Jan 2003 12:14:16 -0800
In-Reply-To: <20030116035231.36507.qmail@web14910.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: James Simmons <jsimmons@infradead.org>, Sven Luther <luther@dpt-info.u-strasbg.fr>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Don, 2003-01-16 at 04:52, Jon Smirl wrote:=20
>=20
> 1) We have two drivers for the same hardware. They
> should be sharing the same include files describing
> the hardware.

Might be a good idea.

> 2) Bug fixing, in some cases the same hardware bug
> would need to be fixed in two places.

Not sure about this, as I don't see much overlap, but it's plausible I
guess.

> 3) State saving.  When the virtual terminal is changed
> is the complete state of the DRM driver saved? What if
> one of the other virtual terminals plays with 3D mode?

A 3D driver (at least an OpenGL driver) needs to always keep track of
hardware state anyway, so after a VT switch it can just upload
everything it needs again.

> 4) DDC and secondary reset support. I was looking at
> adding this to some of the framebuffer drivers. The X
> driver can't share this code.

The framebuffer device could offer interfaces for these though?

> 5) General kernel config. The same peice of hardware
> appears in two different places.

For very different purposes. Anyway, couldn't the config hierarchy be
changed without moving code around, at least with Kconfig?


--=20
Earthling Michel D=E4nzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementi=
ng
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache=20
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
