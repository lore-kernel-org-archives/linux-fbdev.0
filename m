From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: how does one _stop_ using fb
Date: Fri, 15 Jul 2005 17:05:23 +0200
Message-ID: <42D7D0B3.4020208@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DtRkA-0007Jk-QL
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Jul 2005 08:04:50 -0700
Received: from mailout04.sul.t-online.com ([194.25.134.18])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DtRk8-00010f-AS
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Jul 2005 08:04:50 -0700
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hi everybody,

James Simmons wrote:

 > You need a driver that supports going back to vga text mode. Unfortunely
 > very few drivers support that. At present we can"t go back.

I can unload my framebuffer for the cyberblade/i1 and reload it by
- loading vfb as the first fb module, then
- loading my fb module
- switching one or more tty to it with con2fb,
- switching back all assigned ttys to vfb using con2fb, then
- unloading my driver and
- reloading it or a version.

The driver has the capability to detect the startup mode, and it would 
not be hard
to program the hardware to that state again. Could anyone please explain 
in more
detail what has to be done on the driver level that this vfb fiddling is 
unnecessary?
Which few drivers do support that?

cu,
 Knut


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
