From: Zack <plinius@comcast.net>
Subject: Re: framebuffer ioctl
Date: Mon, 06 Sep 2004 14:58:24 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <413CDD80.4020106@comcast.net>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be> <200409060926.07163.adaplas@hotpop.com> <413C83F7.D4CB1EAD@orpatec.ch> <200409070521.09524.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4RVH-00037r-Ou
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Sep 2004 14:58:23 -0700
Received: from rwcrmhc12.comcast.net ([216.148.227.85])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C4RVE-0008Jw-Mx
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Sep 2004 14:58:22 -0700
In-Reply-To: <200409070521.09524.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas wrote:

>So, if fbdev is going to support drawing 
>routines for userspace, then fbdev will need 2 versions of each of the 
>drawing function.  That is a waste of good code.  

Looking at drivers/video/cfbfillrect.c it says in the comments that 24bpp mode
is "broken". Perhaps the routine is fast for 8/16/32bpp but for now,
I'd rather rely on my own routine which supports 24bpp since I mainly use that.
Zack




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
