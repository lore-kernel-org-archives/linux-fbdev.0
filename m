From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: [PATCH] Don't allow softcursor use from
 userland
Date: Mon, 8 Aug 2005 00:25:40 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508080021090.12912@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0508070327550.12196@pentafluge.infradead.org> 
 <20050806212729.0b36a640.akpm@osdl.org> <9e47339105080621415e2f6344@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1uWY-0006Wm-0M
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 16:25:46 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E1uWW-0007rh-GQ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 16:25:46 -0700
In-Reply-To: <9e47339105080621415e2f6344@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, geert@linux-m68k.org, adaplas@hotpop.com


> This change is not agreed too yet. Antonio and I are proposing a
> different solution.
> http://comments.gmane.org/gmane.linux.fbdev.devel/7118
> 
> The alternate solution takes into account that fbconsole is the only
> user of softcursor and moves softcursor into console.  fbdev drivers
> then only expose a cursor entry point if they have a hardware cursor.
> If they don't the entry point is NULL.
> 
> Nether solution should break existing apps since the existing
> softcursor scheme was broken from user space and unusable.

That is too big a change at one time and moving soft_cursor to fbcon is a 
partial solution. See my other email. I don't want to touch every driver
at this point!! First prevent anyone from using soft cursor from userland.
Second fix fbcon version of the cursor. That mean doing more than just 
moving the softcursor into fbcon. Third as drivers are updated remove the 
soft cursor hooks. It will not break anything. 

P.S
  When I first started out I sent giant patches that impacted alot of 
things. People got upset. Please don't repeat my mistakes with giant 
patches that impact every driver.




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
