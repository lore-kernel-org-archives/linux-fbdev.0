From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: New radeonfb 0.2.0 (take 2)
Date: Fri, 12 Sep 2003 18:51:12 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309121850071.5017-100000@phoenix.infradead.org>
References: <1063124237.1356.1.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xs4j-0002en-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 10:51:17 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19xs4i-0000Cc-I2
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 10:51:16 -0700
In-Reply-To: <1063124237.1356.1.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Kronos <kronos@kronoz.cjb.net>


> > Base does PCI IDs, EDID, mode setting, command parsing, maybe hardware cursor,
> > VT switching and state saving.
> > Second piece does fbcon support such as mapping fb to kernel space, fb accels,
> > etc.
> 
> The current fbdev layer, afaik, impose vt switching, mode setting,
> cursor support etc... to imply fbcon. The mapping of fb is just a
> 2 liner remaining that isn't worth a separate module.

Correct.
 
> Also, the accel API in 2.6 is meant to be used by more than just
> fbcon afaik.
>
> James, can you comment on this ?

Originally I had ioctl for the accel stuff for testing purposes. Ites 
expensive tho. I wonder if using sysfs for this would be worth it?





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
