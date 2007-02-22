From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH 1/1] PXAFB: Support for backlight
	control
Date: Thu, 22 Feb 2007 09:27:09 +0000
Message-ID: <1172136430.5837.9.camel@localhost.localdomain>
References: <20070221145353.GA23916@enneenne.com>
	<1172105946.5790.78.camel@localhost.localdomain>
	<20070222082848.GM4641@enneenne.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKAFR-0007sV-5R for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 01:28:21 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HKAFP-0003KT-Ae
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 01:28:21 -0800
In-Reply-To: <20070222082848.GM4641@enneenne.com>
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
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk, Paul Sokolovsky <pmiscml@gmail.com>, linux-kernel@vger.kernel.org

On Thu, 2007-02-22 at 09:28 +0100, Rodolfo Giometti wrote:
> On Thu, Feb 22, 2007 at 12:59:06AM +0000, Richard Purdie wrote:
> > 
> > Reading through the patch its:
> > 
> > 1) Not against any mainline kernel

Sorry, I'd missed a patch entering mainline,

> > 2) Not against a recent kernel
> 
> I'm sorry, but the patch applay against the latest kernel. Please, try
> it.

but this still applies as there were a number of backlight changes
merged just before 2.6.21-rc1 and your driver will not work with
2.6.21-rc1.

> > As mentioned by others, there is no need to tie the backlight driver
> > into the framebuffer any more. Have a look at
> > drivers/video/backlight/corgi_bl.c for an example (its used by PXA
> > devices).
> z
> That driver uses the backlight class support as my patch does into
> pxafb.

Yes, my point is that you shouldn't need to touch pxafb if you use the
backlight class. I know pxafb has backlight hooks but they are probably
going to get removed at some point as they should no longer be needed.

> > I have said elsewhere I will take patches to make corgi_bl a more
> > generic driver (or maybe create a simple generic backlight driver) along
> > the lines of what Paul mentioned.
> 
> I see.
> 
> I suppose you are the backlight support mantainer, so what do you
> suggest to do to "make corgi_bl a more generic driver"?

What changes do you need to it to be able to use it as a generic driver?

The main issue is that the structure definition is in one of the
sharpsl.h files at the moment so most drivers can't get to it. Fix that
and it should make a good generic driver.

Ideally I'd prefer to leave the name alone since there is broken
userspace on the Zaurus that uses that name but I can see why people
want it renamed if its to be used as a generic driver...

Richard


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
