From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 5/5] s1d13xxxfb: Add support for Epson S1D13806 FB
Date: Mon, 14 Mar 2005 18:40:49 -0800
Message-ID: <20050314184049.2ed12443.akpm@osdl.org>
References: <200503150706.27357.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DB1zg-0002Ut-AU
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 18:41:16 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DB1ze-0005rI-Np
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 18:41:16 -0800
In-Reply-To: <200503150706.27357.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: adaplas@hotpop.com, linux-fbdev-devel@lists.sourceforge.net, varenet@esiee.fr

"Antonino A. Daplas" <adaplas@hotpop.com> wrote:
>
>   Attached to that mail is a patch adding support for Epson S1D13806
>    framebuffer device.
> 
>    That driver is intended to be easily used with other S1D13xxx devices,
>    hopefully by splitting the header file and changing a few defines. Since
>    I haven't got the hardware to test that, though, I can only assert that
>    it works with S1D13806.
> 
>    This driver has been succesfully tested on ARM embedded boards and
>    reported working on SH architecture as well.
> 
>    Since this is my first framebuffer driver, I would welcome any
>    suggestion/comment about it :)
> 
>    This driver has been built on top of some preliminary ARM specific work
>    by Ben Dooks, and adapted from existing code (as stated in the header of
>    s1d13xxxfb.c).
> 
>  Signed-off-by: Thibaut VARENE <varenet@parisc-linux.org>
>  Signed-off-by: Antonino Daplas <adaplas@pol.net>

I've been going around editing From: lines recently, in cases where it's
obvious.  I did so with this patch - please let me know if that is
inappropariate.


So the patch will hit bk as:

From: Thibaut VARENE <varenet@parisc-linux.org>
Signed-off-by: Thibaut VARENE <varenet@parisc-linux.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>


So

a) Thibaut will be identified in the bk logs as the author

b) His name will appear in the short-form changelogs, etc.

c) The Signed-off-by: line will note that Tony and I also handled this
   patch, and possibly made small changes to it.

I do this so that contributors get suitable credit, and so that bug
reporters have a better chance of finding who to email on the first
attempt.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
