From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: FB accel capabilities patch
Date: Thu, 20 May 2004 09:31:01 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1085009460.15182.87.camel@gaston>
References: <Pine.LNX.4.58.0405191118170.4760@rosencrantz.theboonies.us>
	 <20040519030319.1f0e6eec.akpm@osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQadb-0000lQ-Ai
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 19 May 2004 16:38:15 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BQada-0006yr-TG
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 19 May 2004 16:38:15 -0700
In-Reply-To: <20040519030319.1f0e6eec.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: David Eger <eger@theboonies.us>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Wed, 2004-05-19 at 20:03, Andrew Morton wrote:
> David Eger <eger@theboonies.us> wrote:
> >
> > A month or two ago I noticed that the framebuffer console driver doesn't
> >  know to do proper framebuffer acceleration in Linux 2.6;
> 
> For what fbdev operations will acceleration be used?

Ok, the story is ... fbdevs do have optional accel hooks for copyarea,
rectfill, and imageblit. However, the current fbcon console subsystem
doesn't properly adapt it's drawing techniques based on the accel
capabilities (blit + redraw is more efficient for example when you have
a fast accelerated copyarea, while full redraw is better in other cases,
etc...)

This patch adds "hints" provided by the fbdev to inform fbcon what are
its accel capabilities.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
