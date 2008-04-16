From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: tridentfb: resource management fixes in
	probe function
Date: Tue, 15 Apr 2008 21:30:25 -0700
Message-ID: <20080415213025.7aa389ea.akpm@linux-foundation.org>
References: <20071224114025.cb230e25.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JlzI5-0004mu-2t for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 15 Apr 2008 21:30:37 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JlzI3-0006i5-QT
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 15 Apr 2008 21:30:37 -0700
In-Reply-To: <20071224114025.cb230e25.krzysztof.h1@poczta.fm>
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

On Mon, 24 Dec 2007 11:40:25 +0100 Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> 
> The most important fix  is to disable the mmio mode on error. Otherwise,
> the console is left in unusable state (garbled fonts at least, lock up at worst).
> 
> Other changes balance release and request of memory regions
> in case of error and few minor style errors.

I'm going back through my Christmas vacation backlog(!) and this patch
seems to have been lost.  If it's still relevant can you please refresh and
resend sometime?

Thanks.



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
