From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: framebuffer ioctl
Date: Tue, 7 Sep 2004 05:21:09 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409070521.09524.adaplas@hotpop.com>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be> <200409060926.07163.adaplas@hotpop.com> <413C83F7.D4CB1EAD@orpatec.ch>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4Qug-0000Wa-Kn
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Sep 2004 14:20:34 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C4Quf-0003jp-OY
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Sep 2004 14:20:34 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 7B74B7EB784
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  6 Sep 2004 21:20:15 +0000 (UTC)
In-Reply-To: <413C83F7.D4CB1EAD@orpatec.ch>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, Otto Wyss <otto.wyss@orpatec.ch>
Cc: Zack <plinius@comcast.net>

On Monday 06 September 2004 23:36, Otto Wyss wrote:
> I'm neither pro nor contra moving drawing routines into the kernel but
> this has to be discussed and written down.

On Tuesday 07 September 2004 03:56, Zack wrote:
> I think you may be misinterpreting my intent. I am strictly anti-bloat,
> so I don't want a larger kernel. By the same token, I don't use
> X because it is bloated--X uses 16 megs minimum on my system,
> and that is very much not to my taste.

This is not about pros/cons, but a statement of fact. What I meant was that 
the drawing routines that we actually have (imageblit, copyarea, fillrect) 
cannot be used in userspace.  So, if fbdev is going to support drawing 
routines for userspace, then fbdev will need 2 versions of each of the 
drawing function.  That is a waste of good code.  

This decision has been set quite early during 2.5 development.  At that 
period, I wrote a version of imageblit, copyarea and fillrect that can be 
accessed in userspace via ioctl.  With that, I also provided a patch for the 
XFree86 fbdev driver that takes advantage of these ioctl's resulting to 
certain x11perf benchmarks that are faster than X+native driver.  See:

http://marc.theaimsgroup.com/?l=linux-fbdev-devel&m=102278557515976&w=2

Of course, the above is quite difficult to accomplish now.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
