From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbdev upstream
Date: Tue, 6 Jan 2004 00:51:42 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401060049180.7347-100000@phoenix.infradead.org>
References: <1072305777.15461.13.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdfRj-0000G4-KS
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:51:47 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AdfRh-0005Z1-Nm
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:51:46 -0800
In-Reply-To: <1072305777.15461.13.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: John Zielinski <grim@undead.cc>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Of course, that means we'll have to update more drivers, and platforms
> with fixed display, like embedded etc... will need some way to deal
> with that properly in their drivers.

Fixed screen size drivers should provide there own modedb. 

> I don't know about that one. It would be interesting to redo some
> comparison between XFree CVS "nv" driver and rivafb. I don't have any
> nvidia HW at hand for now though. 

The changes have been alot. It would require me reworking the driver 
again.

> Also, we just completely lack proper locking, we should at least take
> the console semaphore around all these operations, which we don't do
> and thus are racy as hell... the HW cursor and blanking timers are
> by definition racy too, we need to fix that some way.

The fbcon system has always lacked locking :-( Now it can be fixed.
k



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
