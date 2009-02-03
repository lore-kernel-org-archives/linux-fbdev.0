From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] cirrusfb: convert printks to dev_foo
Date: Tue, 3 Feb 2009 13:50:18 -0800
Message-ID: <20090203135018.03d5d59e.akpm@linux-foundation.org>
References: <20090202195659.67b12917.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1LUTUK-0005pG-CI
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Feb 2009 22:11:24 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LUTUH-0000X8-1e
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Feb 2009 22:11:24 +0000
In-Reply-To: <20090202195659.67b12917.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net

Thanks.


On Mon, 2 Feb 2009 19:56:59 +0100
Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> Author: Krzysztof Helt <krzysztof.h1@wp.pl>

This isn't needed - it's a git thing.  For email we use From: lines.

> Convert all printks to dev_dbg, dev_info
> or dev_err. Kill some excessive debug
> information and code in the process.

I added your Signed-off-by: to this.

> diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
> index 30684fb..21302d1 100644
> --- a/drivers/video/cirrusfb.c
> +++ b/drivers/video/cirrusfb.c

I got a couple of rejects against current mainline, easily fixed.

------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
