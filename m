From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [Regression: 2.6.25-rc5: Blank Screen:
	Intel 945]
Date: Tue, 1 Apr 2008 13:22:58 -0700
Message-ID: <200804011322.58259.jbarnes@virtuousgeek.org>
References: <47D828BB.2000702@gawab.com>
	<200803251308.43830.jbarnes@virtuousgeek.org>
	<47F13A74.8010206@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jgn18-0007F8-5A for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 Apr 2008 13:23:38 -0700
Received: from [67.222.39.28] (helo=outbound-mail-138.bluehost.com)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Jgn14-0002n5-QQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 Apr 2008 13:23:38 -0700
In-Reply-To: <47F13A74.8010206@gawab.com>
Content-Disposition: inline
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
To: Justin Madru <jdm64@gawab.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>

On Monday, March 31, 2008 12:24 pm Justin Madru wrote:
> Well, I disabled gdm and tryed to trigger the blank screen. I did about ~16
> reboots and it blanked out on me only 2 times. I was using a script to
> reboot and/or startx. One time I'm not exactly sure if X was started, so it
> might have blanked out on a "startx". The other time I'm fairly sure X
> wasn't started, so it blanked out on a terminal login.

Ok, so that might indicate something in the fb layer is killing it...

> Both of the blank outs were different than the ones with gdm started.
> Pressing ctrl+alt+f# changed nothing on the screen; the screen seemed
> almost completely off (no or little backlight). A few seconds after
> pressing the power button the shutdown splash screen would show, but this
> time it was _very_ faint.
>
> Usually, when gdm is enabled, pressing ctrl+alt+f# would "refresh" (or
> mode/resolution change) the screen, but it would still be blank. Also the
> backlight still seamed to be on and at full brightness (although, still
> displaying black).
>
> Well, I don't know what to say, it's the strangest of problems.

Yeah, seems pretty weird.  Given that you see it w/o the fb stuff loaded as 
well and we still have a few open bugs against the intel X driver regarding 
VT switch & mode programming, I don't think this is a real kernel regression.  
It's more likely that some timing or memory layout changed subtly and is 
causing to to hit one of our existing bugs more frequently that you did 
before.  Can you file a bug against the intel X driver at 
bugs.freedesktop.org so we can track it there?  Unless we can find a way to 
reproduce it reliably it'll probably take a long time to fix, but we don't 
want to lose it either...

Thanks,
Jesse

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
