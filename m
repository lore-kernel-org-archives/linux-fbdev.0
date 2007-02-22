From: James Simmons <jsimmons@infradead.org>
Subject: Re: no backlight on radeon after recent kernel
 "upgrade"s
Date: Thu, 22 Feb 2007 15:55:24 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702221549530.29542@pentafluge.infradead.org>
References: <20070219044616.GC25659@washoe.onerussian.com>
	<20070219000412.acad13de.akpm@linux-foundation.org>
	<1171876788.6046.3.camel@localhost.localdomain>
	<20070221055648.GM25659@washoe.onerussian.com>
	<Pine.LNX.4.64.0702220109450.17121@pentafluge.infradead.org>
	<20070222020951.GR7920@ca-server1.us.oracle.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKGIK-0004qo-4h for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 07:55:44 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HKGIH-0007T2-4O
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 07:55:42 -0800
In-Reply-To: <20070222020951.GR7920@ca-server1.us.oracle.com>
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
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Richard Purdie <rpurdie@rpsys.net>, linux-kernel@vger.kernel.org, Yaroslav Halchenko <lists@onerussian.com>


> On Thu, Feb 22, 2007 at 01:11:18AM +0000, James Simmons wrote:
> > > *$> grep BACKLIGH /boot/config-2.6.20 
> > > # CONFIG_FB_BACKLIGHT is not set
> > > CONFIG_BACKLIGHT_LCD_SUPPORT=y
> > > CONFIG_BACKLIGHT_CLASS_DEVICE=m
> > > CONFIG_BACKLIGHT_DEVICE=y
> > 
> > You need to explictly enable the backlight for your fbdev driver. It 
> > doesn't do the selecting magically for you.
> > Jus do a make "favorite"config and go to the fbdev menu and select the 
> > backlight option for your fbdev driver.
> 
> 	I would think that we'd always want to enable the backlight.
> How are people supposed to Just Know that the kernel defaults to a black
> LCD?

I just tested various confirations of backlight support. Backlight is 
ALWAYS selected by default when you select a particular fbdev driver that 
has backlight support. You just have the option to turn it off if you 
want. These problems are showing up because of stale .config files.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
