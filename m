From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Don't allow softcursor use from
 userland
Date: Mon, 8 Aug 2005 00:17:02 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508080013400.12912@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0508070327550.12196@pentafluge.infradead.org>
 <42F5E3E7.3020901@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1uOA-00069w-LD
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 16:17:06 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E1uOA-0006Ew-9r
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 16:17:06 -0700
In-Reply-To: <42F5E3E7.3020901@gmail.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>


> James Simmons wrote:
> > 
> > This patch forbids the cursor use from userland. The reason is that the 
> > cursor area could be altered by a another process and the current system
> > doesn't handle syncing those updates.
> > 
> 
> I don't really like this change.  I prefer Jon's proposal of setting
> fbops->fb_cursor = NULL and moving softcursor.c to drivers/video/console.
> This will slash > 200 lines of source code and several bytes from the kernel
> image size. Plus it's cleaner.

One change at a time. If you want to properly do cursor in fbcon then just 
moving softcursor there is not the answer. What if you have a driver that 
has software image blit and hardware fillrect. You want to have fbcon use 
the hardware fillrect to draw the cursor using xor mode. See the problem 
is more than just moving softcursor.c. Softcursor.c should go away 
completely. 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
