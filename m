From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] fbdev: workaround for broken X
	servers
Date: Sat, 06 Nov 2004 11:38:39 +1100
Message-ID: <1099701519.3884.32.camel@gaston>
References: <1099448020.900.25.camel@gaston>
	 <1099655227.3946.17.camel@gaston>
	 <Pine.GSO.4.61.0411051313130.15464@waterleaf.sonytel.be>
	 <200411052055.17316.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQEbX-0001A6-V1
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 16:38:55 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CQEbW-0000ue-IM
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 16:38:55 -0800
In-Reply-To: <200411052055.17316.adaplas@hotpop.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>

On Fri, 2004-11-05 at 20:55 +0800, Antonino A. Daplas wrote:

> And make it black is usually done in software (by memsetting the screen with
> the black color).  
> 
> So why not this:  In fbcon_blank(), if the blank parameter is:
> 
> 0 - unblank the screen, and call info->fbops->fb_blank(VESA_NO_BLANKING), 
>      then return a nonzero value to force a redraw.
> 1,2,3,4 - clear the screen with all black
> 2,3,4 - call info->fbops->fb_blank(blank - 1);
> 
> Similarly, we can do the same thing in fbmem.c:fb_blank(), but without the software
> blanking.
> 
> Drivers will just need to follow the VESA_* defines in fb.h (which happens to be also
> defined in console.h)

Ah... so radeonfb is correct then, and fb_blank() is not ? X is
definitely passing +1 values it seems.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
