From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: mode setting and console locking,
	nvidia failure
Date: Tue, 18 May 2004 13:37:14 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1084851433.15183.20.camel@gaston>
References: <20040518033811.3221.qmail@web14930.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPvVQ-0002Fw-Er
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 May 2004 20:43:04 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BPvVP-00029e-VJ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 May 2004 20:43:04 -0700
In-Reply-To: <20040518033811.3221.qmail@web14930.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: James Simmons <jsimmons@infradead.org>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>


> One part of this has got to be a problem with the console semaphore.  That
> semaphore should not be accessed from an fbdev driver. If you need to access if
> from an fbdev driver then the fbdev design is broken. Think about the case with
> multiple fbdev's loaded. Since we only have one console all of the fbdev can't
> play with the semaphore. That semaphore needs to be controlled from fb/vgacon
> and lock only the fbdev that is displaying the console, not the others.
> 
> Next experiment is to remove all reference to the console semaphore from my
> fbdev driver.

You should try to understand things rather...

You should _not_ touch the console semaphore from your driver except in
special known circumstances like the PM code path. It will make sure you
don't get called by fbcon, but it's perfectly safe to take it even when
you aren't beeing called by fbcon. However, you should not take it on
normal fbdev operations since you will be called with it already held by
the common fbmem code. The only case where you may want to bother is the
PM callback.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
