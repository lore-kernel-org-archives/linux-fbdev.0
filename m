From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: [PATCH] mach64 atari patch
Date: Mon, 8 Aug 2005 00:09:51 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508080003360.12912@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0508070315260.12196@pentafluge.infradead.org>
 <Pine.LNX.4.62.0508071316230.31010@gorilla.sonytel.be>
 <20050807094618.0cc4cadc.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1uHI-0005nl-JD
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 16:10:00 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E1uHH-0005vm-6k
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 16:10:00 -0700
In-Reply-To: <20050807094618.0cc4cadc.akpm@osdl.org>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, Andrew Morton <akpm@osdl.org>


> 
> Thanks, Geert.
> 
> James, I'll drop this one - it seems to need version 2.

Yeah!!! I got no response earlier. Now I can fix the patch up.

> I'll also drop fbdev-dont-allow-softcursor-use-from-userland.patch as there
> seems to be quite a bit of controversy there.

The disagreement was how much to change it at one time. Some patches where 
just huge and did massive changes to all drivers. I wanted to break the patch 
up into little pieces. Please apply this patch otherwise we will be stuck 
where we are. 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
