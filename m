From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Patch to add mode setting to sysfs
Date: Fri, 18 Feb 2005 15:41:32 +0800
Message-ID: <200502181541.32958.adaplas@hotpop.com>
References: <9e4733910502161430ff1dad1@mail.gmail.com> <200502180804.46005.adaplas@hotpop.com> <9e47339105021723274951c76c@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D23UQ-0001lb-BW
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Feb 2005 00:27:54 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D23UP-0006vt-Vo
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Feb 2005 00:27:54 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 00C0E1405D2B
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Feb 2005 07:41:34 +0000 (UTC)
In-Reply-To: <9e47339105021723274951c76c@mail.gmail.com>
Content-Disposition: inline
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
To: Jon Smirl <jonsmirl@gmail.com>, adaplas@pol.net, James Simmons <jsimmons@www.infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Friday 18 February 2005 15:27, Jon Smirl wrote:
> Next version of sysfs patch. Fills out more attributes. Feel free to
> add code for missing implementations. Modifies fbcon to copy mode
> structure instead of taking a reference to it. Modular fbdev is

Modifying fbcon to get a copy of the mode still won't work.  What if
the consoles are at 1600x1200, and then you plug in a new monitor
capable only of 1024x768 max?  So you still need to send an
event, and fbcon needs to capture this event so it can resize the
consoles to fit the new monitor.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
