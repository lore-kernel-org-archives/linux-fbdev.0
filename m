From: Torgeir Veimo <torgeir@pobox.com>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC
	implementation
Date: Sun, 13 Mar 2005 03:15:39 +0000
Message-ID: <1110683740.5997.105.camel@atlantis.netenviron.com>
References: <1110636406.5997.86.camel@atlantis.netenviron.com>
	 <1110669265.5787.37.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAJZv-0004uS-Ju
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 19:15:43 -0800
Received: from orb.pobox.com ([207.8.226.5])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DAJZt-0005vc-TL
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 19:15:43 -0800
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP id 90A6EB1
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 22:15:36 -0500 (EST)
Received: from [192.168.1.18] (iampivot.plus.com [81.174.152.151])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id 393748E
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 22:15:36 -0500 (EST)
In-Reply-To: <1110669265.5787.37.camel@gaston>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Sun, 2005-03-13 at 10:14 +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2005-03-12 at 14:06 +0000, Torgeir Veimo wrote:
> > This is an implementation of the FB_WAITFORVSYNC ioctl for the radeonfb.
> > A small test application is attached at the end. This patch is against
> > vanilla 2.6.11.
> > 
> > Signed-off-by: Torgeir Veimo <torgeir@pobox.com>
> > 
> 
> Please, CC me further radeonfb patches.

Sure! Am mostly driven by what I need myself, not by any agenda... : 

-- 
Torgeir Veimo <torgeir@pobox.com>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
