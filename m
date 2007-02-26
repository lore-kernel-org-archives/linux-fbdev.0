From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: 2.6.21-rc1 dims my LCD
Date: Mon, 26 Feb 2007 15:43:37 +0000
Message-ID: <1172504617.5824.102.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0702260154460.10496@twin.jikos.cz>
	<1172490091.5824.30.camel@localhost.localdomain>
	<Pine.LNX.4.64.0702261329270.10496@twin.jikos.cz>
	<20070226142157.GA2909@khazad-dum.debian.net>
	<1172501357.5824.91.camel@localhost.localdomain>
	<Pine.LNX.4.64.0702261617240.10496@twin.jikos.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HLi13-0003LX-Jf for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Feb 2007 07:43:53 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HLi12-0003yz-W2
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Feb 2007 07:43:53 -0800
In-Reply-To: <Pine.LNX.4.64.0702261617240.10496@twin.jikos.cz>
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
To: Jiri Kosina <jikos@jikos.cz>
Cc: FB-Dev <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

On Mon, 2007-02-26 at 16:24 +0100, Jiri Kosina wrote:
> On Mon, 26 Feb 2007, Richard Purdie wrote:
> 
> > Jiri: I've appended a patch that should already be queued, could you
> > test and see if it solves the problem.
> 
> Thanks. In the meantime I have gone through the code and I can confirm 
> that this is the root cause of what I am observing.
> 
> Now regarding the patch - at the time when the dim happened previously, 
> currently there is a observable blink (after which the brightness is 
> correct). 

The reason for the behaviour is that its turning the backlight down/off
to save power as it thinks the screen is blank. The blink therefore
makes sense as far as the backlight class is concerned and its working
as intended now.

> I have put some debugging printk() into fb_notifier_callback(), 
> and it turns out that on FB_EVENT_CONBLANK, there are two successive calls 
> to backlight_update_status(), second immediately following the first one:
> 
> Feb 26 15:11:14 thunder kernel: calling backlight_update_status() with bd->props.fb_blank == 1, bd->props.brightness == 0
> Feb 26 15:11:14 thunder kernel: calling backlight_update_status() with bd->props.fb_blank == 0, bd->props.brightness == 0
> 
> Is this really a right thing to do?

This should come from two calls to fbcon_generic_blank() in
drivers/video/console/fbcon.c with a different blank parameter and is
therefore in a way outside the scope of the backlight class.

It would be interesting to know why it decides to blank then immediately
unblank the display though. I've cc'd the fbdev-devel list.

Richard



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
