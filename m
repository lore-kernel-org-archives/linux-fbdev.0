From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Choosing the correct framebuffer configuration
Date: Sun, 7 Aug 2005 12:53:01 -0400
Message-ID: <9e47339105080709537a8064bb@mail.gmail.com>
References: <9e473391050805184756f055ea@mail.gmail.com>
	 <Pine.LNX.4.62.0508071145100.31010@gorilla.sonytel.be>
	 <9e473391050807083327b190f9@mail.gmail.com>
	 <1123430435.3848.332.camel@localhost>
	 <1123431300.30257.116.camel@gaston>
	 <1123432349.3978.335.camel@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1oOa-00057f-LB
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 09:53:08 -0700
Received: from wproxy.gmail.com ([64.233.184.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1oOa-0000k5-Ke
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 09:53:08 -0700
Received: by wproxy.gmail.com with SMTP id i17so407125wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Aug 2005 09:53:01 -0700 (PDT)
In-Reply-To: <1123432349.3978.335.camel@localhost>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

On 8/7/05, Michel D=E4nzer <michel@daenzer.net> wrote:
> On Sun, 2005-08-07 at 18:14 +0200, Benjamin Herrenschmidt wrote:
> > > > The problem is that the radeonfb driver sees bpp =3D 32 and then se=
ts
> > > > rgbt =3D 8/8/8/8. It stomps rgbt without looking at it.
> > >
> > > Looks like a radeonfb bug.
> >
> > It's not a bug :) radeonfb doesn't support anything but that format for
> > now.
>=20
> According to Geert's rules, it should fail instead of rounding down
> r/g/b.

One problem with these rules is that it makes it hard to determine
what is the best config available. I can't just set in 255BPP and then
let it tell me the best available config.

What config should I get if everything is zero, BPP and rgbt?
According to the rules this is an error, should it instead return the
best config?

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
