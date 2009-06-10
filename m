From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PATCH - Add accelerated bitblt functions to
	s1d13xxxfb
Date: Tue, 9 Jun 2009 17:58:07 -0700
Message-ID: <20090609175807.65db0ebb.akpm@linux-foundation.org>
References: <20090606141037.7debdb08.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1MEC9M-0002U4-3N
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 10 Jun 2009 00:58:44 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MEC9I-0004TN-5H
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 10 Jun 2009 00:58:43 +0000
In-Reply-To: <20090606141037.7debdb08.kristoffer.ericson@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Sat, 6 Jun 2009 14:10:37 +0200
Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:

> This patch adds accelerated bitblt functions to s1d13xxx based 
> video chipsets, more specificly functions copyarea and fillrect. 
> It has only been tested and activated for 13506 chipsets
> but is expected to work for the majority of s1d13xxx based chips.
> This patch also cleans up the driver with respect of whitespaces
> and other formatting issues. We update the current status
> comments.
> 

Was I sent half a patch?


drivers/video/s1d13xxxfb.c: In function 'bltbit_fifo_status':
drivers/video/s1d13xxxfb.c:470: error: 'BBLT_FIFO_EMPTY' undeclared (first use in this function)
drivers/video/s1d13xxxfb.c:470: error: (Each undeclared identifier is reported only once
drivers/video/s1d13xxxfb.c:470: error: for each function it appears in.)
drivers/video/s1d13xxxfb.c:474: error: 'BBLT_FIFO_FULL' undeclared (first use in this function)
drivers/video/s1d13xxxfb.c:478: error: 'BBLT_FIFO_NOT_FULL' undeclared (first use in this function)
drivers/video/s1d13xxxfb.c: In function 's1d13xxxfb_bitblt_solidfill':
drivers/video/s1d13xxxfb.c:640: error: 'BBLT_SOLID_FILL' undeclared (first use in this function)

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
