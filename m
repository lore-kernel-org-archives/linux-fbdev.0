From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] fbdev: workaround for broken X servers
Date: Fri, 5 Nov 2004 20:55:14 +0800
Message-ID: <200411052055.17316.adaplas@hotpop.com>
References: <1099448020.900.25.camel@gaston> <1099655227.3946.17.camel@gaston> <Pine.GSO.4.61.0411051313130.15464@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQ3dy-0006Je-Cy
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 04:56:42 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CQ3dx-0007c9-G2
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 04:56:42 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id A2FAB988617
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri,  5 Nov 2004 12:55:24 +0000 (UTC)
In-Reply-To: <Pine.GSO.4.61.0411051313130.15464@waterleaf.sonytel.be>
Content-Disposition: inline
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
To: Geert Uytterhoeven <geert@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Friday 05 November 2004 20:15, Geert Uytterhoeven wrote:
> On Fri, 5 Nov 2004, Benjamin Herrenschmidt wrote:
> > > But every existing application that uses (shiver) the kernel headers
> > > will break after this change...
> >
> > Geert, can you explain the whole story please ?
>
> The story about the +1 or the story about the breakage?
>
> The Story About The +1
> ----------------------
> Since the VESA levels do not provide a way to blank (`make it black') the
> screen, the +1 is introduced. Hence 0 means unblank, 1 means black screen,
> 2 means lowest power save level, and so on...

And make it black is usually done in software (by memsetting the screen with
the black color).  

So why not this:  In fbcon_blank(), if the blank parameter is:

0 - unblank the screen, and call info->fbops->fb_blank(VESA_NO_BLANKING), 
     then return a nonzero value to force a redraw.
1,2,3,4 - clear the screen with all black
2,3,4 - call info->fbops->fb_blank(blank - 1);

Similarly, we can do the same thing in fbmem.c:fb_blank(), but without the software
blanking.

Drivers will just need to follow the VESA_* defines in fb.h (which happens to be also
defined in console.h)

Tony 




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
