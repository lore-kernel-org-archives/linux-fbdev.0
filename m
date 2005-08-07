From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Don't allow softcursor use from userland
Date: Mon, 8 Aug 2005 00:19:45 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508080019200.12912@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0508070327550.12196@pentafluge.infradead.org>
 <20050806212729.0b36a640.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1uQl-0006HU-OD
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 16:19:47 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E1uQl-0006no-8T
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 16:19:47 -0700
In-Reply-To: <20050806212729.0b36a640.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, geert@linux-m68k.org, adaplas@hotpop.com


On Sat, 6 Aug 2005, Andrew Morton wrote:

> James Simmons <jsimmons@infradead.org> wrote:
> >
> >  This patch forbids the cursor use from userland. The reason is that the 
> >  cursor area could be altered by a another process and the current system
> >  doesn't handle syncing those updates.
> 
> Can this change break existing apps?

No. No one uses the sysfs for the cursro yet.  


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
