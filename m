From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fbdev broken in current bk for PPC
Date: Fri, 10 Sep 2004 16:00:02 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1094796002.14398.118.camel@gaston>
References: <1094783022.2667.106.camel@gaston>
	 <200409101328.57431.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5eTn-0004lk-Mf
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Sep 2004 23:01:52 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1C5eTK-00049M-JI
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Sep 2004 23:01:31 -0700
In-Reply-To: <200409101328.57431.adaplas@hotpop.com>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Fri, 2004-09-10 at 15:28, Antonino A. Daplas wrote:

> If fb_get_options returns an error, drivers will not proceed with their
> initialization. The second method is more compatible with the
> previous setup semantics.
> 
> I told Geert that if the changes did bite us, then I have no choice
> but to add support for the second method.
> 
> So, if you think that the first method is not enough, then I will add the
> second method. Let me know.

I submited a patch moving offb to the bottom of the Makefile to at
least restore normal drivers. For ofonly, a bit more hackish, but
what about failing register_framebuffer for anything but offb ?

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
