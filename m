From: John Zielinski <grim@undead.cc>
Subject: Re: [PATCH] neofb patches
Date: Tue, 27 Apr 2004 21:21:43 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <408F0727.9030906@undead.cc>
References: <Pine.LNX.4.44.0404280019070.23153-100000@phoenix.infradead.org> <408EF0D9.6000403@undead.cc> <20040428002919.GG22495@guug.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIdlm-0005iB-8r
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 18:21:50 -0700
Received: from mail.undead.cc ([216.126.84.18])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BIdll-0005iY-SU
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 18:21:49 -0700
In-Reply-To: <20040428002919.GG22495@guug.org>
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
To: Otto Solares <solca@guug.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Otto Solares wrote:

>I was wondering if it is possible currently (kernel 2.6.5) to
>have 2 differents video cards in 2 differents VCs and in 2
>differents fbdev's.  I have an old trident pci card and one
>radeon agp card.  I want to run X (Xfbdev) in the trident one
>and mesa-solo in the radeon one, is that possible? how?
>  
>

That's what I'm currently working on and is partially what's behind my 
messages about multiple vars and whatnot.  It looks like most of the 
stuff is already in the kernel.  I'm just going through the various 
subsystems trying to figure out what still needs to be changed.  One 
things is the the vt driver's notion of which vt is visible.  Currently 
that's fg_console == visible but with multiple monitors that doesn't 
hold true.

I'll post when I succeed.  :)

John




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
