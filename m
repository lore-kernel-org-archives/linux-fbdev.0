From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: hgafb: resource management fix
Date: Sun, 8 Jun 2008 17:31:47 -0700
Message-ID: <20080608173147.abd8fb22.akpm@linux-foundation.org>
References: <20080608000612.87685b5b.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K5VIk-0003GZ-Fa for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Jun 2008 17:31:58 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K5VIk-0006lb-3R
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Jun 2008 17:31:58 -0700
In-Reply-To: <20080608000612.87685b5b.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 8 Jun 2008 00:06:12 +0200 Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> Release ports which are requested during detection
> which are not freed if there is no hga card.
> Otherwise there is a crash during cat /proc/ioports command. 

erk.

I'll assume that this is needed in both 2.6.26 and 2.6.25.x.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
