From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] atmel_lcdfb: Disable LCD and DMA
 engines when suspending
Date: Sun, 17 Aug 2008 20:51:06 +0200
Message-ID: <20080817205106.e072b069.krzysztof.h1@poczta.fm>
References: <1218458068-23834-1-git-send-email-haavard.skinnemoen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KUnWV-0000A7-2D for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 Aug 2008 12:02:43 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KUnWT-0006pf-BE
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 Aug 2008 12:02:42 -0700
In-Reply-To: <1218458068-23834-1-git-send-email-haavard.skinnemoen@atmel.com>
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
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, kernel@avr32linux.org

On Mon, 11 Aug 2008 14:34:28 +0200
Haavard Skinnemoen <haavard.skinnemoen@atmel.com> wrote:

> When suspending the system with atmel_lcdfb enabled, I sometimes see
> this:
> 
> [17179610.896000] atmel_lcdfb atmel_lcdfb.0: FIFO underflow 0x10
> 
> After this happens, the serial console is unresponsive for a long time,
> but eventually recovers (after a minute or so).  SysRq-W shows that the
> events thread is blocked trying to recover from the underflow:
> 
> SysRq : Show Blocked State
>   task                PC stack   pid father
> events/0      D 90169e50     0     5      2
> Stack: (0x93833ebc to 0x93834000)
> 3ea0:                                                                93832008
> 3ec0: 90169fd8 90169fd8 93833f18 ffff11ce 93833ee8 00000000 901fb560 00000004
> 3ee0: 901c7788 00000000 902254f8 902254f8 ffff11ce 90023884 9381b900 90225460
> 3f00: 90169fd6 6576656e 74732f30 00000000 00000000 00000005 9016a012 93833f3c
> 3f20: 9388ca40 93821000 00000000 93832000 00000000 901c7788 00000000 90023d16
> 3f40: 93833f50 9388ca40 93821000 00000000 900c7ed2 93833f64 9388ca40 93821000
> 3f60: 00000000 90028156 93833f90 9388ca6c 93821000 00000000 90028110 900c7eb8
> 3f80: 904b7754 00000000 901c7788 00000000 900285a8 93833fc8 93832000 93832000
> 3fa0: 00000000 93821000 ffffe000 9002a7bc 93817eec 00000000 9381b900 9002aa14
> 3fc0: 93833fc0 93833fc0 9002a7e8 93833fec 93821000 900284f8 00000000 00000000
> 3fe0: 9001f718 9002a7bc 93817eec 9001f718 00000000 00000000 00000000 00000000
> Call trace:
>  [<90169fd8>] schedule_timeout+0x60/0x88
>  [<9016a012>] schedule_timeout_uninterruptible+0x12/0x14
>  [<90023d16>] msleep+0x12/0x1c
>  [<900c7ed2>] atmel_lcdfb_task+0x1a/0x5c
>  [<90028156>] run_workqueue+0xba/0x168
>  [<900285a8>] worker_thread+0xb0/0xbc
>  [<9002a7e8>] kthread+0x2c/0x44
>  [<9001f718>] do_exit+0x0/0x508
> 
> Which is understandable since stopping the bus clock while the LCD
> controller is doing a DMA transfer is a thoroughly nasty thing to do,
> and the strange thing isn't that the controller gets confused, but that
> it somehow actually manages to recover after a while.
> 
> Avoid this issue by shutting down the LCD controller before entering
> suspend (and restarting it when resuming). This prevents the underrun
> from happening in the first place, and prevents whatever nastiness is
> happening when the bus clock stops in the middle of a DMA transfer.
> 
> Signed-off-by: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Please send it to akpm@linux-foundation.org if you do not intend
to merge it through atmel/arm tree.

Regards,
Krzysztof

---------------------------------------------------------------------- 
Igrzyska na Dzikim Zachodzie!
Sprawdz >> http://link.interia.pl/f1edc 
	


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
