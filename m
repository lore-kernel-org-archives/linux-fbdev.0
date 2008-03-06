From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tridentfb: resource management
 fixes in probe function
Date: Wed, 5 Mar 2008 22:29:39 -0800
Message-ID: <20080305222939.87fc7e34.akpm@linux-foundation.org>
References: <20071031220524.54ed8dae.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JX9by-0007J7-KW for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 05 Mar 2008 22:29:50 -0800
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JX9bx-0000X8-A8
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 05 Mar 2008 22:29:50 -0800
In-Reply-To: <20071031220524.54ed8dae.krzysztof.h1@poczta.fm>
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

On Wed, 31 Oct 2007 22:05:24 +0100 Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> The most important fix  is to disable the mmio mode on error. Otherwise,
> the console is left in unusable state (garbled fonts at least, lock up at worst).
> 
> Other changes balance release and request of memory regions
> in case of error and few minor style errors.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> ---
> The patch was done against the 2.6.24-rc1 kernel.

Could you please redo and resend these tridentfb patches if they are still
needed?

Thanks.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
