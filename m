From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [patch] generic framebuffer support, cleanups
 and buglets with BPP < 32 (fwd)
Date: Wed, 16 Feb 2005 22:37:33 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502162236240.25965@pentafluge.infradead.org>
References: <Pine.LNX.4.62.0502161022440.12747@numbat.sonytel.be>
 <200502162155.53719.adaplas@hotpop.com> <200502161506.45868.eckhardt@satorlaser.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1Xne-0006Sv-P9
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 14:37:38 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D1Xnc-0004vI-Vx
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 14:37:38 -0800
Received: from jsimmons (helo=localhost)
	by pentafluge.infradead.org with local-esmtp (Exim 4.43 #1 (Red Hat Linux))
	id 1D1XnZ-0006lN-HJ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 22:37:35 +0000
In-Reply-To: <200502161506.45868.eckhardt@satorlaser.com>
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
To: linux-fbdev-devel@lists.sourceforge.net


> Changes:
>  * removed trailing whitespace
>  * use helper function for common bitwise operations
>  * fixed several cases where either the wrong mask was used for bitops
>    or the mask was computed falsely, messing up <32 BPP support
>  * added self-tests for bitcpy_rev() algorithm in module-init function
>  * no need to use explicitly sized integers in some cases
>  * added a few comments where things weren't obvious to me

Merged a few changes from me.

   * Replaced LONG_MASK, SHIFT_PER_LONG, BYTES_PER_LONG with dynamic
     variables. This will allow drivers in the future to control how much
     data to read/write from the framebuffer.

Give it a try. I did remove the DEBUG code. We need a cleaner way to test
those functions independent of the driver.

> I tested these changes on an Au1100 based board, using the patches to its 
> framebuffer code that were posted here by Christian Pellegrin[1]. I had this 
> code working both on a 16BPP color LCD and a 4BPP monochrome one.
> 
> Uli
> 
> [1] http://www.linux-mips.org/archives/linux-mips/2005-01/msg00095.html
> What happened to those, btw? They at least Work For Me(tm).

Cool. I will look it over and give a run. I need to make a few changes to 
properly support the fbdev api.
 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
