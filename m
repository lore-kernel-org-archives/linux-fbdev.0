From: James Simmons <jsimmons@infradead.org>
Subject: Re: no backlight on radeon after recent kernel
	"upgrade"s
Date: Thu, 22 Feb 2007 16:00:16 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702221558550.29542@pentafluge.infradead.org>
References: <20070219044616.GC25659@washoe.onerussian.com> 
	<20070219000412.acad13de.akpm@linux-foundation.org> 
	<1171876788.6046.3.camel@localhost.localdomain>
	<877iub9mu2.fsf@sycorax.lbl.gov>
	<1172097718.5790.29.camel@localhost.localdomain>
	<20070221231706.GA3336@khazad-dum.debian.net>
	<1172103159.5790.45.camel@localhost.localdomain>
	<20070222005122.GA7928@khazad-dum.debian.net>
	<20070222011017.GA8845@khazad-dum.debian.net>
	<1172138450.5837.34.camel@localhost.localdomain>
	<20070222145613.GD25887@khazad-dum.debian.net>
	<1172157592.5837.89.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKGN2-0005MN-RR for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 08:00:37 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HKGMy-0000GL-Fq
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 08:00:33 -0800
In-Reply-To: <1172157592.5837.89.camel@localhost.localdomain>
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
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, Alex Romosan <romosan@sycorax.lbl.gov>, linux-kernel@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Yaroslav Halchenko <kernel@onerussian.com>, Andrew Morton <akpm@linux-foundation.org>


> > Howerver, I *do* strongly wish for a way to combine various drivers into a
> > single backlight device, where radeon/intelfb takes care of some stuff,
> > ibm-acpi/asus-laptop/sony-laptop takes care of other stuff, etc.  Also, a
> > standard naming for the builtin screen(s) would help, calling it "ibm",
> > "asus", "sony" is not good IMHO.
> 
> I wasn't aware of this problem. If some devices need bits from both
> raedon/whatever and acpi, the current implementations are just plain
> wrong. Its not really a backlight class problem and more of an
> implementation and interaction problem between acpi and the framebuffer
> drivers. They should be presenting and registering *one* backlight class
> device, not two. Without knowing more about the circumstances and
> how/when to combine which drivers its hard for me to help further...

This is always been a problem. For the fbdev layer you can run vesafb with 
a specific fbdev driver and they both access the same hardware. There is 
no really way around this. The user has to be smart enough to not enable 
bothe drivers.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
