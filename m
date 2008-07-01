From: <JosephChan@via.com.tw>
Subject: Re: [PATCH 7/13] viafb: iface.c, iface.h,
	ioctl.c, ioctl.h
Date: Tue, 1 Jul 2008 09:20:31 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E7D07@exchtp03.taipei.via.com.tw>
References: <20080630103939.23a24435@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KDUXq-0002e1-7m for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 18:20:34 -0700
Received: from mailtp.via.com.tw ([61.66.243.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KDUXp-0001Lr-Sa
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 18:20:34 -0700
Content-class: urn:content-classes:message
In-Reply-To: <20080630103939.23a24435@lxorguk.ukuu.org.uk>
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
To: alan@lxorguk.ukuu.org.uk
Cc: geert@linux-m68k.org, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Alan,

Thanks to remind.
Is it good to add viafb_ , ex: viafb_get_memsize(void)?
It would be great to have your comment. Thanks again.

BRs,
Joseph Chan 

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Monday, June 30, 2008 5:40 PM
To: Joseph Chan
Cc: Joseph Chan; linux-fbdev-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org; akpm@linux-foundation.org; geert@linux-m68k.org
Subject: Re: [PATCH 7/13] viafb: iface.c, iface.h, ioctl.c, ioctl.h


> +/* Get frame buffer size from VGA BIOS */
> +
> +unsigned int get_memsize(void)

Not a good name for a globally visible function!

> +unsigned long get_videobuf_addr(void) {

Ditto

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
