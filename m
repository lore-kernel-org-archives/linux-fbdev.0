From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] fix Kconfig breakage in
	drivers/video
Date: Sun, 14 Mar 2010 15:19:41 -0700 (PDT)
Message-ID: <20100314.151941.24322068.davem@davemloft.net>
References: <20100314225329.f5dc3e05.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <davem@davemloft.net>) id 1Nqw9e-0005ok-IS
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 14 Mar 2010 22:19:26 +0000
Received: from 74-93-104-97-washington.hfc.comcastbusiness.net ([74.93.104.97]
	helo=sunset.davemloft.net)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nqw9d-0003rQ-C6 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 14 Mar 2010 22:19:26 +0000
In-Reply-To: <20100314225329.f5dc3e05.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: krzysztof.h1@poczta.fm
Cc: akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, baruch@tkos.co.il

From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Sun, 14 Mar 2010 22:53:29 +0100

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> There are two new options inside the CONFIG_FB section which do not
> depend on the CONFIG_FB. This break Kconfig menu layout.
> 
> Fix it and reduce few conditions for sparc frame buffers
> as the FB_SBUS == ((FB = y) && SPARC).
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Acked-by: David S. Miller <davem@davemloft.net>

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
