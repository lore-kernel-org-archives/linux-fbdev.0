From: Zack <plinius@comcast.net>
Subject: Re: framebuffer ioctl
Date: Mon, 06 Sep 2004 12:56:26 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <413CC0EA.8070709@comcast.net>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be> <413A3735.9E7D2F11@orpatec.ch> <413B4925.5000706@comcast.net> <200409060926.07163.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4PbF-0004Sf-3b
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Sep 2004 12:56:25 -0700
Received: from rwcrmhc13.comcast.net ([204.127.198.39])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C4PbD-0007Pz-1P
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Sep 2004 12:56:24 -0700
In-Reply-To: <200409060926.07163.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas wrote:

>On Monday 06 September 2004 01:13, Zack wrote:
>  
>
>>4. new features would be optional anyway: fullscreen-guis need not
>>recognize their existence, but would benefit from doing so
>>since some fb drivers would override the generic routines
>>to implement accelerated routines.
>>
>One of the limitations of the in-kernel drawing routines is that they were 
>never designed to be used in user space.  This has been discussed a long time 
>ago so that the upper layer need not know the characteristics of the 
>low-level driver. 
>
>Possibly, the only drawing function that can be used by userspace is copyarea 
>(bitblt).  Fillrect (color fill) and imageblit (color expand) cannot be used 
>since they rely on pseudo_palette which is limited to 16 colors.
>
>I believe that the kernel framebuffer should only support features that cannot 
>be done in user space, such as interrupt handling.  I really recommend to 
>concentrate on one library (I recommend DirectFB) and enhance that.
>
>Note that the framebuffer ABI is quite consistent since its inception. So you 
>can rely on libraries based on fbdev, ie DirectFB, even X, to consistently 
>work with whatever version of the kernel.
>
>Tony
>
I think you may be misinterpreting my intent. I am strictly anti-bloat,
so I don't want a larger kernel. By the same token, I don't use
X because it is bloated--X uses 16 megs minimum on my system,
and that is very much not to my taste.

Directfb seems geared toward being overly impressive,
which says to me that if it's not bloated already, it will be later.

My new routines are small.

>I believe that the kernel framebuffer should only support features that cannot 
>be done in user space, such as interrupt handling.  I really recommend to 
>concentrate on one library (I recommend DirectFB) and enhance that.


For other people reading this, the idea of putting everything into
userspace that can be put there is called an "exokernel" approach.
It's a matter of taste. To me it's just another way bloat is achieved.

Zack



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
