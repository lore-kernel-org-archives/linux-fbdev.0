From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: framebuffer ioctl
Date: Mon, 6 Sep 2004 09:33:00 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409060926.07163.adaplas@hotpop.com>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be> <413A3735.9E7D2F11@orpatec.ch> <413B4925.5000706@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C48N3-0000JL-BF
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 05 Sep 2004 18:32:37 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C48N1-0006JM-Ra
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 05 Sep 2004 18:32:37 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 9123F10B3D6D
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  6 Sep 2004 01:32:28 +0000 (UTC)
In-Reply-To: <413B4925.5000706@comcast.net>
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

On Monday 06 September 2004 01:13, Zack wrote:
> 4. new features would be optional anyway: fullscreen-guis need not
> recognize their existence, but would benefit from doing so
> since some fb drivers would override the generic routines
> to implement accelerated routines.
>

One of the limitations of the in-kernel drawing routines is that they were 
never designed to be used in user space.  This has been discussed a long time 
ago so that the upper layer need not know the characteristics of the 
low-level driver. 

Possibly, the only drawing function that can be used by userspace is copyarea 
(bitblt).  Fillrect (color fill) and imageblit (color expand) cannot be used 
since they rely on pseudo_palette which is limited to 16 colors.

I believe that the kernel framebuffer should only support features that cannot 
be done in user space, such as interrupt handling.  I really recommend to 
concentrate on one library (I recommend DirectFB) and enhance that.

Note that the framebuffer ABI is quite consistent since its inception. So you 
can rely on libraries based on fbdev, ie DirectFB, even X, to consistently 
work with whatever version of the kernel.

Tony
  




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
