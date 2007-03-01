From: James Simmons <jsimmons@infradead.org>
Subject: Re: no backlight on radeon after recent kernel
 "upgrade"s
Date: Thu, 1 Mar 2007 21:08:29 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0703012107590.14408@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0702220109450.17121@pentafluge.infradead.org> 
	<20070222020951.GR7920@ca-server1.us.oracle.com> 
	<Pine.LNX.4.64.0702221549530.29542@pentafluge.infradead.org> 
	<20070222.092812.112620509.davem@davemloft.net> 
	<Pine.LNX.4.64.0702281654230.14127@pentafluge.infradead.org>
	<1172746678.19220.48.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMsWJ-0005mz-9l for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 13:08:59 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HMsWI-0000Uj-TS
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 13:08:59 -0800
In-Reply-To: <1172746678.19220.48.camel@localhost.localdomain>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, lists@onerussian.com, Joel.Becker@oracle.com, akpm@linux-foundation.org, David Miller <davem@davemloft.net>


Could you. Right now I'm busy with the DRM/fbdev device management.

On Thu, 1 Mar 2007, Richard Purdie wrote:

> On Wed, 2007-02-28 at 16:55 +0000, James Simmons wrote:
> > So the problem is not the configuration but that for some reason the 
> > backlight state is set to off by default.
> 
> Maybe, maybe not. I'm not sure there's been enough information to
> conclude that.
> 
> At the moment, I'd like a patch which makes backlight usage configurable
> at runtime though a module parameter and defaults to off in all cases
> except the powermac one. I'd like to get something into the tree,
> preferably before the next -rc, since at the moment things are breaking
> for people. If you haven't time, say so and I'll have a look and see if
> I can work one out.
> 
> Cheers,
> 
> Richard
> 
> 
> 
> 
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
