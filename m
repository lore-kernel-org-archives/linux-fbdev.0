From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] radeonfb: copyarea() "memmove()"
 problem
Date: Wed, 14 Apr 2004 19:08:38 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404141907260.13481-100000@phoenix.infradead.org>
References: <Pine.LNX.4.58.0404112101080.2231@rosencrantz.theboonies.us>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDooV-00029F-5Y
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Apr 2004 11:08:43 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BDooU-0001ad-JV
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Apr 2004 11:08:43 -0700
In-Reply-To: <Pine.LNX.4.58.0404112101080.2231@rosencrantz.theboonies.us>
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
To: David Eger <eger@theboonies.us>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> I tried your patch against BenH's tree.  
> 
> radeon_accel.c patched fine (the relevant file) but the other two patches
> failed; I assume BenH had just merged those patches already...

My patch had a bug in it which I can't figure out way yet.
 
> Then I set fbcon to always enable use of the accel functions (as noted in 
> a previous email).  The results weren't nice :-/

Do you still have the patch?
 
> I'll try to figure out what's wrong when I have more time Thursday.  
> Till then, my previous patch is about as close to good as we have :-/

I don't have teh specs for the radeon so I went by my programming 
experience on other chips.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
