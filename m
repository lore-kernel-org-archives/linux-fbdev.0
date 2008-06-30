From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 7/13] viafb: iface.c, iface.h,
	ioctl.c, ioctl.h
Date: Mon, 30 Jun 2008 10:39:39 +0100
Message-ID: <20080630103939.23a24435@lxorguk.ukuu.org.uk>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E7804@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KDG8a-00052I-8N for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 02:57:32 -0700
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]
	helo=lxorguk.ukuu.org.uk)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KDG8Y-0004bA-NI
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 02:57:32 -0700
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E7804@exchtp03.taipei.via.com.tw>
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
Cc: JosephChan@via.com.tw, geert@linux-m68k.org, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


> +/* Get frame buffer size from VGA BIOS */
> +
> +unsigned int get_memsize(void)

Not a good name for a globally visible function!

> +unsigned long get_videobuf_addr(void)
> +{

Ditto


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
