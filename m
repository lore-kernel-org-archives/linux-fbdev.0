From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] Tile Blitting
Date: 27 Feb 2003 19:25:03 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046370303.12970.27.camel@thor>
References: <Pine.LNX.4.44.0302270056200.16050-100000@phoenix.infradead.org>
	 <1046355210.1206.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from netline-be1.netline.ch ([195.141.226.32])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18oSiS-0001Kc-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Feb 2003 10:25:08 -0800
In-Reply-To: <1046355210.1206.42.camel@localhost.localdomain>
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
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Don, 2003-02-27 at 15:15, Antonino Daplas wrote:=20
> On Thu, 2003-02-27 at 09:18, James Simmons wrote:
> =20
> > > Thus, the restriction that the buffer must be completely copied by the
> > > driver before returning.  And because of this restriction, an extra c=
opy
> > > which might be unnecessary cannot be avoided (this was noted by Petr).
> > >=20
> > > Treating the buffer as a ringbuffer, we eliminate these restrictions.
> >=20
> > I didn't realize that the below was a ringbuffer implementation. The na=
me
> > threw me off.=20
>=20
> Well, it's not strictly a ringbuffer implementation.  This would require
> a head and tail pointer where fbcon will adjust the tail and the
> driver/hardware will adjust the head.  This will be very difficult to
> implement in a device independent manner.  So we just cheat by issuing
> an fb_sync() per loop to flush all pending commands.

That still seems suboptimal though. What the DRM often does is have the
chip write an age value to a scratch register when it's done processing
something. Maybe something like that could be used to avoid waiting for
the chip to go idle at all?


--=20
Earthling Michel D=E4nzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
