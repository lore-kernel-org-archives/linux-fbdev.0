From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Mon, 8 Nov 2004 07:21:53 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0411080719460.24286@ppc970.osdl.org>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
 <1099893447.10262.154.camel@gaston> <200411081706.55261.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRBLE-0000WC-3c
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Nov 2004 07:22:00 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CRBLC-0004JW-5t
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Nov 2004 07:22:00 -0800
In-Reply-To: <200411081706.55261.adaplas@hotpop.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>



On Mon, 8 Nov 2004, Antonino A. Daplas wrote:
> 
> How about this patch?  This is almost the original macro in riva_hw.h,
> with the __force annotation.

Why not just use __raw_readl/__raw_writel?

That's what they exist for, and they still do any IO accesses correctly, 
which a direct store does not do (it would seriously break on older 
alphas, for example).

Of course, clearly the thing has never worked on things like alphas 
anyway, but the point is that accessing IO memory with direct loads and 
stores really _is_ fundamentally wrong, even if it happens to work on many 
architectures. The keyword is "happens". 

		Linus


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
