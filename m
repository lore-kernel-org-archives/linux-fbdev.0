From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: atyfb: Early video resume for PowerMacs
Date: Thu, 20 Dec 2007 15:56:43 +1100
Message-ID: <1198126603.31714.10.camel@pasglop>
References: <1198123176.31714.8.camel@pasglop>
Reply-To: benh@kernel.crashing.org,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J5DSt-00059S-83 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 19 Dec 2007 20:56:59 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX19HQ7ncIFWikYNZiKugBooKO71D9Ju6v7k=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J5DSr-0002YO-RP
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 19 Dec 2007 20:56:59 -0800
In-Reply-To: <1198123176.31714.8.camel@pasglop>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


On Thu, 2007-12-20 at 14:59 +1100, Benjamin Herrenschmidt wrote:
> This adds support for early resuming of the video driver on some
> powermacs that support it. Makes video come back earlier and thus
> debugging of suspend/resume problems easier.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Forget it for now, there's something weird happening on a powerbook
here, I'll track that down and resend.

Cheers,
Ben.



-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
