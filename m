From: Luc Verhaegen <libv@skynet.be>
Subject: Re: [PATCH 06/20] vt8623fb: New framebuffer
	driver for VIA VT8623
Date: Sun, 6 May 2007 00:48:55 +0200
Message-ID: <20070505224855.GA18807@skynet.be>
References: <463C996A.9050005@gmail.com> <20070505181551.GB6016@sci.fi>
	<20070505200801.GA28014@localhost.localdomain>
	<20070505203450.GC6016@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkT3n-0000vu-Gt for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 15:49:03 -0700
Received: from outmx041.isp.belgacom.be ([195.238.6.178])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HkT3k-0003zp-Dr
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 15:49:03 -0700
Received: from outmx041.isp.belgacom.be (localhost.localdomain [127.0.0.1])
	by outmx041.isp.belgacom.be (8.13.4/8.13.4/Debian-3sarge3) with ESMTP
	id l45MmqxW017903 for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 6 May 2007 00:48:52 +0200
Content-Disposition: inline
In-Reply-To: <20070505203450.GC6016@sci.fi>
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
To: Ondrej Zajicek <santiago@crfreenet.org>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

On Sat, May 05, 2007 at 11:34:51PM +0300, Ville Syrj=E4l=E4 wrote:
> On Sat, May 05, 2007 at 10:08:01PM +0200, Ondrej Zajicek wrote:
> > On Sat, May 05, 2007 at 09:15:51PM +0300, Ville Syrj=E4l=E4 wrote:
> > > > +	vt8623fb - fbdev driver for graphics core in VIA VT8623 chipset
> > > > +	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > =

> > > Doesn't viafb support this hardware?
> > =

> > Yes, this hardware is supported by several out-of-tree drivers,
> > some of them are named viafb.
> =

> The "official" (ie. the one from via) was just posted here for inclusion.

You mean that tiny one which talks about GUEUEs and such?

Who plans on cleaning that one up? Who is prepared to see VIA just =

plough on regardless after that, just like VIA did with the X driver?

Luc Verhaegen.
http://unichrome.sf.net/

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
