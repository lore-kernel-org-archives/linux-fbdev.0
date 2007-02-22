From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: no backlight on radeon after recent kernel
	"upgrade"s
Date: Thu, 22 Feb 2007 09:46:05 +0000
Message-ID: <1172137565.5837.24.camel@localhost.localdomain>
References: <20070219044616.GC25659@washoe.onerussian.com>
	<20070219000412.acad13de.akpm@linux-foundation.org>
	<1171876788.6046.3.camel@localhost.localdomain>
	<20070221055648.GM25659@washoe.onerussian.com>
	<1172104471.5790.57.camel@localhost.localdomain>
	<Pine.LNX.4.64.0702220054460.17121@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKAWr-00019O-PQ for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 01:46:22 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HKAWq-0003qR-1Q
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 01:46:21 -0800
In-Reply-To: <Pine.LNX.4.64.0702220054460.17121@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Yaroslav Halchenko <lists@onerussian.com>

On Thu, 2007-02-22 at 01:07 +0000, James Simmons wrote:
> > # CONFIG_FB_RIVA_BACKLIGHT is not set
> > # CONFIG_FB_RADEON_BACKLIGHT is not set
> > 
> > I suspect these options only work on certain hardware and aren't
> > generic. James, any idea what hardware these do/don't work with?
> > 
> > Worst case, we set them to depend on PMAC_BACKLIGHT again I guess...
> 
>    Ug. Previously it did the selecting for you. If you selected 
> backlight support the fbdev backlight would just come to life. This caused 
> problems for the case of having ACPI backlight and a fbdev driver with 
> backlight support. Two drivers controling the same hardware is not the
> greatest idea. I made it so that people explictly had to pick the backlight
> with a fbdev device. The other reason for this change was not every 
> one is using a LCD display. I have a system at home that uses a CRT. 
>    Plus their is the case of "standard" PC graphics cards being used 
> in embedded devices. In this case even tho the graphics card has backlight 
> support the external lcd/backlight is routed through gpio independent of 
> the embedded graphics card. In such case we don't want to enable the
> backlight for the graphics card but enable it.
>     In a nut shell the solution is select the backlight support for your
> fbdev driver if you need it.

This is ugly for distribution maintainers as pick the wrong Kconfig
options and your device breaks. You need a different build depending on
the hardware you have. 

I understand some people need to be able to turn these things on but it
sounds like the majority of users don't need it and it will break things
for them. The config option sounds tempting to them though...

In case anyone else is wondering, the commit in question is
http://git.o-hand.com/?p=linux-rpurdie-backlight;a=commitdiff;h=e0e34ef7f02915cfe50e501e9f32c24217177a96
and previously, all the appropriate entries had "depends PMAC_BACKLIGHT"

I think the way forward is going to be to have the backlights disabled
by default at runtime and require enabling through a framebuffer module
parameter. The should be enabled by default in the PMAC_BACKLIGHT case.
Anyone needing it can then pass the appropriate parameter. Does that
sound like the best solution?

Cheers,

Richard


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
