From: "Alex Stewart" <alex@foogod.com>
Subject: Re: [PATCH] neofb patches
Date: Fri, 23 Apr 2004 09:53:11 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <15833.171.72.5.12.1082739191.squirrel@www.foogod.com>
References: <Pine.LNX.4.44.0404211840040.9207-100000@phoenix.infradead.org>
        <1082574664.2344.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BH3wW-000794-Ho
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 09:54:24 -0700
Received: from adsl-209-182-168-213.value.net ([209.182.168.213] helo=firestar.foogod.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BH3wV-0005GL-Uf
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 09:54:24 -0700
In-Reply-To: <1082574664.2344.3.camel@localhost.localdomain>
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
To: adaplas@hotpop.com
Cc: linux-fbdev-devel@lists.sourceforge.net

> Yes, _all_ of the generic drawing functions expect the pseudopalette to
> be always u32.

Just curious, but if this is the case, why isn't pseudo_palette defined as
a "u32 *" (instead of "void *") in struct fb_info?  If anything outside
the driver itself is going to be using this, it really should be more
explicit what format it's supposed to be in.

For that matter, is it really kosher to have the logo code (or other
things external to the driver) setting pseudo_palette directly anyway? 
Shouldn't there be some sort of an interface function for this (at the
very least to let the driver know it's changed, in case it needs to know
that sort of thing)?

-alex




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
