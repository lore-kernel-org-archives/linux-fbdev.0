From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/4] gxfb: Don't enable the CRT DACs
 when we are in flatpanel mode
Date: Wed, 27 Feb 2008 16:24:50 -0800
Message-ID: <20080227162450.a30f6b07.akpm@linux-foundation.org>
References: <20080223011054.0c7529e7@ephemeral>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JUWaY-0007tG-TP for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Feb 2008 16:25:30 -0800
Received: from smtp1.linux-foundation.org ([207.189.120.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JUWaX-0003lT-JA
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Feb 2008 16:25:30 -0800
In-Reply-To: <20080223011054.0c7529e7@ephemeral>
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
To: Andres Salomon <dilinger@queued.net>
Cc: jordan.crouse@amd.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com, info-linux@geode.amd.com

On Sat, 23 Feb 2008 01:10:54 -0500
Andres Salomon <dilinger@queued.net> wrote:

> This one's also from Jordan.
> 
> >From dea8d19f689706985b30be745ef1151082866374 Mon Sep 17 00:00:00 2001
> From: Jordan Crouse <jordan.crouse@amd.com>
> Date: Fri, 22 Feb 2008 19:55:09 -0500
> Subject: [PATCH] gxfb: Don't enable the CRT DACs when we are in flatpanel mode

Please do this just by putting Jordan's From: line right at the start of the
changelog.

> When the FP strap is enabled, don't turn on the CRT DACs - that will save
> about 35 mA of power.
> 
> Updated/cleaned up by Andres Salomon.
> 
> Signed-off-by: Andres Salomon <dilinger@debian.org>
> Acked-by: Jordan Crouse <jordan.crouse@amd.com>

This should have been Signed-off-by: Jordan.  I made that change.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
