From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb: Revert "Fix radeon DDC
	regression"
Date: Sat, 07 Jun 2008 09:21:51 +1000
Message-ID: <1212794511.12464.38.camel@pasglop>
References: <20080606112116.3aa37dfd@hyperion.delvare>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4lG5-0004Br-4i for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 16:22:09 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1/yoDKFXEn7ZHifI3Gu8V6s6v1NCouTmY0=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K4lG2-00070e-M5
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 16:22:08 -0700
In-Reply-To: <20080606112116.3aa37dfd@hyperion.delvare>
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
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, 2008-06-06 at 11:21 +0200, Jean Delvare wrote:
> The bug was in fb_ddc and was fixed by commit
> b64d70825abbf706bbe80be1b11b09514b71f45e (fb_ddc: fix DDC lines quirk)
> so the workaround in radeonfb can be removed now.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---

I need to verify that on my Apple monitor which would switch off
if that is wrong. Will try to do that this week-end. Without news
from me next week, then just commit the bloody thing :-)

Cheers,
Ben.


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
