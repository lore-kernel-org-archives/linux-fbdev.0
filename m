From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [PATCH 7/7] fbdev: Generic drawing function
 cleanups
Date: Thu, 17 Feb 2005 22:02:12 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502172200400.10099@pentafluge.infradead.org>
References: <200502172045.40790.adaplas@hotpop.com> <200502172129.18249.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1tj2-00010w-HQ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 14:02:20 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D1tj0-00029C-1g
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 14:02:20 -0800
In-Reply-To: <200502172129.18249.adaplas@hotpop.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, Ulrich Eckhardt <eckhardt@satorlaser.com>


Tony did you get my patch with the changes I had merged with the below 
patch?

> On Thursday 17 February 2005 20:45, Antonino A. Daplas wrote:
> 
> Sorry, wrong patch.
> 
> Tony
> 
>   From Ulrich Eckhardt:
> 
>    * removed trailing whitespace
>    * use helper function for common bitwise operations
>    * fixed several cases where either the wrong mask was used for bitops
>      or the mask was computed falsely, messing up <32 BPP support
>    * added self-tests for bitcpy_rev() algorithm in module-init function
>    * no need to use explicitly sized integers in some cases
>    * added a few comments where things weren't obvious to me
> 
>   I tested these changes on an Au1100 based board, using the patches to its
>   framebuffer code that were posted here by Christian Pellegrin[1]. I had this
>   code working both on a 16BPP color LCD and a 4BPP monochrome one.
> 
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> ---
> 
>  cfbcopyarea.c |  348 ++++++++++++++++++++++++++++++++++++----------------------
>  cfbfillrect.c |  279 +++++++++++++++++++++++-----------------------
>  2 files changed, 356 insertions(+), 271 deletions(-)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
