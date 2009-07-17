From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: Re: [PATCH 1/2] ep93xx framebuffer driver
Date: Fri, 17 Jul 2009 13:35:56 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901AC200F@mi8nycmail19.Mi8.com>
References: <4A5FF431.2000308@bluewatersys.com>
	<4A5FF6BB.4000700@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hartleys@visionengravers.com>) id 1MRrLq-0002u9-RQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Jul 2009 17:36:06 +0000
Received: from exprod6og112.obsmtp.com ([64.18.1.29])
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MRrLj-0002U0-AV for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Jul 2009 17:36:06 +0000
Content-class: urn:content-classes:message
In-Reply-To: <4A5FF6BB.4000700@bluewatersys.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ryan Mallon <ryan@bluewatersys.com>, arm kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net, Daniele Venzano <d.venzano@motronica.com>

On Thursday, July 16, 2009 8:58 PM, Ryan Mallon wrote:
> Add platform support and video clock for ep93xx framebuffer driver
> 
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> ---

> +#include <mach/fb.h>

This new header is not included in either patchset.

Thanks,
Hartley

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
