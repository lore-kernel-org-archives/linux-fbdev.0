From: Otto Solares <solca@guug.org>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 19:06:12 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040429010612.GC24584@guug.org>
References: <Pine.LNX.4.44.0404271938330.20536-100000@phoenix.infradead.org> <408EE34F.8080106@undead.cc> <1083107454.16544.42.camel@gaston> <20040428002037.GE22495@guug.org> <1083112565.20473.10.camel@gaston> <20040428070832.GA23411@guug.org> <1083147416.18416.24.camel@thor.asgaard.local> <20040428163730.GA24448@guug.org> <1083191201.18413.73.camel@thor.asgaard.local> <1083195769.20089.106.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIzzr-0005qA-Og
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 18:05:51 -0700
Received: from guug.org ([168.234.203.30])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BIzzr-0008RH-AU
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 18:05:51 -0700
Content-Disposition: inline
In-Reply-To: <1083195769.20089.106.camel@gaston>
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
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Apr 29, 2004 at 09:42:50AM +1000, Benjamin Herrenschmidt wrote:
> The idea here is to have a small per-card low level driver (no common
> API or little of it) used to do the IRQ, fifo/ring management & blasting
> of registers. Everything else is client of this driver, including
> possibly fbcon. That also means we move all of mode management to
> userland, which I tend to slowly agree with. Remember that in 2.7, we
> may have an initramfs with klibc etc... thus we can have userland code
> shipping along with the kernel.

The fbdev is low-level, i vote for fbdev to be the single entity
for graphics in linux.

> I started working on a userland API do deal with all of the mode
> management cruft that could be implemented either on top of fbdev or
> something else, but I didn't have time to finish. And I think Jon Smirl
> started his own different thing (of course) there...

I would like to see that basic stuff being done in the kernel like
mode setting.  The drivers should have a better idea of modes than
libraries in userspace.

-otto



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
