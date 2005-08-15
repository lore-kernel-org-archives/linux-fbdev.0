From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 2/2] intelfb/fbdev: Save info->flags
 in a local variable
Date: Mon, 15 Aug 2005 17:28:45 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508151726040.7300@pentafluge.infradead.org>
References: <430098A7.1080102@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E4hpY-0006i5-MO
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Aug 2005 09:28:56 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E4hpX-000616-Ci
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Aug 2005 09:28:56 -0700
In-Reply-To: <430098A7.1080102@gmail.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Sylvain Meyer <sylvain.meyer@worldonline.fr>, Pavel Kysilka <goldenfish@bsys.cz>


>   This bug is caused by intelfb unintentionally destroying info->flags in
>   set_par(). Therefore the flag, FBINFO_MISC_USEREVENT used to notify
>   fbcon of a mode change was cleared causing the above problem. This bug
>   though is not intelfb specific, as other drivers may also be affected.
> 
>   The fix is to save info->flags in a local variable before calling any
>   of the driver hooks.  A more definitive fix (for post 2.6.13) is to
>   separate info->flags into one that is set by the driver and another that
>   is set by core fbdev/fbcon.

The only problem I have with that patch is that the flags variable can 
also contain what accelerated features the driver supports in that mode.
It is possible to have a old mode that supports no hardware acceleration 
and then change to a mode that does. Save the whole flag has us lose that 
information. What I suggest is that we mask the flag to save the upper 
bits and save only those. Then after mode switching OR it with the new 
mask. 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
