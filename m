From: Richard Drummond <evilrich@rcdrummond.net>
Subject: Re: [PATCH] Clean-up and bug fix for tdfxfb framebuffer size detection
Date: Fri, 22 Apr 2005 13:17:36 -0500
Message-ID: <200504221317.36902.evilrich@rcdrummond.net>
References: <200504212309.12407.evilrich@rcdrummond.net> <4268BA5B.5020507@tebibyte.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DP2ih-0001Gj-Ne
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Apr 2005 11:17:39 -0700
Received: from mail03.powweb.com ([66.152.97.36])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DP2ig-00085c-Db
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Apr 2005 11:17:39 -0700
In-Reply-To: <4268BA5B.5020507@tebibyte.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Chris Ross <chris@tebibyte.org>, linux-kernel@vger.kernel.org

Hi Chris

On Friday 22 April 2005 03:48 am, Chris Ross wrote:
> I /do/ have the hardware, so I am very glad to see someone working on
> support for the Voodoo 5.

I am glad somebody is interested. ;-)

> Are there any specific tests you would like me 
> to perform and send you the results from?

It's quite simple really. With this patch, does tdfxfb report the right amount 
of framebuffer memory for your card? The method it used to determine the 
amount of memory for the Voodoo4/5 before was wrong. If it gave the right 
value before, then it was probably just a coincidence.

Cheers,
Rich


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
