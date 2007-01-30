From: Luca Tettamanti <kronos@people.it>
Subject: Re: [PATCH] nvidiafb: allow ignoring EDID info
Date: Tue, 30 Jan 2007 21:33:01 +0100
Message-ID: <20070130203301.GA15067@dreamland.darkstar.lan>
References: <ephv35$4i3$1@sea.gmane.org>
	<20070128160831.fb51347f.akpm@osdl.org>
	<21d7e9970701281612q56b694edp6efd1a5556dea3fe@mail.gmail.com>
	<20070128162907.370f5476.akpm@osdl.org>
	<21d7e9970701281639w57edc2efw4ba620d4c1bdcee7@mail.gmail.com>
	<cb7bb73a0701290637q2ce0ff16t28f82d0c0339a2ba@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBzq5-0006jU-HH for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 12:44:25 -0800
Received: from jack.tiscali.it ([213.205.33.53])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBzq2-0000jR-Rw
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 12:44:25 -0800
Content-Disposition: inline
In-Reply-To: <cb7bb73a0701290637q2ce0ff16t28f82d0c0339a2ba@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org

Il Mon, Jan 29, 2007 at 03:37:22PM +0100, Giuseppe Bilotta ha scritto: 
> On 1/29/07, Dave Airlie <airlied@gmail.com> wrote:
> > > > > Because most users won't even be aware of the module option: they'll just
> > > > > know that their card doesn't work right.
> > > >
> > > > This isn't a card problem this is a monitor problem, the card just
> > > > passes through the edid data from the monitor... or else the
> > > > programming of the card registers from edid is wrong..
> > >
> > > In which case the same problem would occur with different video cards, so
> > > this patch should be some generic thing, available to all drivers, no?
> >
> > It should be in the fb layer not card specific.. as it may happen on any card...
> 
> Although solving the problem at the fb layer level is probably the
> correct/best way to do it, I am not aware of people having problems
> with broken EDIDs and non-nVidia cards. By contrast, workarounds for
> nVidia and broken EDIDs is a very common thing to do even on Windows.

Not all drivers have support for reading EDID information, so in many
cases it just "works". My old monitor had garbage in the EDID eeprom and
I had to pass "ignore_edid" to radeonfb (before I reprogrammed the
eeprom that is :P).

> Plus, providing an fb-layer-level solution is way beyond my kernel
> programming experience :)

I'll try to code something in the weekend.

Luca
-- 
Do, or do not. There is no try.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
