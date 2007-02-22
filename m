From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH]
Date: Thu, 22 Feb 2007 16:49:36 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702221648540.29542@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0702212105280.20620@pentafluge.infradead.org> 
	<1172106234.4217.50.camel@daplas>
	<Pine.LNX.4.64.0702220119060.17121@pentafluge.infradead.org>
	<1172109206.4217.61.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKH8c-0003uJ-82 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 08:49:46 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HKH8Z-00064T-SG
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 08:49:46 -0800
In-Reply-To: <1172109206.4217.61.camel@daplas>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 22 Feb 2007, Antonino A. Daplas wrote:

> On Thu, 2007-02-22 at 01:35 +0000, James Simmons wrote:
> > > On Wed, 2007-02-21 at 21:23 +0000, James Simmons wrote:
> 
> > > If this is an attempt to consolidate, I don't see the 'brightness'
> > > hook of backlight and lcd.
> > > 
> > > If this is not a consolidation, why don't we just extend the lcd class?
> > 
> > Its is a replacement for lcd. Is brightness universal for all display 
> > types?
> 
> Well, if you're adding a universal interface, you need hooks for more
> than that (brightness, contrast, hue, saturation, tint, etc).  Then we
> just let the drivers cherry pick from the list on what it's going to
> support.

Ah. Thats the power of sysfs groups :-)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
