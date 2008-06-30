From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 12/13] viafb: via_i2c.c, via_i2c.h,
	viamode.c, viamode.c
Date: Mon, 30 Jun 2008 18:05:38 +0100
Message-ID: <20080630180538.51fc993d@lxorguk.ukuu.org.uk>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E78AA@exchtp03.taipei.via.com.tw>
	<20080630154348.GF21835@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KDN5w-0007Du-Qd for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 10:23:17 -0700
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]
	helo=lxorguk.ukuu.org.uk)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KDN5v-0007eo-7F
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 10:23:16 -0700
In-Reply-To: <20080630154348.GF21835@fluff.org.uk>
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
To: Ben Dooks <ben-linux@fluff.org>
Cc: JosephChan@via.com.tw, geert@linux-m68k.org, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

> This looks like an attempt at re-doing the already extant i2c gpio
> algorithm. Either export via gpiolib and use the i2c-gpio adapter or
> use the i2c bit-banging algorithm.

Agreed - but this can be done a lot more easily after a merge.


Alan

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
