From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC
	implementation
Date: Sun, 13 Mar 2005 10:14:24 +1100
Message-ID: <1110669265.5787.37.camel@gaston>
References: <1110636406.5997.86.camel@atlantis.netenviron.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAFp1-0000Ht-3x
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 15:15:03 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DAFoz-0003Ab-Ji
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 15:15:03 -0800
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j2CNCmgJ025837
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 17:12:49 -0600
In-Reply-To: <1110636406.5997.86.camel@atlantis.netenviron.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2005-03-12 at 14:06 +0000, Torgeir Veimo wrote:
> This is an implementation of the FB_WAITFORVSYNC ioctl for the radeonfb.
> A small test application is attached at the end. This patch is against
> vanilla 2.6.11.
> 
> Signed-off-by: Torgeir Veimo <torgeir@pobox.com>
> 

Please, CC me further radeonfb patches.

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
