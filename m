From: Luca Tettamanti <kronos@people.it>
Subject: Re: [PATCH] nvidiafb: allow ignoring EDID info
Date: Sat, 17 Feb 2007 19:14:13 +0100
Message-ID: <20070217181413.GA10134@dreamland.darkstar.lan>
References: <20070130203301.GA15067@dreamland.darkstar.lan>
	<20070204201713.GA12867@dreamland.darkstar.lan>
	<cb7bb73a0702041317u4ca2fbabp45cf56526e57c982@mail.gmail.com>
	<20070205201824.GA13431@dreamland.darkstar.lan>
	<cb7bb73a0702051328n50c889d9o461ac2bb9f9ea75e@mail.gmail.com>
	<Pine.LNX.4.64.0702062118450.9224@pentafluge.infradead.org>
	<20070207234837.GA27822@dreamland.darkstar.lan>
	<cb7bb73a0702071619p5984c39fs16e3d05c11d45585@mail.gmail.com>
	<20070211181743.GA15801@dreamland.darkstar.lan>
	<cb7bb73a0702130125r25ddfe33na48ae673d5ce60ae@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HIU5a-0004ou-0l for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 17 Feb 2007 10:15:15 -0800
Received: from joe.tiscali.it ([213.205.33.54])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HIU5W-0000nj-Sn
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 17 Feb 2007 10:15:13 -0800
Content-Disposition: inline
In-Reply-To: <cb7bb73a0702130125r25ddfe33na48ae673d5ce60ae@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Dave Airlie <airlied@gmail.com>, James Simmons <jsimmons@infradead.org>, linux-kernel@vger.kernel.org

Il Tue, Feb 13, 2007 at 10:25:41AM +0100, Giuseppe Bilotta ha scritto: =

> On 2/11/07, Luca Tettamanti <kronos@people.it> wrote:
> >Sorry for the delay.
> =

> Ditto!
> =

> It also seemed that my kernel compiling sk1llz had gone AWL, I
> couldn't get the newly compiled kernel to run, until I realized the
> initrd.img was mislinked. Anyway.
> =

> Your patch has an immediately visible effect of reducing snow: it
> seems that now that you fixed the access bug the EDID is properly
> /not/ used. dmesg | grep nvidiafb now claims the following:
> =

> """
> =

> nvidiafb: Device ID: 10de0112
> nvidiafb 0000:01:00.0: Unable to read EDID block.
> nvidiafb 0000:01:00.0: Unable to read EDID block.
> nvidiafb 0000:01:00.0: Unable to read EDID block.
> =

> (it actually gave the "I2C probe failed ..." message on console, but
> it's not appearing in the dmesg, obviously, since it's a simple
> printk)
> =

> nvidiafb 0000:01:00.0: Unable to read EDID block.
> nvidiafb 0000:01:00.0: Unable to read EDID block.
> nvidiafb 0000:01:00.0: Unable to read EDID block.
> nvidiafb: CRTC 1 is currently programmed for DFP
> nvidiafb: Using DFP on CRTC 1
> nvidiafb: Panel size is 1600 x 1200
> nvidiafb: Panel is TMDS
> nvidiafb: MTRR set to ON
> nvidiafb: Flat panel dithering disabled
> nvidiafb: PCI nVidia NV11 framebuffer (32MB @ 0xE0000000)
> =

> """

Ok, now I'm confused O_o
The patch should be correct, but I fail to see how EDID reading succeded
before.

> So the EDID still seems to be totally inaccessible (which means I
> can't really tell why/when/where it's b0rked).
> =

> Finally, as I mentioned, console still has a little snow. It's barely
> perceptible in common console usage because the monitor is mostly
> black, but can get annoying with fullscreen apps =E0 la mc.

Maybe the snow was caused by the driver hammering the I2C bus. Just
guessing...

Can you send me X.org log?

Luca
-- =

Alcuni pensano che io sia una persona orribile, ma non e` vero. Ho il
cuore di un ragazzino - in un vaso sulla scrivania.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
