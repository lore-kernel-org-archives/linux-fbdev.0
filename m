From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 18:02:18 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404281755560.1187-100000@phoenix.infradead.org>
References: <1083122306.20091.33.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIsRz-0006aG-Hf
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 10:02:23 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIsRz-0003S8-5f
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 10:02:23 -0700
In-Reply-To: <1083122306.20091.33.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alex Stewart <alex@foogod.com>, grim@undead.cc, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > If they aren't, you shouldn't be using them on anything other than
> > dedicated framebuffers anyway, really.  It's not hard to make an app work
> > with VTs and it really is the correct way to do things for anything that
> > is likely to be run in a VT-console environment.
> 
> A good idea would be to produce a library that implement most of the
> ground VT handling work in fact... That would simplify things for
> apps tremendously. Though it should probably sit between the app
> and the kernel for console input as well.

That would be nice. The only problem is history has shown that lots of 
people think the library should be done one way verses another and we need 
up with lots of libraries. 
 



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
