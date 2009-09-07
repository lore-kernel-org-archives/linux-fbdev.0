From: Chris Jones <cjns1989@gmail.com>
Subject: Re: Turn off LCD back light.
Date: Sun, 06 Sep 2009 23:51:26 -0400
Message-ID: <20090907035126.GA2888@turki.gavron.org>
References: <20090831192309.GA6937@turki.gavron.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <cjns1989@gmail.com>) id 1MkVGu-0003C6-2z
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 Sep 2009 03:52:04 +0000
Received: from mta5.srv.hcvlny.cv.net ([167.206.4.200])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MkVGo-0006m0-HS for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 Sep 2009 03:52:04 +0000
Received: from turki.gavron.org
	(ool-45704694.dyn.optonline.net [69.112.70.148]) by
	mta5.srv.hcvlny.cv.net
	(Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
	with ESMTP id <0KPL006MY1DRYO20@mta5.srv.hcvlny.cv.net> for
	linux-fbdev-devel@lists.sourceforge.net;
	Sun, 06 Sep 2009 23:51:27 -0400 (EDT)
Received: from gavron by turki.gavron.org with local (Exim 4.69)
	(envelope-from <cjns1989@gmail.com>)
	id 1MkVGI-0005X0-MK	for linux-fbdev-devel@lists.sourceforge.net; Sun,
	06 Sep 2009 23:51:26 -0400
In-reply-to: <20090831192309.GA6937@turki.gavron.org>
Content-disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

On Mon, Aug 31, 2009 at 03:23:09PM EDT, Chris Jones wrote:
> Hopefully, this is the correct place to ask such questions - I tried the
> fbdev-users mailing list a couple of days ago, but is looks like it's
> not currently very active.
> 
> I would like my laptop's  LCD panel to switch itself off automatically
> after a few minutes of inactivity.
> 
> The /etc/kbd/config file specifies:
> 
> BLANK_DPMS=on
> POWERDOWN_TIME=2
> 
> The /etc/init.d/console-screen.kbd.sh script appears to issue a setterm
> command with the above options a boot time, yet nothing happens.
> 
> I issued the corresponding "setterm" command manually also to no effect.
> 
> Is there something that I need to configure in the linux kernel?
> 
> Is this a limitation of the frambuffer console with the atyfb driver?
> 
> Manually executing "vbetool dpms off" does the trick, so it doesn't look
> like this is a hardware limitation per se.
> 
> The video card is an ATI Technologies Rage Mobility P/M AGP 2x (rev 64).
> 
> Relevant (?) software:
> 
> linux-image      :       2.6.26-1-686
> acpid            :       1.0.8-1
> util-linux       :       2.13.1.1-1
> kbd              :       1.14.1-4

Hmm.. it looks like this is not the right place to request assistance
regarding this issue. :-(

Anyone could suggest where I might find help with this?

Thanks,

CJ

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
