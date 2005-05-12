From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Mapping the framebuffer into kernel space
Date: Thu, 12 May 2005 13:38:45 -0400
Message-ID: <9e47339105051210385a41e54e@mail.gmail.com>
References: <9e473391050428205517f3c8c0@mail.gmail.com>
	 <Pine.LNX.4.56.0505052141360.15586@pentafluge.infradead.org>
	 <9e4733910505051402789440db@mail.gmail.com>
	 <Pine.LNX.4.56.0505060046490.15586@pentafluge.infradead.org>
	 <9e47339105050517083fadaee0@mail.gmail.com>
	 <Pine.LNX.4.56.0505062008090.6914@pentafluge.infradead.org>
	 <9e47339105050615097bdfcdcb@mail.gmail.com>
	 <Pine.LNX.4.56.0505112345230.4268@pentafluge.infradead.org>
	 <Pine.LNX.4.62.0505121112320.15959@numbat.sonytel.be>
	 <Pine.LNX.4.56.0505121648020.19137@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DWHkW-0007j6-TC
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 May 2005 10:45:28 -0700
Received: from wproxy.gmail.com ([64.233.184.204])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DWHkU-00011f-A7
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 May 2005 10:45:28 -0700
Received: by wproxy.gmail.com with SMTP id 69so566981wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 12 May 2005 10:45:25 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0505121648020.19137@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@www.infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>

On 5/12/05, James Simmons <jsimmons@www.infradead.org> wrote:
>=20
> > > > Could you generically rewrite fb_read/write to just use the image b=
litter?
> > >
> > > Yes.
> >
> > No.
> >
> > The imageblit routines convert between chunked pixels and the actual fr=
ame
> > buffer representation.
> > fb_{read,write}() access the raw frame buffer.
>=20
> That means that we will never uses the hardware acceleration ever in this
> case :-( It will always be slow!!!!
>=20
> > Probably the best solution is to set up a small ioremap()'ed window tha=
t can be
> > moved in fb_{read,write}() (assumed moving such a window is much cheape=
r than
> > ioremap() + iounmap()).
>=20
> Does such functionality exist? Second can you do the same thing with
> request_region? We need to so fbcon and /dev/fb don't step on each other
> toes.

Before we get too far into this, has anyone determined if any user
space app exists that does read/write from fbdev? I can't see a real
need to keep this feature if no one is using it. If no one is using
it, it would be much simpler just to remove the functions.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
