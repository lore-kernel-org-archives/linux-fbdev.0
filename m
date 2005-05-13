From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Mapping the framebuffer into kernel space
Date: Fri, 13 May 2005 16:56:11 -0400
Message-ID: <9e47339105051313562e4ba63b@mail.gmail.com>
References: <9e473391050428205517f3c8c0@mail.gmail.com>
	 <Pine.LNX.4.56.0505062008090.6914@pentafluge.infradead.org>
	 <9e47339105050615097bdfcdcb@mail.gmail.com>
	 <Pine.LNX.4.56.0505112345230.4268@pentafluge.infradead.org>
	 <Pine.LNX.4.62.0505121112320.15959@numbat.sonytel.be>
	 <Pine.LNX.4.56.0505121648020.19137@pentafluge.infradead.org>
	 <9e47339105051210385a41e54e@mail.gmail.com>
	 <Pine.LNX.4.62.0505122151530.16269@numbat.sonytel.be>
	 <9e473391050512131268248c3f@mail.gmail.com>
	 <Pine.LNX.4.56.0505132134320.10736@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DWhCj-0001ei-Ui
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 13 May 2005 13:56:17 -0700
Received: from wproxy.gmail.com ([64.233.184.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DWhCi-0008R6-HX
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 13 May 2005 13:56:17 -0700
Received: by wproxy.gmail.com with SMTP id 69so1003586wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 13 May 2005 13:56:12 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0505132134320.10736@pentafluge.infradead.org>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@pentafluge.infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>

On 5/13/05, James Simmons <jsimmons@www.infradead.org> wrote:
>=20
> > > > Before we get too far into this, has anyone determined if any user
> > > > space app exists that does read/write from fbdev? I can't see a rea=
l
> > > > need to keep this feature if no one is using it. If no one is using
> > > > it, it would be much simpler just to remove the functions.
> > >
> > > I think the only programs really using this are some screenshot progr=
ams, like
> > > cfb8toppm (which I wrote as a frame buffer sample program many years =
ago),
> > > fbshot, and fbgrap (in Debian).
> > >
> > > Of course these can be converted to use mmap().
> >
> > Seems to me that it would be easier to drop the feature and update the =
apps.
>=20
> Since you are in a hurry why not just create a write and a read function
> for radeon that just returns EINVAL. There are hooks in fb_info for this.

There is no hurry, radeonfb is already not mapping the entire
framebuffer. But we should make a decision on this and implement it
consistently going forward.

Summary of my points:
1) kernel x86 address space is 1GB
2) ATI is shipping 512MB cards, with 1GB cards planned
3) mapping the entire framebuffer in to kernel space is probably
impossible on x86
4) fbconsole can do it's own map for the limited piece it needs
5) that leaves fb_read/fb_write. I propose eliminating them and
removing the ability to read/write the framebuffer from the fbdev
device. Then fix up the few apps using read/write to use mmap instead.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
