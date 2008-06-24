From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [patch 2/5] SM501: Restructure init
	to	allow only 1 fb on an SM501
Date: Tue, 24 Jun 2008 12:54:39 +0100
Message-ID: <20080624115439.GA22222@fluff.org.uk>
References: <20080622210439.018928412@fluff.org.uk>
	<20080622210614.414283871@fluff.org.uk>
	<20080623235402.0ab2e49c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KB77F-00062l-BL for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Jun 2008 04:55:17 -0700
Received: from aeryn.fluff.org.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KB77B-0000MQ-VA
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 24 Jun 2008 04:55:17 -0700
Content-Disposition: inline
In-Reply-To: <20080623235402.0ab2e49c.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk, Ben Dooks <ben-linux@fluff.org>

On Mon, Jun 23, 2008 at 11:54:02PM -0700, Andrew Morton wrote:
> On Sun, 22 Jun 2008 22:04:41 +0100 Ben Dooks <ben-linux@fluff.org> wrote:

[snip]
 
> Local variable `end' doesn't have an appropriate type.
> 
> It could be that overflows here are not possible due to hardware and
> architecture limitations, but still, it's best to get these things
> right.

I've rewritten this to remove the need to go back and look at the
resource and also add some small cleanups/fixups. Will post once
I've had a chance to actually runtime test.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
