From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [PATCH] atmel_lcdfb: Disable LCD and DMA
 engines when suspending
Date: Fri, 12 Sep 2008 12:32:01 +0200
Message-ID: <20080912123201.63f9405b@hskinnemo-gx745.norway.atmel.com>
References: <1221214950-18268-1-git-send-email-haavard.skinnemoen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ke5yH-000261-4a for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Sep 2008 03:33:49 -0700
Received: from smtpeu1.atmel.com ([195.65.72.27] helo=bagnes.atmel.com)
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1Ke5yG-0004Xd-Go
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Sep 2008 03:33:49 -0700
In-Reply-To: <1221214950-18268-1-git-send-email-haavard.skinnemoen@atmel.com>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

Haavard Skinnemoen <haavard.skinnemoen@atmel.com> wrote:
> When suspending the system with atmel_lcdfb enabled, I sometimes see
> this:
> 
> [17179610.896000] atmel_lcdfb atmel_lcdfb.0: FIFO underflow 0x10
> 
> Which can be explained by the fact that we're not stopping the LCD
> controller and its DMA engine when suspending, we're just gating the
> clocks to them.
> 
> There's another potential issue which may be harder to trigger but
> much more nasty: If we gate the clocks at _just_ the right moment,
> e.g. when the DMA engine is doing a bus transaction, we may cause the
> DMA engine to violate the system bus protocol and cause a lockup.
> 
> Avoid these issues by shutting down the LCD controller before entering
> suspend (and restarting it when resuming). This prevents the underrun
> from happening in the first place, and prevents whatever nastiness is
> happening when the bus clock stops in the middle of a DMA transfer.
> 
> Signed-off-by: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---

Forgot to add that this is the same patch that I posted before, but
with an updated description since my analysis wasn't entirely correct
-- the events/0 hang was caused by something else.

I'd like to get this merged before 2.6.27 since the bug is potentially
deadly.

Haavard

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
