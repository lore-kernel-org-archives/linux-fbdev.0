From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
Date: Sun, 6 Mar 2005 14:30:47 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0503061427250.2997__43391.3556895733$1110138950$gmane$org@poirot.grange>
References: <Pine.LNX.4.60.0503052355320.12643@poirot.grange>
 <Pine.LNX.4.60.0503061047590.3733@poirot.grange>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7vrM-0006lQ-B2
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Mar 2005 05:31:52 -0800
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D7vrK-00042k-Ba
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Mar 2005 05:31:51 -0800
In-Reply-To: <Pine.LNX.4.60.0503061047590.3733@poirot.grange>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jim.hague@acm.org
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Sun, 6 Mar 2005, Guennadi Liakhovetski wrote:

> I wasn't quite correct in my report yesterday. Replacing pm2fb.c from 
> 2.6.11 with 2.6.10 fixes only one problem - the font becomes white again 
> and penguin images get fixed. But switching from X to vt still doesn't 
> work. It works under 2.6.10-rc2.

Ok. Reverting also fbcon.[hc] to 2.6.10 fixes the X-switching problem too.

Thanks
Guennadi
---
Guennadi Liakhovetski



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
