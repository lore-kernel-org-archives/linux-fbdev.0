From: David Eger <eger-sender-da68b9@theboonies.us>
Subject: Re: [PATCH] radeonfb: copyarea() "memmove()"
	problem
Date: Sun, 11 Apr 2004 21:06:13 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0404112101080.2231@rosencrantz.theboonies.us>
References: <Pine.LNX.4.44.0404030045230.9840-100000@phoenix.infradead.org>
Reply-To: David Eger <eger-dated-1082318309.e74952@theboonies.us>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BCl6B-0001dp-PL
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 11 Apr 2004 12:58:35 -0700
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BCl67-0005ld-R9
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 11 Apr 2004 12:58:32 -0700
In-Reply-To: <Pine.LNX.4.44.0404030045230.9840-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


James says:
> try my patch, I think it will fix things!

Sorry for the delay James -- I have a paper due this wednesday that I've 
been working on all week ;-)

I tried your patch against BenH's tree.  

radeon_accel.c patched fine (the relevant file) but the other two patches
failed; I assume BenH had just merged those patches already...

Then I set fbcon to always enable use of the accel functions (as noted in 
a previous email).  The results weren't nice :-/

I'll try to figure out what's wrong when I have more time Thursday.  
Till then, my previous patch is about as close to good as we have :-/

-David

---
getting bounce messages from me? let me know and you'll go on my whitelist


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
