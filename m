From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: atyfb & lockups
Date: Fri, 02 Dec 2005 13:14:14 +1100
Message-ID: <1133489654.6100.53.camel@gaston>
References: <1133329905.16726.69.camel@gaston>
	 <438D4B39.5090208@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ei0Xs-0001uk-9K
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Dec 2005 18:21:08 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Ei0Xq-00009t-Ry
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Dec 2005 18:21:08 -0800
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id jB22HcWG007461
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 1 Dec 2005 20:17:40 -0600
In-Reply-To: <438D4B39.5090208@t-online.de>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net


> Well, there are other possibilities.
> 
> When does the lockup occure?  Immediately when booting? Later? During 
> start of 
> xdm/kdm? Random?

During boot, when drawing text in console mode, usually when it starts
scrolling but not necessarily.

> I would start to investigate the case by instrumenting and extending the 
> fb_sync code.
> Try to include code there that resets the chip and switches to the 
> noaccel counterparts of the
> accelerated functions when a timeout occures. That way you should have a 
> chance to resume.

Yah, I should do something like that. I remember trying to track that
bug down a while ago now, and I think I had it working by adding syncs
all over the place.

However, I think the problem is more likely to be some bad fifo or
bandwidth setting in the engine causing it to lockup when loaded. It
works if I boot MacOS and use BootX to then boot linux, though I then
have different display problems (definitely look like incorrect settings
of the display fifo).

> Is the timeout counter ok? Maybe you should decrease/increase it.   If 
> switching to
> the noaccel function works, include a register dump before resetting the 
> chip, use show_trace()
> etc for further debugging.

Will do all of these as soon as I find some time. My initial post was
mostly to ping in case it was a known issue or somebody else already
tracked it down.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
