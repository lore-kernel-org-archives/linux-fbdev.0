From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] video: SuperH Mobile LCDC Driver V2
Date: Fri, 30 May 2008 12:06:06 -0700
Message-ID: <20080530120606.9ff1b384.akpm@linux-foundation.org>
References: <20080530110239.21680.46731.sendpatchset@rx1.opensource.se>
	<20080530182803.5d599d21.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K29vf-0001UE-SL for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 12:06:20 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K29vf-00031R-AH
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 12:06:19 -0700
In-Reply-To: <20080530182803.5d599d21.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: linux-fbdev-devel@lists.sourceforge.net, iwamatsu@nigauri.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org

On Fri, 30 May 2008 18:28:03 +0200 Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> On Fri, 30 May 2008 20:02:39 +0900
> Magnus Damm <magnus.damm@gmail.com> wrote:
> 
> > This is the SuperH Mobile LCDC frame buffer driver V2, adding
> > support for the LCDC block found in SuperH Mobile processors. The
> > hardware supports up to two LCD panels per LCDC block, and both RGB
> > and SYS interfaces can be used to hook up LCD panels/modules.
> > 
> > The device driver is a regular platform driver, so LCD configuration
> > and board specific hooks are passed to the driver using platform data.
> > LCD modules using SYS interface often require special configuration
> > using the SYS bus, and to solve this cleanly the driver provides SYS
> > interface operations to the board code.
> > 
> > Tested on sh7723 and sh7722 processors with a SYS16A QVGA panel and
> > WVGA panels using RGB16 and RGB18 interfaces.
> > 
> > Signed-off-by: Magnus Damm <damm@igel.co.jp>
> > ---
> 
> Acked-by: Krzysztof Helt<krzysztof.h1@wp.pl>
> 
> Does anybody know which tag is better for a reviewed patch:
> "Acked-by" or "Reviewed-by" ?
> 

I consider Reviewed-by: to be much stronger that Acked-by:

You wouldn't believe some of the crap which has had cheerful Acked-by:s :(

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
