From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Re: [PATCH] mach64 atari patch
Date: Mon, 8 Aug 2005 15:07:51 -0400
Message-ID: <9e4733910508081207104f08d1@mail.gmail.com>
References: <Pine.LNX.4.56.0508070315260.12196@pentafluge.infradead.org>
	 <Pine.LNX.4.56.0508080003360.12912@pentafluge.infradead.org>
	 <42F699DC.20103@gmail.com> <9e47339105080716487e59df5c@mail.gmail.com>
	 <Pine.LNX.4.56.0508081827550.27739@pentafluge.infradead.org>
	 <9e4733910508081056714061fe@mail.gmail.com>
	 <Pine.LNX.4.56.0508081907150.27739@pentafluge.infradead.org>
	 <9e473391050808113479fa1501@mail.gmail.com>
	 <Pine.LNX.4.56.0508081939260.27739@pentafluge.infradead.org>
	 <9e473391050808120111ee33ee@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2g58-00004z-Pq
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 19:12:38 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E2g58-0002gk-Cz
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 19:12:38 -0700
Received: from wproxy.gmail.com ([64.233.184.203])
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1E2ElB-0008LB-DQ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Aug 2005 14:02:14 -0700
Received: by wproxy.gmail.com with SMTP id i8so1072920wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 08 Aug 2005 14:02:06 -0700 (PDT)
In-Reply-To: <9e473391050808120111ee33ee@mail.gmail.com>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, Andrew Morton <akpm@osdl.org>

On 8/8/05, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 8/8/05, James Simmons <jsimmons@infradead.org> wrote:
> >
> > > > au1100fb        int nohwcursor
> > > > intelfb         int hwcursor
> > > > nvidia          int hwcur
> > > > cyberfb
> > > >
> > > > You need to remove this!!!!
> > > >
> > > > What I am arguing is that drivers with hardware cursor support shou=
ld be
> > > > able to turn off and on hardware cursor support. That is why the
> > > > HWACCEL_CURSOR flag. Your test the fb_cursor field prevents this!!!
> > >
> > > If you want fbconsole to use the software cusor instead of the
> > > hardware cursor, that's between you and fbconsole to decide. Control
> > > over that choice needs to be in fbconsole, not the base fbdev.
> > >
> > > The fbdev drivers should just unconditionally offer the hardware
> > > cursor if they support it. It is up to the user of the cursor to
> > > choose whether to use it or ignore it.
> >
> > Finally you see the point I was making. I wanted it be very clear to ev=
ery
> > one here the implications of your changes. You remove the power to cont=
rol
> > the use of a hardware cursor from the driver. At this point driver writ=
ers
> > need to speak up if they have no problem with this.
>=20
> I'm not working on fbconsole so it did not occur to me what your
> issues was. My user space apps have always had control of whether they
> used the hardware cursor or not.
>=20
> You will need to ask Tony for a switch. Easiest way is to make it a
> module parameter on fbconsole. That way it will appear in
> /sys/module/fbconsole/parameters and you can use echo to set it from a
> script. There is no need for an ioctl.

Personally I am not in favor of building hundreds of switches like
this into the kernel. If the hardware cursor doesn't work it should
either be fixed or disabled in the fbdev driver.  If you take that
philosophy there is no need for a switch on fbconsole.

I really don't like the "if it doesn't work for you here's how to turn
if off" switches. All they do is hide bugs.

>=20
> It only takes about five lines of code to implement this, something like =
this...
>=20
> fbconsole.c
>=20
> int use_hw_cursor =3D 0;
> module_parm(use_hw_cursor);
>=20
> if (fb_info->fb_cursor && use_hw_cursor)
>   fb_info->fb_cursor(...)
> else
>   softcursor
>=20
> >
> > P.S
> >         The patch still needs to broken into smaller pieces.
> >
> >
> >
>=20
>=20
> --
> Jon Smirl
> jonsmirl@gmail.com
>=20


--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
