From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 17:53:03 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404281752020.1187-100000@phoenix.infradead.org>
References: <408F0727.9030906@undead.cc>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIsJA-000434-6f
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 09:53:16 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIsJ8-0001DX-LK
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 09:53:16 -0700
In-Reply-To: <408F0727.9030906@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: Otto Solares <solca@guug.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> That's what I'm currently working on and is partially what's behind my 
> messages about multiple vars and whatnot.  It looks like most of the 
> stuff is already in the kernel.  I'm just going through the various 
> subsystems trying to figure out what still needs to be changed.  One 
> things is the the vt driver's notion of which vt is visible.  Currently 
> that's fg_console == visible but with multiple monitors that doesn't 
> hold true.

What your doing is alot of work. Trust me because I already have reworked 
the VT layer to support multiple terminals. Its more than fixing 
fg_console.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
