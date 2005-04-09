From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb: (#2) Implement proper workarounds for PLL
 accesses
Date: Sat, 09 Apr 2005 10:03:25 +1000
Message-ID: <1113005006.9568.402.camel@gaston>
References: <1110519743.5810.13.camel@gaston>
	 <1110672745.5787.60.camel@gaston> <je8y3wyk3g.fsf@sykes.suse.de>
	 <1112743901.9568.67.camel@gaston> <jeoecr1qk8.fsf@sykes.suse.de>
	 <1112827655.9518.194.camel@gaston> <jehdii8hjk.fsf@sykes.suse.de>
	 <21d7e9970504071422349426eb@mail.gmail.com>
	 <1112914795.9568.320.camel@gaston> <jemzsa6sxg.fsf@sykes.suse.de>
	 <1112923186.9567.349.camel@gaston>  <jezmw9ug7j.fsf@sykes.suse.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DK3T7-00088Z-Fl
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 08 Apr 2005 17:04:57 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DK3T5-0005K9-VH
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 08 Apr 2005 17:04:57 -0700
In-Reply-To: <jezmw9ug7j.fsf@sykes.suse.de>
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
To: Andreas Schwab <schwab@suse.de>
Cc: Dave Airlie <airlied@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > This patch adds to the fbdev interface a set_cmap callback that allow
> > the driver to "batch" palette changes. This is useful for drivers like
> > radeonfb which might require lenghtly workarounds on palette accesses,
> > thus allowing to factor out those workarounds efficiently.
> 
> This makes it better. But there is still a delay of half a second, and
> there is an annoying flicker when switching from X to the console.

Can you redo the counting of the workarounds with the patch ?

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
