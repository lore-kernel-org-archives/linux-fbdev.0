From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] Don't allow softcursor use from userland
Date: Sun, 07 Aug 2005 18:35:19 +0800
Message-ID: <42F5E3E7.3020901@gmail.com>
References: <Pine.LNX.4.56.0508070327550.12196@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1iUt-0006HG-90
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 03:35:15 -0700
Received: from wproxy.gmail.com ([64.233.184.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1iUs-0002l8-2X
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 03:35:15 -0700
Received: by wproxy.gmail.com with SMTP id i21so590240wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Aug 2005 03:35:08 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>

James Simmons wrote:
> 
> This patch forbids the cursor use from userland. The reason is that the 
> cursor area could be altered by a another process and the current system
> doesn't handle syncing those updates.
> 

I don't really like this change.  I prefer Jon's proposal of setting
fbops->fb_cursor = NULL and moving softcursor.c to drivers/video/console.
This will slash > 200 lines of source code and several bytes from the kernel
image size. Plus it's cleaner.

Tony



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
