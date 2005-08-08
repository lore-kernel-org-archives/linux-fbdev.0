From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Re: [PATCH] mach64 atari patch
Date: Mon, 8 Aug 2005 14:34:23 -0400
Message-ID: <9e473391050808113479fa1501@mail.gmail.com>
References: <Pine.LNX.4.56.0508070315260.12196@pentafluge.infradead.org>
	 <Pine.LNX.4.62.0508071316230.31010@gorilla.sonytel.be>
	 <20050807094618.0cc4cadc.akpm@osdl.org>
	 <Pine.LNX.4.56.0508080003360.12912@pentafluge.infradead.org>
	 <42F699DC.20103@gmail.com> <9e47339105080716487e59df5c@mail.gmail.com>
	 <Pine.LNX.4.56.0508081827550.27739@pentafluge.infradead.org>
	 <9e4733910508081056714061fe@mail.gmail.com>
	 <Pine.LNX.4.56.0508081907150.27739@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2CSH-0005jr-LK
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Aug 2005 11:34:33 -0700
Received: from wproxy.gmail.com ([64.233.184.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E2CSH-0002l7-CW
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Aug 2005 11:34:33 -0700
Received: by wproxy.gmail.com with SMTP id i8so1045030wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 08 Aug 2005 11:34:23 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0508081907150.27739@pentafluge.infradead.org>
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

On 8/8/05, James Simmons <jsimmons@infradead.org> wrote:
>=20
> > > > I just don't think this patch is as complex as you are making it ou=
t
> > > > to be. It is large simply because the same action has been repeated
> > > > for each of the 65 drivers. The action is only a simple deletion of
> > > > two lines.
> > >
> > > I'm not arguing over this. What is wrong with breaking this patch up!=
!!!!
> > > I still have no answer to this!!!! I'm using the hardware flag becaus=
e
> > > sometimes the driver that does have a hardware cursor wants to turn
> > > support off for it.
> >
> > Set  .fb_cursor =3D NULL; to turn off the support.
>=20
> So forbid hardware drivers that support hware cursors to never turn off
> there hardware cursor support!!!!!
>=20
> Let see what drivers have a flag to control using the hardware cursor.
>=20
> au1100fb        int nohwcursor
> intelfb         int hwcursor
> nvidia          int hwcur
> cyberfb
>=20
> You need to remove this!!!!
>=20
> What I am arguing is that drivers with hardware cursor support should be
> able to turn off and on hardware cursor support. That is why the
> HWACCEL_CURSOR flag. Your test the fb_cursor field prevents this!!!

If you want fbconsole to use the software cusor instead of the
hardware cursor, that's between you and fbconsole to decide. Control
over that choice needs to be in fbconsole, not the base fbdev.

The fbdev drivers should just unconditionally offer the hardware
cursor if they support it. It is up to the user of the cursor to
choose whether to use it or ignore it.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
