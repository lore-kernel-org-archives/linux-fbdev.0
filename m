From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Comments on fbgen.c and fbcon-accel.c
Date: 07 May 2002 00:24:59 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1020723899.2536.7357.camel@tibook>
References: <Pine.LNX.4.10.10205031444260.9732-100000@www.transvirtual.com>
	<1020535355.797.0.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dclient217-162-21-227.hispeed.ch ([217.162.21.227] helo=tibook)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 174qv2-0003wt-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 06 May 2002 15:25:20 -0700
In-Reply-To: <1020535355.797.0.camel@daplas>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Antonino Daplas <adaplas@pol.net>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2002-05-04 at 20:01, Antonino Daplas wrote:=20
> On Sat, 2002-05-04 at 05:47, James Simmons wrote:
> >=20
> > > I have a few observations on fbgen and fbcon-accel.
>=20
> One more thing I've noticed with gen_set_var.  Basically, gen_set_var
> will proceed if it satisfies 2 conditions -- during initialization (con
> < 0) and if the new var is different from the old var. =20
>=20
> The above is fine if everything is done in the console.  However,
> problems may arise if an app that touches the graphics hardware (ie X)
> is launched.  From the point of view of fbcon, the hardware state hasn't
> changed (compare of newvar with oldvar is false) when display is
> switched back to console.  And if that app did not fully restore the
> hardware state,  we will be left with a corrupted display.
>=20
> So, it's probably better if set_par() and pan_display() are allowed to
> proceed unconditionally within gen_set_var.  It might take a few more
> milliseconds to switch consoles each time, but we are assured that the
> hardware state is always coherent with the current var.
>=20
> What do you think?

I think this is giving away an advantage. The X server is a bad example
as it can use the framebuffer device fine.

If it's really a problem, maybe we could figure out a way to detect when
it's safe to optimize stuff away or as a last resort make it an option?


--=20
Earthling Michel D=E4nzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
