From: "David S. Miller" <davem@davemloft.net>
Subject: Re: nvidia on sparc32
Date: Sat, 08 Apr 2006 02:18:26 -0700 (PDT)
Message-ID: <20060408.021826.94497113.davem@davemloft.net>
References: <20060408012107.2dc6f594.akpm@osdl.org>
	<20060408.012707.80122971.davem@davemloft.net>
	<20060408013917.00bd96ee.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FS9aR-00008v-Rx
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 08 Apr 2006 02:18:31 -0700
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net
	([216.27.180.168] helo=sunset.davemloft.net ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FS9aQ-0000BL-Kw
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 08 Apr 2006 02:18:31 -0700
In-Reply-To: <20060408013917.00bd96ee.akpm@osdl.org>
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
Content-Type: Text/Plain; charset="us-ascii"
To: akpm@osdl.org
Cc: linux-fbdev-devel@lists.sourceforge.net

From: Andrew Morton <akpm@osdl.org>
Date: Sat, 8 Apr 2006 01:39:17 -0700

> hm, OK, thanks.  Given that it all compiles with the borrowed vga.h, I
> guess the simplest thing to do is to run with that - it fixes allmodconfig,
> avoids mucking up the Kconfig files and gives us wide compile coverage.
> 
> What thinkest thou?

Sure, that's fine with me.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
