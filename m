From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this one works ;-)
Date: Mon, 19 Apr 2004 11:50:19 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1082339419.15103.0.camel@gaston>
References: <Pine.LNX.4.58.0404190339060.2288@rosencrantz.theboonies.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFO15-0000AS-Ed
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 18 Apr 2004 18:56:11 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BFO15-00061g-7e
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 18 Apr 2004 18:56:11 -0700
In-Reply-To: <Pine.LNX.4.58.0404190339060.2288@rosencrantz.theboonies.us>
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
To: David Eger <eger@theboonies.us>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2004-04-19 at 11:46, David Eger wrote:
> Dear Ben,
> 
> Please apply this patch to the radeonfb driver (I think of you as the
> maintainer for this driver) and then forward to James and Linus :-)
> 
> This fixes the same problem as mentioned before -- overlapping
> regions sent to copyarea() get fux0r3d.  This patch corrects my earlier
> braindamage of setting up w, h, dx, etc. and then forgetting to use them
> later on.  Ah, having two versions of the same code (userspace and kernel
> space) -- little details like that just float past the eye...  no problem
> with fbcon at all, as i previously speculated.  apologies to james.

Excellent. Thanks.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
