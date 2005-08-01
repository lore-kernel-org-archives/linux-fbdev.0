From: Greg KH <gregkh@suse.de>
Subject: Re: Where is place of arch independed companion chips?
Date: Mon, 1 Aug 2005 11:13:57 -0700
Message-ID: <20050801181357.GA31144@suse.de>
References: <42EB6A12.70100@varma-el.com> <42EE15AF.5050902@hp.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dzenq-0005Yh-SO
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 Aug 2005 11:14:18 -0700
Received: from lyle.provo.novell.com ([137.65.81.174])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Dzenq-0004ui-Gn
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 Aug 2005 11:14:18 -0700
Content-Disposition: inline
In-Reply-To: <42EE15AF.5050902@hp.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jamey Hicks <jamey.hicks@hp.com>
Cc: Andrey Volkov <avolkov@varma-el.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 08:29:35AM -0400, Jamey Hicks wrote:
> Andrey Volkov wrote:
> 
> >Hi Greg,
> >
> >While I write driver for SM501 CC (which have graphics controller, USB
> >MASTER/SLAVE, AC97, UART, SPI  and VIDEO CAPTURE onboard),
> >I bumped with next ambiguity:
> >Where is a place of this chip's Kconfig/drivers in
> >kernel config/drivers tree? May be create new node in drivers subtree?
> >Or put it under graphics node (since it's main function of this CC)?
> >
> >AFAIK, this is not one such multifunctional monster in the world, so
> >somebody bumped with this problem again in future.
> >
> > 
> >
> Good question.  I was about to submit a patch that created 
> drivers/platform because the toplevel driver for MQ11xx is a 
> platform_device driver.  Any thoughts on this?

drivers/platform sounds good to me.

thanks,

greg k-h


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
