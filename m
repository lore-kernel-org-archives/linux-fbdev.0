From: Gary Thomas <gary@mlbassoc.com>
Subject: Framebuffer console performance
Date: Thu, 24 Mar 2005 15:14:48 -0700
Message-ID: <1111702489.29791.216.camel@hermes>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DEabV-0005LV-6R
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 24 Mar 2005 14:15:01 -0800
Received: from sta-206-168-96-204.rockynet.com ([206.168.96.204] helo=hermes.chez-thomas.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DEabT-0002Ex-Kd
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 24 Mar 2005 14:15:01 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net

I have a non-standard framebuffer (i.e. I wrote the driver,
based on the au1000 driver) running on 2.4.27.  When I run
virtual consoles on it, I see sluggish scroll performance.
I get quite acceptable performance when the system first
comes up, e.g. during the system initialization messages,
but not long afterwards the scrolling slows down.  It can
get continually worse, eventually ending up at a crawl.

This is a memory limited embedded system, but I do not
have any swapping going on.

Ideas or hints where I might look?

Thanks for your time.

n.b. I'm not subscribed to this list, so please CC my direct
email address when replying.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
