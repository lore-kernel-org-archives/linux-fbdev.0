From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [PATCH] Tile Blitting
Date: 28 Feb 2003 05:47:04 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046382371.2768.36.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0302270056200.16050-100000@phoenix.infradead.org>
	<1046355210.1206.42.camel@localhost.localdomain> 
	<1046370303.12970.27.camel@thor>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18oVr1-0007Po-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Feb 2003 13:46:11 -0800
In-Reply-To: <1046370303.12970.27.camel@thor>
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
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2003-02-28 at 02:25, Michel D=E4nzer wrote:
> On Don, 2003-02-27 at 15:15, Antonino Daplas wrote:=20
> > On Thu, 2003-02-27 at 09:18, James Simmons wrote:
> > =20
> > > > Thus, the restriction that the buffer must be completely copied by =
the
> > > > driver before returning.  And because of this restriction, an extra=
 copy
> > > > which might be unnecessary cannot be avoided (this was noted by Pet=
r).
> > > >=20
> > > > Treating the buffer as a ringbuffer, we eliminate these restriction=
s.
> > >=20
> > > I didn't realize that the below was a ringbuffer implementation. The =
name
> > > threw me off.=20
> >=20
> > Well, it's not strictly a ringbuffer implementation.  This would requir=
e
> > a head and tail pointer where fbcon will adjust the tail and the
> > driver/hardware will adjust the head.  This will be very difficult to
> > implement in a device independent manner.  So we just cheat by issuing
> > an fb_sync() per loop to flush all pending commands.
>=20
> That still seems suboptimal though. What the DRM often does is have the
> chip write an age value to a scratch register when it's done processing
> something. Maybe something like that could be used to avoid waiting for
> the chip to go idle at all?
>=20

Yes, it is certainly suboptimal. But the fb_sync() will be done only
when the pointer wraps to the beginning of the buffer and only if the
buffer can be DMA'd by the chip.

To support these types of buffers, we can change pixmap.offset to head
and tail. The buffer is empty when head =3D=3D tail.  Then, fbcon
continually adjusts the tail to tail+size, and when the chip is done
processing that particular bitmap, it will adjust the head to
head+size.  Then instead of doing an fb_sync(), fbcon will just busy
loop waiting for the buffer to have enough space for the next set of
bitmaps.

This will involve per chipset support, the reason why I did not do it
like this.  It can be added, but it will not be default behavior.

PS:  I remember that practically all drivers do some form of syncing
before each operation, and no one complained :-).

Tony =20
=20




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
