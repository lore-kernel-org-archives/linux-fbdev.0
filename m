From: Andrew Morton <akpm@osdl.org>
Subject: inappropriate use of in_atomic()
Date: Thu, 10 Mar 2005 20:40:06 -0800
Message-ID: <20050310204006.48286d17.akpm@osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux1394-devel-admin@lists.sourceforge.net
Errors-To: linux1394-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux1394-devel>
Content-Type: text/plain; charset="us-ascii"
To: Paul Mackerras <paulus@samba.org>, Jean Tourrilhes <jt@bougret.hpl.hp.com>, javier@tudela.mad.ttd.net, linux-fbdev-devel@lists.sourceforge.net, acpi-devel@lists.sourceforge.net, linux1394-devel@lists.sourceforge.net, Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org


in_atomic() is not a reliable indication of whether it is currently safe
to call schedule().

This is because the lockdepth beancounting which in_atomic() uses is only
accumulated if CONFIG_PREEMPT=y.  in_atomic() will return false inside
spinlocks if CONFIG_PREEMPT=n.

Consequently the use of in_atomic() in the below files is probably
deadlocky if CONFIG_PREEMPT=n:

	arch/ppc64/kernel/viopath.c
	drivers/net/irda/sir_kthread.c
	drivers/net/wireless/airo.c
	drivers/video/amba-clcd.c
	drivers/acpi/osl.c
	drivers/ieee1394/ieee1394_transactions.c
	drivers/infiniband/core/mad.c

Note that the same beancounting is used for the "scheduling while atomic"
warning, so if the code calls schedule with locks held, we won't get a
warning.  Both are tied to CONFIG_PREEMPT=y.

The kernel provides no reliable runtime way of detecting whether or not it
is safe to call schedule().

Can we please find ways to change the above code to not use in_atomic()? 
Then we can whack #ifndef MODULE around its definition to reduce
reoccurrences.  Will probably rename it to something more scary as well.

Thanks.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
