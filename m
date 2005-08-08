From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] Don't allow softcursor use from userland
Date: Mon, 8 Aug 2005 13:59:50 -0400
Message-ID: <9e47339105080810595158e822@mail.gmail.com>
References: <Pine.LNX.4.56.0508070327550.12196@pentafluge.infradead.org>
	 <42F5E3E7.3020901@gmail.com>
	 <Pine.LNX.4.56.0508080013400.12912@pentafluge.infradead.org>
	 <42F6AE75.6090409@gmail.com>
	 <Pine.LNX.4.56.0508081831220.27739@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2Bup-0003wL-LS
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Aug 2005 10:59:59 -0700
Received: from wproxy.gmail.com ([64.233.184.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E2Buo-0001Gz-K5
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Aug 2005 10:59:59 -0700
Received: by wproxy.gmail.com with SMTP id i17so586711wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 08 Aug 2005 10:59:50 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0508081831220.27739@pentafluge.infradead.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>

On 8/8/05, James Simmons <jsimmons@infradead.org> wrote:
>=20
>=20
> What is wrong with brekaing this patch into smaller pieces????????????
> I'm not getting a answer!!!!! As I said no giant patches that tocuh every
> driver.
>=20
> > > has software image blit and hardware fillrect. You want to have fbcon=
 use
> > >
> >
> > Then the driver sets fbops->fb_cursor with its own version that does
> > fillrect instead of imageblit.
>=20
> No. fb_cursor is only used for a hardware cursor case.
>=20
> > If you want to add userspace support for hardware cursors then you have=
 to
> > create another API. If you don't want another API, then forget about us=
erspace
> > support. Overloading fbops->fb_cursor is not the answer.
>=20
> So fbops->fb_cursor will not be used at all for the console?

fbconsole check to see if fbops->fb_cursor is not null, if it is not
null it uses the hardware cursor. Otherwise it uses it's internal
softcursor implementation.

>=20
> Look the patch I sent is small and doesn't interfere with many drivers. I=
t
> does stop your desires either. Personally softcursor should go away.
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>=20


--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
