From: James Simmons <jsimmons@infradead.org>
Subject: Re: [BK FBDEV] A few more updates.
Date: Wed, 26 Mar 2003 05:34:44 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303260519380.12718-100000@phoenix.infradead.org>
References: <1048649746.998.28.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18y3ZG-0003Nj-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Mar 2003 21:35:19 -0800
In-Reply-To: <1048649746.998.28.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> 1.  The following lines are missing from softcursor.c, but is present in
> fb_show_logo() where it shoudn't be:
> 
> 	atomic_dec(&info->pixmap.count);
> 	smp_mb__after_atomic_dec();
> 
> In both cases, the reference counting will be incorrect which can cause
> irregular cursor flashing and unnecessary "syncing".  Only functions
> that call fb_get_buffer_offset() need to decrement the reference count
> afterwards.

Fixed. Applied. I missed it when I was applying your patches by hand. My 
tree was way to different to accept your patches. 
 
> 2.  I applied your workqueue patch and changed locking from spinlocks to
> semaphores in fb_get_buffer_offset().

Cool. Needed really bad. Applied.

> 3.  BTW, there are too many kmalloc's/kfree's in accel_cursor() and
> softcursor().  Personally, I would rather have 2 64-byte buffers for the
> mask and the data in the info->cursor structure than allocating/freeing
> memory each time the cursor flashes.  However, if you prefer doing it
> this way, the patch also includes changes so kmallocs are only done when
> necessary.  Still, accel_cursor() has unnecessary work being done, such
> as always creating the mask bitmap, when a simple flag to monitor cursor
> shape changes could prevent all this.

I agree. The problem is the upper layer of the console system is to brain 
dead. Its either erase the cursor or redraw it again. There is no way to 
just say cursor just moved. There is a CM_MOVE but the upper layer doesn't 
even use it :-( If you look at vgacon and friends you will see they 
recreate the cursor every time the cursor blinks. Yes even vgacon.c does 
this. It is stupid and brain dead but that is the way the upper layers of 
the console work. The correct solution would be to use actually use 
CM_MOVE in the upper layers.

> 5.  softcursor should not concern itself with memory bookkeeping, and
> must be able to function with just the parameter passed to it in order
> to keep it as simple as possible.  These tasks are moved to
> accel_cursor.

We do if we make a ioctl for cursors. I'm trying to avoid reprogramming 
the hardware over and over again if the properties of the cursor don't 
change. The idea is similar to passing in var and comparing it to the var 
in struct fb_info. 

> 6.  The patch should also fix the "irregularly dashed" cursor.

Okay.

> PS:  What happened to the logo?  I just get a white square in the uppper left corner.

Strange. It should work. I reworked the logo code anyways. I did this 
because if we have more than one framebuffer in the system, say vesafb and 
vga16fb. We need to select the 16 color logo and a 224 color logo. The 
right logo needs to be draw on the right screen.



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
