From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbdv/fbcon pending problems
Date: Thu, 26 Feb 2004 19:45:47 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402261941520.20525-100000@phoenix.infradead.org>
References: <20040226194020.GF17390@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AwRbl-0007PA-KN
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 26 Feb 2004 11:55:45 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AwRSD-0008OM-9N
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 26 Feb 2004 11:45:53 -0800
In-Reply-To: <20040226194020.GF17390@guug.org>
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
To: Otto Solares <solca@guug.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>


> Exactly, that's the whole point, if you want userland accel you must disable
> kernel land accel.  That's was my question against acceleration work inside
> the kernel.  Nobody use it in userland and is the stability devil in fbdev.
> If you want acceleration in userland there is mesa-solo or directfb or console-sdl.
> 
> In short acceleration belongs to specialized libs not the kernel.
> 
> Why accel it is needed for font drawing?, i am pretty sure my 8bit video old
> sparc doesn't have any accel and is pretty capable for drawing fonts.

Because we are going to run into graphics hardware that don't have 
framebuffers. The solution is the one we are approaching now. That fbcon 
be a client like userland apps to the accel engine. You will see it will 
all work out :-)



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
