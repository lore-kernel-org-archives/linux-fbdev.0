From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Patch to add mode setting to sysfs
Date: Mon, 21 Feb 2005 18:55:23 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502211853400.13423@pentafluge.infradead.org>
References: <9e4733910502161430ff1dad1@mail.gmail.com> <200502181542.50162.adaplas@hotpop.com>
 <9e473391050218084629ad0935@mail.gmail.com> <200502190559.07162.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3IiO-0004jp-Vg
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 10:55:28 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D3IiN-0000vj-CJ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 10:55:28 -0800
In-Reply-To: <200502190559.07162.adaplas@hotpop.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Jon Smirl <jonsmirl@gmail.com>, adaplas@pol.net, James Simmons <jsimmons@pentafluge.infradead.org>


> > Do you want to take over the sysfs support? If so, I will make some
> > changes to the radeonfb driver that I need. That will keep up from
> > conflicting.
> 
> Actually, I plan to do the fbcon part only, capturing the event. I'll use
> yours as the test bed, but you and James will have to agree on the best way
> to add sysfs support to the fb core.

We are attempting to work that out. Right now also I'm working on resource 
management for fbdev. I have a patch coming but it needs work. I consider 
it more important that sysfs right now. I will be sending the first run at 
that resource management today.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
