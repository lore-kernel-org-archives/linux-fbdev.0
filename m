From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: framebuffer ioctl
Date: Tue, 7 Sep 2004 07:05:11 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409070705.11154.adaplas@hotpop.com>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be> <200409070521.09524.adaplas@hotpop.com> <413CDD80.4020106@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4SXF-0002V5-BZ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Sep 2004 16:04:29 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C4SXD-0001Lm-Kl
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Sep 2004 16:04:29 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 15E527C8ED5
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  6 Sep 2004 23:04:14 +0000 (UTC)
In-Reply-To: <413CDD80.4020106@comcast.net>
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
To: linux-fbdev-devel@lists.sourceforge.net, Zack <plinius@comcast.net>

On Tuesday 07 September 2004 05:58, Zack wrote:
> Antonino A. Daplas wrote:
> >So, if fbdev is going to support drawing
> >routines for userspace, then fbdev will need 2 versions of each of the
> >drawing function.  That is a waste of good code.
>
> Looking at drivers/video/cfbfillrect.c it says in the comments that 24bpp
> mode is "broken". Perhaps the routine is fast for 8/16/32bpp but for now,

That comment is old, 24 bpp is not broken.  It's not the fastest code, but not 
the slowest either.

> I'd rather rely on my own routine which supports 24bpp since I mainly use
> that. Zack
>

And you can (see drivers with their own xxxfb_* routines).  The only thing is 
that you cannot use it in userland.  

Tony




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
