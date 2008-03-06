From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/8] pxa: un-nest
 pxafb_parse_options() to cleanup the coding style issue
Date: Wed, 5 Mar 2008 23:13:08 -0800
Message-ID: <20080305231308.04965017.akpm@linux-foundation.org>
References: <f17812d70802261833v7d6dbff3jd9b436ee6dfda4a0@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JXAJ5-0004CG-68 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 05 Mar 2008 23:14:23 -0800
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JXAJ3-0000z2-O7
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 05 Mar 2008 23:14:23 -0800
In-Reply-To: <f17812d70802261833v7d6dbff3jd9b436ee6dfda4a0@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: eric miao <eric.y.miao@gmail.com>, linux-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

On Wed, 27 Feb 2008 10:33:10 +0800 "eric miao" <eric.y.miao@gmail.com> wrote:

> >From e946f577d3f869abcc587629e2fdd5f1563ce1df Mon Sep 17 00:00:00 2001
> From: eric miao <eric.miao@marvell.com>
> Date: Fri, 22 Feb 2008 11:29:08 +0800
> Subject: [PATCH] pxa: un-nest pxafb_parse_options() to cleanup the
> coding style issue
> 
> pxafb_parse_options() has very long lines exceeding far beyond 80
> characters, which makes the function looks bad.  Un-nest it into
> smaller functions and use a temporary string for only what has been
> overridden instead of the whole dev_info() message to reduce the
> line a bit more.
> 

These patches were all badly wordwrapped.  Please refresh them against the
latest mainline kernel, fix your email client and then resend them, being
sure to cc myself.

Thanks.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
