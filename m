From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Don't allow softcursor use from userland
Date: Sat, 6 Aug 2005 21:27:29 -0700
Message-ID: <20050806212729.0b36a640.akpm@osdl.org>
References: <Pine.LNX.4.56.0508070327550.12196@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1cmg-0005uo-1T
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 Aug 2005 21:29:14 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1E1cme-0007UJ-Mz
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 Aug 2005 21:29:14 -0700
In-Reply-To: <Pine.LNX.4.56.0508070327550.12196@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, geert@linux-m68k.org, adaplas@hotpop.com

James Simmons <jsimmons@infradead.org> wrote:
>
>  This patch forbids the cursor use from userland. The reason is that the 
>  cursor area could be altered by a another process and the current system
>  doesn't handle syncing those updates.

Can this change break existing apps?


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
