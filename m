From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Comments on fbgen.c and fbcon-accel.c
Date: 07 May 2002 09:34:24 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1020735317.761.1.camel@daplas>
References: <Pine.LNX.4.10.10205031444260.9732-100000@www.transvirtual.com>
	<1020535355.797.0.camel@daplas>  <1020723899.2536.7357.camel@tibook>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 174tt0-0001N1-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 06 May 2002 18:35:26 -0700
In-Reply-To: <1020723899.2536.7357.camel@tibook>
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
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2002-05-07 at 06:24, Michel D=E4nzer wrote:
> On Sat, 2002-05-04 at 20:01, Antonino Daplas wrote:=20
> > On Sat, 2002-05-04 at 05:47, James Simmons wrote:
> > >=20
> > > > I have a few observations on fbgen and fbcon-accel.
> >=20
> > One more thing I've noticed with gen_set_var.  Basically, gen_set_var
> > will proceed if it satisfies 2 conditions -- during initialization (con
> > < 0) and if the new var is different from the old var. =20
> >=20
> > The above is fine if everything is done in the console.  However,
> > problems may arise if an app that touches the graphics hardware (ie X)
> > is launched.  From the point of view of fbcon, the hardware state hasn'=
t
> > changed (compare of newvar with oldvar is false) when display is
> > switched back to console.  And if that app did not fully restore the
> > hardware state,  we will be left with a corrupted display.
> >=20
> > So, it's probably better if set_par() and pan_display() are allowed to
> > proceed unconditionally within gen_set_var.  It might take a few more
> > milliseconds to switch consoles each time, but we are assured that the
> > hardware state is always coherent with the current var.
> >=20
> > What do you think?
>=20
> I think this is giving away an advantage. The X server is a bad example
> as it can use the framebuffer device fine.
I was talking of X running with it's own accelerated drivers.  I have
checked most of the X accelerated drivers, and most will just attempt to
restore the VGA registers and some when switching to the console.  I
think this is not just enough, since fb drivers require more than that.=20
Simiarly, I have also looked at some of the fbdev drivers that are not
using the gen_* interface (nvidia, ati, matrox), and they will also
unconditially set the hardware during switches/set_var. The
fbgen_switch() function also calls fbhw->set_par() within do_set_var().
>=20
> If it's really a problem, maybe we could figure out a way to detect when
> it's safe to optimize stuff away or as a last resort make it an option?
>=20
I think if the gen_* interface is to be adopted, it will become a
problem. Detection is the best solution, but right now X and DRI do not
know that fb even exist so we can't get X to detect fb unless we
persuade the X people to do that.  I have tried X detection before by
checking the previous console number.  If the previous number is not a
valid console, we can presume that a non-console app used that.  But
this is not clean and there are too many conditions where this check
will fail. But then, I really don't understand the underlying console
interface, so an easier and more effective way may exist that I don't
know about.

Tony



_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
