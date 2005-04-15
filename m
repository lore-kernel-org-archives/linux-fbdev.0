From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [2.6 patch] drivers/video/intelfb/intelfbdrv.h
Date: Fri, 15 Apr 2005 12:52:06 +0800
Message-ID: <200504151252.09918.adaplas@hotpop.com>
References: <20050415004849.GJ20400@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DMdt6-0005b2-0s
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Apr 2005 20:22:28 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DMdt4-0007dW-BG
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Apr 2005 20:22:27 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 0FAD815327EA
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 16 Apr 2005 03:22:17 +0000 (UTC)
In-Reply-To: <20050415004849.GJ20400@stusta.de>
Content-Disposition: inline
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
To: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Ingo Oeser <ioe-lkml@axxeo.de>

On Friday 15 April 2005 08:48, Adrian Bunk wrote:
> Ingo Oeser noticed that all that intelfbdrv.h contains are prototypes
> for static functions - and such prototypes don't belong into header
> files.
>
> This patch therefore removes drivers/video/intelfb/intelfbdrv.h and
> moves the prototypes to intelfbdrv.c .
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Patch is linewrapped.  Can you resend?

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
