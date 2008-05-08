From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: lxfb driver regression
Date: Wed, 7 May 2008 18:11:40 -0700
Message-ID: <20080507181140.ecea2305.akpm@linux-foundation.org>
References: <20080507210836.1eb61b8f@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jtufy-0006XL-7u for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 May 2008 18:12:02 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jtufw-0000Zu-R0
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 May 2008 18:12:02 -0700
In-Reply-To: <20080507210836.1eb61b8f@ephemeral>
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
To: Andres Salomon <dilinger@queued.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-geode@bombadil.infradead.org, Jens Rottmann <JRottmann@LiPPERT-AT.de>, linux-kernel@vger.kernel.org, jordan.crouse@amd.com, torvalds@linux-foundation.org

On Wed, 7 May 2008 21:08:36 -0400 Andres Salomon <dilinger@queued.net> wrote:

> Hi,
> 
> I noticed that a patch from you went into 2.6.26-rc1 to adjust the PLL table
> in the lxfb driver.  Unfortunately, it breaks on OLPC machines (I haven't
> tested it on other Geode platforms yet, but I don't have any other Geodes
> with panels anyways).  It's this commit:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=3888d4639e78802c4ec1086127124e890461b9e4
> 
> Without this patch, I get the following (correct) output from the lxfb
> and console code:
> 
> [    0.939827] lxfb 0000:00:01.1: 16384 KB of video memory at 0xfd000000
> [    1.009194] Console: switching to colour frame buffer device 150x56     
> 
> Without it, the cols/width is screwy (and I get a blank white screen):
> 
> [   20.706836] lxfb 0000:00:01.1: 16384 KB of video memory at 0xfd000000
> [   20.788538] Console: switching to colour frame buffer device 100x40        

I queued a reversion but (as is often the case with non-critical
regressions) I'll hold off for a few days, see if we can get things fixed
up.


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
