From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [announce 7/7] fbsplash - documentation
Date: Fri, 11 Mar 2005 23:27:47 +1100
Message-ID: <1110544067.5810.100.camel@gaston>
References: <20050308021706.GH26249@spock.one.pl>
	 <200503080418.08804.arnd@arndb.de> <20050308223728.GA11065@spock.one.pl>
	 <200503090117.12755.arnd@arndb.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9jFS-0001PG-Sd
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Mar 2005 04:28:10 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D9jFR-0005y2-CY
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Mar 2005 04:28:10 -0800
In-Reply-To: <200503090117.12755.arnd@arndb.de>
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
Content-Type: text/plain; charset="us-ascii"
To: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Januszewski <spock@gentoo.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> 
> I don't understand. Does the kernel code need to wait for the helper
> to finish while holding the semaphore? AFAICS, the helper is completely
> asynchronous, so it can simply do its job when the kernel has given
> up the semaphore.

It should be totally async witout any sem. there is no guarantee that
userspace is even available at the time you do the call.





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
