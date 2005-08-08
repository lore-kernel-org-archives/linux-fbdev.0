From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Don't allow softcursor use from
 userland
Date: Mon, 8 Aug 2005 18:35:38 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508081831220.27739@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0508070327550.12196@pentafluge.infradead.org>
 <42F5E3E7.3020901@gmail.com> <Pine.LNX.4.56.0508080013400.12912@pentafluge.infradead.org>
 <42F6AE75.6090409@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2BXI-0002W4-QX
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Aug 2005 10:35:40 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E2BXI-0005kd-DU
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Aug 2005 10:35:40 -0700
In-Reply-To: <42F6AE75.6090409@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>



What is wrong with brekaing this patch into smaller pieces????????????
I'm not getting a answer!!!!! As I said no giant patches that tocuh every 
driver.

> > has software image blit and hardware fillrect. You want to have fbcon use 
> >   
> 
> Then the driver sets fbops->fb_cursor with its own version that does 
> fillrect instead of imageblit.

No. fb_cursor is only used for a hardware cursor case. 

> If you want to add userspace support for hardware cursors then you have to
> create another API. If you don't want another API, then forget about userspace
> support. Overloading fbops->fb_cursor is not the answer.

So fbops->fb_cursor will not be used at all for the console? 

Look the patch I sent is small and doesn't interfere with many drivers. It 
does stop your desires either. Personally softcursor should go away.



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
