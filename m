From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: fbdv/fbcon pending problems
Date: Tue, 24 Feb 2004 19:33:13 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1077611593.28488.162.camel@gaston>
References: <Pine.LNX.4.44.0402231823570.11599-100000@phoenix.infradead.org>
	 <1077576644.5960.77.camel@gaston>
	 <Pine.GSO.4.58.0402240936270.3187@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvYG9-0007pq-K9
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Feb 2004 00:49:45 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AvY83-00033h-BD
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Feb 2004 00:41:23 -0800
In-Reply-To: <Pine.GSO.4.58.0402240936270.3187@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>


> What about renaming it to FB_ACTIVE_RESIZE?

Because it's not actually setting any mode, just returns a
valid "var" :) For now, fbcon will just do a set_var
FB_ACTIVATE_NOW right away, but userland may want to use
that to build mode lists without actually changing the mode...

Ben.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
