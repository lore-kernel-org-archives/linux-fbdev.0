From: James Simmons <jsimmons@infradead.org>
Subject: Re: EDID vs. fbmon & radeon
Date: Fri, 12 Sep 2003 18:58:43 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309121853590.5017-100000@phoenix.infradead.org>
References: <1063094455.676.15.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xsBy-0003Sa-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 10:58:47 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19xsBy-0007uW-2t
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 10:58:46 -0700
In-Reply-To: <1063094455.676.15.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > Hm. The most important goal I think should be that as much as possible 
> > code sharing goes on. The way XFree86 handles it is that th edrivers only 
> > have to deal with 2 functions for writing the i2c register. Everything 
> > else is handled by a upper layer. I like to see fbdev have the same thing.
> 
> If you look at my radeonfb work, you'll notice that I do pretty much like
> XFree: that is I provide low level i2c routines to the kernel i2c layer,
> and later one use these along with chip specific code (actually copied from
> XFree) to retreive the EDID. It can't be all factored due to some HW gory
> details though.

:-( I just want to make the drivers as simple as possible to create. 
 
> What XFree does though is to parse the EDID and expose structures containing
> the decoded timing infos so that the driver can actually pick individual
> modes in there knowing which ones come from detailed timing blocks and
> chich ones are calculated VESA modes. We could acheive the same by adding
> some flags to the modedb we generate.

Make it so.....

P.S
	So I got swarmed with emails. I had some reading to do. BTW where 
is this new code. I like to commit to fbdev BK tree. 

P.S.S
	I did some work on your fbdev pm stuff. I will send another email 
about this.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
