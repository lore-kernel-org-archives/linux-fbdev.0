From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] radeonfb: Give i2c buses nicer names
Date: Wed, 18 Jun 2008 20:57:44 +0200
Message-ID: <20080618205744.8c8291c8.krzysztof.h1@poczta.fm>
References: <20080617144615.6574fc83@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K92qJ-00072f-5H for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jun 2008 11:57:15 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K92qH-0007HL-Pg
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jun 2008 11:57:15 -0700
Received: from poczta.interia.pl (mi06.poczta.interia.pl [10.217.12.6])
	by smtp239.poczta.interia.pl (INTERIA.PL) with ESMTP id 98BD7F6EBE
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 18 Jun 2008 20:54:28 +0200 (CEST)
Received: from krzysio.net (host-87-99-61-239.lanet.net.pl [87.99.61.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 31437132500
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 18 Jun 2008 20:54:27 +0200 (CEST)
In-Reply-To: <20080617144615.6574fc83@hyperion.delvare>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Tue, 17 Jun 2008 14:46:15 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> The name of the i2c buses shows in the output of "i2cdetect -l", so
> it's important to give informative names.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> Antonino, can you please push this upstream? Thanks.
> 
Please send these patches to Andrew Morton.

Regards,
Krzysztof

----------------------------------------------------------------------
Backstage na The Police + bilet na koncert!
kliknij >>> http://link.interia.pl/f1e3d


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
