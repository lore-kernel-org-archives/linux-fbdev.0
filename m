From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Don't allow softcursor use from
 userland
Date: Mon, 8 Aug 2005 19:16:07 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508081915360.27739@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0508070327550.12196@pentafluge.infradead.org> 
 <42F5E3E7.3020901@gmail.com>  <Pine.LNX.4.56.0508080013400.12912@pentafluge.infradead.org>
  <42F6AE75.6090409@gmail.com>  <Pine.LNX.4.56.0508081831220.27739@pentafluge.infradead.org>
 <9e47339105080810595158e822@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2CAU-0004sI-48
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Aug 2005 11:16:10 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E2CAT-0004zm-Iy
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Aug 2005 11:16:10 -0700
In-Reply-To: <9e47339105080810595158e822@mail.gmail.com>
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
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>


> > So fbops->fb_cursor will not be used at all for the console?
> 
> fbconsole check to see if fbops->fb_cursor is not null, if it is not
> null it uses the hardware cursor. Otherwise it uses it's internal
> softcursor implementation.

See my other email about drivers have a hwcursor flag to turn hardware 
cursor off and on.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
