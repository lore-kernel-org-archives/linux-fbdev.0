From: Michal Januszewski <spock@gentoo.org>
Subject: Re: [PATCH] fbdev: find mode with
	highest	refresh rate in fb_find_mode()
Date: Sun, 26 Aug 2007 21:09:13 +0200
Message-ID: <20070826190913.GA24286@spock.one.pl>
References: <20070718084102.GA22694@spock.one.pl>
	<20070718143803.GA5787@localhost.localdomain>
	<1184771895.4523.33.camel@daplas>
Reply-To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPNUK-0003eh-LA for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 12:09:33 -0700
Received: from 15.61.79.83.cust.bluewin.ch ([83.79.61.15] helo=spock.one.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IPNUJ-0003fJ-0S
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 12:09:32 -0700
Content-Disposition: inline
In-Reply-To: <1184771895.4523.33.camel@daplas>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wed, Jul 18, 2007 at 11:18:15PM +0800, Antonino A. Daplas wrote:

> > > Currently if the refresh rate is not specified fb_find_mode() returns
> > > the first known video mode with the requested resoluion, which provides
> > > no guarantees wrt the refresh rate.  Change this so that the mode with
> > > the highest refresh rate is returned instead.
> > 
> > What refresh rate it sets when used on card or monitor without DDC?
>
> Yes, I noted this also while reviewing patches.  fb_find_mode() is used
> predominantly with the 'generic' modedb which contains modes that are
> not specific to the card or monitor.  And fb_try_mode() is not a
> guarantee that the returned refresh rate will be safe (we have a lot of
> drivers that do not check the timings against the display capabilities).
> 
> It would be best that fb_find_mode() return the safest refresh rate
> (60Hz) instead of the highest.

How about modifying it so that it looks for a mode with the highest
refresh rate if either a non-generic modedb is used or
info.monspecs.{vfmin,vfmax,hfmin,hfmax,dclkmax} are all non-zero,
and for a mode with refresh rate closest to 60 Hz otherwise?

I'm sorry for the delayed reply.

Best regards.
-- 
Michal Januszewski                              JID: spock@im.gentoo.org
Gentoo Linux Developer                    http://people.gentoo.org/spock


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
