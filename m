From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Comments on fbgen.c and fbcon-accel.c
Date: 08 May 2002 00:50:57 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1020811857.1473.442.camel@tibook>
References: <Pine.GSO.4.21.0205070953520.14470-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dclient217-162-21-227.hispeed.ch ([217.162.21.227] helo=tibook)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 175DnY-0005iv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 May 2002 15:51:08 -0700
In-Reply-To: <Pine.GSO.4.21.0205070953520.14470-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Antonino Daplas <adaplas@pol.net>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2002-05-07 at 10:00, Geert Uytterhoeven wrote:=20
> > > If it's really a problem, maybe we could figure out a way to detect w=
hen
> > > it's safe to optimize stuff away or as a last resort make it an optio=
n?
> > >=20
> > I think if the gen_* interface is to be adopted, it will become a
> > problem. Detection is the best solution, but right now X and DRI do not
> > know that fb even exist so we can't get X to detect fb unless we
> > persuade the X people to do that.  I have tried X detection before by
> > checking the previous console number.  If the previous number is not a
> > valid console, we can presume that a non-console app used that.  But
> > this is not clean and there are too many conditions where this check
> > will fail. But then, I really don't understand the underlying console
> > interface, so an easier and more effective way may exist that I don't
> > know about.
>=20
> The problem is that most drivers in XFree86 don't _want_ to be fbdev comp=
liant.
> The solution is to convince the hardcode anti-fbdev XFree86 guys to use t=
he
> fbdev if it's present. Fbdev is part of the kernel API. Circumventing the=
 API
> is bad behavior.

The opposition seems to be mostly against the fbdev support being spread
over the drivers, which is hard to maintain. If we could move it into an
common layer, there should be no problem. I do have the basic idea how
to do it but I suspect it would require changes to the driver interface
so it might have to wait for XFree86 5.x (provided anyone actually tries
:).


--=20
Earthling Michel D=E4nzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
