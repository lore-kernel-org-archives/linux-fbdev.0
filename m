From: James Simmons <jsimmons@infradead.org>
Subject: Re: no backlight on radeon after recent kernel
	"upgrade"s
Date: Thu, 22 Feb 2007 01:07:38 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702220054460.17121@pentafluge.infradead.org>
References: <20070219044616.GC25659@washoe.onerussian.com> 
	<20070219000412.acad13de.akpm@linux-foundation.org> 
	<1171876788.6046.3.camel@localhost.localdomain>
	<20070221055648.GM25659@washoe.onerussian.com>
	<1172104471.5790.57.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK2R5-0002kE-8O for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 17:07:51 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HK2R3-0001XH-W1
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 17:07:50 -0800
In-Reply-To: <1172104471.5790.57.camel@localhost.localdomain>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Yaroslav Halchenko <lists@onerussian.com>


> On Wed, 2007-02-21 at 00:56 -0500, Yaroslav Halchenko wrote:
> > I didn't mention 2.6.20-mm1 and got to see -mm2 so it is the one which
> > Iv'e tried, but, once again, I experienced the same issue with 19-mm?
> > kernels.
> > 
> > I built 2.6.20-mm2 without backlight support
> > $> grep BACKLIGH /boot/config-2.6.20-mm2 
> > # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
> > # CONFIG_FB_BACKLIGHT is not set
> > # CONFIG_FB_RIVA_BACKLIGHT is not set
> > # CONFIG_FB_RADEON_BACKLIGHT is not set
> > 
> > that "eliminated" the problem. Also I can see the screen with pure
> > 2.6.20 with backlight support (whatever it does since after
> > loading lcd, backlight modules, my /sys/class/{lcd,backlight} are empty):
> > 
> > *$> grep BACKLIGH /boot/config-2.6.20 
> > # CONFIG_FB_BACKLIGHT is not set
> > CONFIG_BACKLIGHT_LCD_SUPPORT=y
> > CONFIG_BACKLIGHT_CLASS_DEVICE=m
> > CONFIG_BACKLIGHT_DEVICE=y
> > 
> > 
> > > Also, do you normally see files under /sys/class/lcd?
> > nope... after I load lcd module, no files under :-/ regardless either it
> > is mm or not. But there are files under /sys/class/backlight/ for mm2
> > compiled with backlight support (whenever the screen is dark as per my
> > original email)
> 
> There should be no files appearing under /sys/class/lcd, so thats all
> normal. There is another report with similar symptoms which also sounds
> like enabling the following options are at fault:

Correct. LCD class was never used by anyone.
 
> # CONFIG_FB_RIVA_BACKLIGHT is not set
> # CONFIG_FB_RADEON_BACKLIGHT is not set
> 
> I suspect these options only work on certain hardware and aren't
> generic. James, any idea what hardware these do/don't work with?
> 
> Worst case, we set them to depend on PMAC_BACKLIGHT again I guess...

   Ug. Previously it did the selecting for you. If you selected 
backlight support the fbdev backlight would just come to life. This caused 
problems for the case of having ACPI backlight and a fbdev driver with 
backlight support. Two drivers controling the same hardware is not the
greatest idea. I made it so that people explictly had to pick the backlight
with a fbdev device. The other reason for this change was not every 
one is using a LCD display. I have a system at home that uses a CRT. 
   Plus their is the case of "standard" PC graphics cards being used 
in embedded devices. In this case even tho the graphics card has backlight 
support the external lcd/backlight is routed through gpio independent of 
the embedded graphics card. In such case we don't want to enable the
backlight for the graphics card but enable it.
    In a nut shell the solution is select the backlight support for your
fbdev driver if you need it.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
