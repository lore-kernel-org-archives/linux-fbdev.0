From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbdv/fbcon pending problems
Date: Tue, 24 Feb 2004 01:19:46 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402240116090.17027-100000@phoenix.infradead.org>
References: <1077576644.5960.77.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvRMf-0008Sx-I2
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 17:28:01 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AvR33-0005KC-80
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 17:07:45 -0800
In-Reply-To: <1077576644.5960.77.camel@gaston>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>


> I would appreciate if you did so ;) Please let me know what you find.

Okay. 

> I have this problem since the very beginning. The very first
> shift-pageup to display things properly from the back buffer, but to not
> _erase_ properly, until you do a bit of ping pong (down up down up) so
> that your screen end up properly refreshed.

:-( 
 
> I never use modules for fbdevs

Its a handy way to track down bugs :-)

> It does. Radeonfb did one step in this direction, but that's not
> enough. _BUT_ we still need to differenciate between a full mode 
> passed from userland from a mode where we _KNOW_ everything is
> bogus but width/height... In the later case, we really want to
> find a mode that is just large enough for the passed in width/height
> (but not smaller, or just fail if not found) and with the same
> hfreq if possible as the current mode. That's really a different
> request than a full blown mode coming from userland (like a 'tuning'
> tool or whatever...)
> 
> The FB_ACTIVATE_FIND is just that. It justs tells the driver to
> pick up a mode based on width/height only. We know the rest of
> the var is bogus.

Its still possible that the user sends in bogus data using 
FB_ACTIVATE_FIND. 
 
> Yes, but that's less urgent than the other ones. 

I agree.


> We really need to fix
> those basic behaviour problems before multihead. Multihead will come
> later as I will implement dual head support in radeonfb. That leads to
> a while bunch of problems with the userland API that need to be improed
> too, 

That is what sysfs is for :-) 

> and that leads to the problem of properly soft booting additional
> cards. I have various ideas to address those problems, but that's
> definitely less urgent than the list I wrote down.

We will talk about this later.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
