From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: EDID for radeonfb
Date: 22 Aug 2003 09:33:22 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1061537601.18043.35.camel@gaston>
References: <20030821212107.55742.qmail@web14915.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-4-31.w217-128.abo.wanadoo.fr ([217.128.74.31] helo=gaston)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19q6R0-0007jX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 22 Aug 2003 00:34:10 -0700
In-Reply-To: <20030821212107.55742.qmail@web14915.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: kronos@kronoz.cjb.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

On Thu, 2003-08-21 at 23:21, Jon Smirl wrote:
> The list of modes supported by the board has to get worked into this too. Who
> should do the diff'ing to determine valid modes? The list of legal monitor
> modes might be from EDID or the fbmode database.
> 
> Should sysfs have one entry for legal board modes and one for legal monitor
> modes? Or should it just have a single entry for legal combos?

Good point. Looking at what things like MacOS do, I'd say fbmon provides
a list to radeonfb, which filters it out and creates the "real" list.

I think it's not time to do a full blown fbmon layer now, we need more
experience with it and it's too late in the 2.6 process. I'll probably
just keep fbmon as a pool of "utility" functions and do most from
radeonfb (and aty128fb if I get a chance to port the i2c code) for now.

One thing I'm hesitating to do is to dive into a driver split &
rearchitecture now or not... 

Ben.



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
