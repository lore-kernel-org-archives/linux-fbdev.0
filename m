From: Torgeir Veimo <torgeir@pobox.com>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC
	implementation
Date: Sat, 12 Mar 2005 17:03:03 +0000
Message-ID: <1110646984.5997.96.camel@atlantis.netenviron.com>
References: <1110636406.5997.86.camel@atlantis.netenviron.com>
	 <9e473391050312073314dcb39f@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAA11-00077T-7S
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 09:03:03 -0800
Received: from orb.pobox.com ([207.8.226.5])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DAA0z-0006sr-PX
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 09:03:03 -0800
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP id 6810570
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 12:03:00 -0500 (EST)
Received: from [192.168.1.18] (iampivot.plus.com [81.174.152.151])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id 1BA2D8B
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 12:02:59 -0500 (EST)
In-Reply-To: <9e473391050312073314dcb39f@mail.gmail.com>
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

On Sat, 2005-03-12 at 10:33 -0500, Jon Smirl wrote:
> You can't do this without coordination from X and DRM. 

> Because of these issues WAITFORVSYNC in radeondb has to wait for
> merged DRM/fbdev to be implemented.

It's a bit hard to track the merge-dri-and-db work, so I'm basing it on
mainline kernel. Is there a common repository for this work somewhere?

I think it would be a good idea to settle on a common set of register
locations and values. Right now the #defines names used by framebuffers
differ quite a lot from those used by dri.

-- 
Torgeir Veimo <torgeir@pobox.com>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
