From: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch] fbcon: Fix workqueue shutdown
Date: Mon, 8 Dec 2008 12:54:44 -0800
Message-ID: <493D8994.3020605@am.sony.com>
References: <4909EB41.40100@am.sony.com>	<493722F0.5070707@am.sony.com>
	<20081206231642.e685d7f0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geoffrey.Levand@am.sony.com>) id 1L9nMd-0005fA-Bq
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 08 Dec 2008 21:09:59 +0000
Received: from outbound-dub.frontbridge.com ([213.199.154.16]
	helo=IE1EHSOBE001.bigfish.com)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.69) id 1L9nMY-0001HS-Fp
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 08 Dec 2008 21:09:58 +0000
In-Reply-To: <20081206231642.e685d7f0.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

Andrew Morton wrote:
> On Wed, 3 Dec 2008 16:23:12 -0800 Geoff Levand <geoffrey.levand@am.sony.com> wrote:
> 
>> Add a call to cancel_work_sync() in fbcon_exit() to cancel
>> any pending work in the fbcon workqueue.  Also, change the
>> assignment of the workqueue function info->queue.func from
>> NULL to fb_flashcursor(),
> 
> OK.
> 
>> and add a corresponding check in
>> fb_flashcursor() to exit immediately if the variable
>> fbcon_has_exited is set.
> 
> Why was this second part added?

Paranoia.  cancel_work_sync() should assure fb_flashcursor()
is not called after fbcon_exit().

I'll post an updated patch.

-Geoff



------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
