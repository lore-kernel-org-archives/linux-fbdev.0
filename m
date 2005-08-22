From: Richard Smith <smithbone@gmail.com>
Subject: Re: mono, gray and index configs
Date: Mon, 22 Aug 2005 08:30:51 -0500
Message-ID: <8a0c3678050822063073c3f4f6@mail.gmail.com>
References: <9e47339105081020216574ac7e@mail.gmail.com>
	 <42FAE3F8.8080902@gmail.com>
	 <Pine.LNX.4.62.0508111020520.1037@numbat.sonytel.be>
	 <b00ca3bd05081104086fa9e639@mail.gmail.com>
	 <Pine.LNX.4.62.0508111344070.1037@numbat.sonytel.be>
	 <42FB8C29.4070503@gmail.com>
	 <9e47339105081112142c67e1a8@mail.gmail.com> <43069BE0.80604@gmail.com>
	 <9e473391050819200950020d7@mail.gmail.com>
	 <Pine.LNX.4.62.0508221203410.24432@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E7COB-000347-Df
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Aug 2005 06:30:59 -0700
Received: from zproxy.gmail.com ([64.233.162.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E7COA-0001es-7o
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Aug 2005 06:30:59 -0700
Received: by zproxy.gmail.com with SMTP id s18so629433nze
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Aug 2005 06:30:51 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0508221203410.24432@numbat.sonytel.be>
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
Cc: Jon Smirl <jonsmirl@gmail.com>, "Antonino A. Daplas" <adaplas@gmail.com>

> > This adds an optional function to each driver that advertises what
> > configs it offers.
> >
>=20
> Do we really need this?
>=20
> You can easily write a `probe loop' to find out about all supported confi=
gs for
> a driver like this:
>=20
>     for_all_possible_configs(config) {
>         struct fb_var_screeninfo var;

This will actually try to set the mode right?

SDL does it this way and its caused me some pain dealing with
framebuffers on hardware that has issues with certain modes.  Its also
a good bit slower for the app to startup while the code crunches out
the pll settings.

From a users perspective I think advertising valid modes is a good thing.

--=20
Richard A. Smith


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
