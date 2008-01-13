From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH] backlight.c: avoid unnecessarily
	calling	backlight_update_status()
Date: Sun, 13 Jan 2008 23:02:27 +0000
Message-ID: <1200265347.4665.3.camel@localhost.localdomain>
References: <200801061529.19606.deller@gmx.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JEBr0-0003BI-SE for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 13 Jan 2008 15:02:58 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JEBqy-0007eK-5A
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 13 Jan 2008 15:02:58 -0800
In-Reply-To: <200801061529.19606.deller@gmx.de>
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
To: Helge Deller <deller@gmx.de>
Cc: Andrew Zabolotny <zap@homelink.ru>, linux-fbdev-devel@lists.sourceforge.net, Jamey Hicks <jamey.hicks@hp.com>

On Sun, 2008-01-06 at 15:29 +0100, Helge Deller wrote:
> Every write to the backlight control sysfs entries like (on a Sharp
> Zaurus Poodle):
> - /sys/class/backlight/locomo-bl/power
> - /sys/class/backlight/locomo-bl/brightness
> triggers a call of backlight_update_status(), even if the same
> value is written multiple times in row into those entries.
> 
> In principle this is not critical, but e.g. on the SHARP Poodle everytime
> backlight_update_status() is called, a lot of registers are reset
> and this leads to screen distortions of a ~ 0.4 seconds time frame.
> Esp. tools like some light control programs with controlling sliders 
> for the light intensity happen to set those values more often 
> which is really annoying and makes it nearly impossible to use them
> because the reaction time is really slow and you see lots of screen
> distortions.
> 
> The trivial patch below avoids this problem by comparing the 
> new value with the already set value. In case they are the same,
> it just avoids to call backlight_update_status() again.
> 
> It would be great if this patch could be applied to the fbdev git tree
> for inclusion in later linux kernels.

I've queued this in the backlight tree, thanks.

Note that ideally userspace shouldn't be making all these calls
mind ;-).

Richard


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
