From: Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: gxfb: Replace FBSIZE config option with a
	kernel argument
Date: Wed, 27 Feb 2008 18:12:07 -0700
Message-ID: <20080228011207.GB2942@cosmic.amd.com>
References: <20080223011045.48e6cb8e@ephemeral>
	<20080227163105.e1b96023.akpm@linux-foundation.org>
	<20080227195839.1e86074e@ephemeral>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JUXCu-0003Vh-En for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Feb 2008 17:05:09 -0800
Received: from outbound-va3.frontbridge.com ([216.32.180.16]
	helo=outbound5-va3-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JUXCs-0006I3-9H
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Feb 2008 17:05:08 -0800
Content-Disposition: inline
In-Reply-To: <20080227195839.1e86074e@ephemeral>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-kernel@vger.kernel.org, info-linux@geode.amd.com, Andrew Morton <akpm@linux-foundation.org>, dwmw2@infradead.org

> > And "fbsize=N" would be a lot more conventional than "fbsize:N"
> > 
> 
> I can certainly change that.  Regarding convention, I toyed with renaming
> it 'vram' (as most of the fb drivers use that), and will probably do
> that unless Jordan objects.

vram is fine.

Jordan

-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
