From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC] pxafb: introduce "struct
 pxafb_output" to abstract the output interface
Date: Tue, 15 Apr 2008 17:22:46 -0700
Message-ID: <20080415172246.292760a5.akpm@linux-foundation.org>
References: <f17812d70804080259n7e69fc54n7a18bca77c88b8bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JlvRC-000633-Ac for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 15 Apr 2008 17:23:46 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JlvRA-0000D7-Li
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 15 Apr 2008 17:23:46 -0700
In-Reply-To: <f17812d70804080259n7e69fc54n7a18bca77c88b8bb@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: eric miao <eric.y.miao@gmail.com>
Cc: linux@arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk, daniel@caiaq.de

> Subject: [PATCH RFC] pxafb: introduce "struct pxafb_output" to abstract the output interface

I'm not really sure who we can request comments from on this one.

The code looks OK to me from a quick scan - but you're largely on your own on
this one.

On Tue, 8 Apr 2008 17:59:14 +0800
"eric miao" <eric.y.miao@gmail.com> wrote:

> Currently two output interfaces are supported:
> 
>     ppi - parallel port interface
>     spi - smart panel interface
> 
> and possibly MIPI or video output in the future.

I get a monster reject when applying this on the current patchset.  Perhaps
because there are also changes to drivers/video/pxafb.c in git-arm.patch.

It would be best please if you could redo the patch against
http://userweb.kernel.org/~akpm/mmotm/.  I've also uploaded a single rolled
up patch against 2.6.25-rc9 at http://userweb.kernel.org/~akpm/em.gz.

Please try to lessen the wordwrapping in the next version, thanks ;)

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
