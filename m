From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: Where is place of arch independed companion chips?
Date: Tue, 02 Aug 2005 22:49:39 +0100
Message-ID: <1123019379.7782.86.camel@localhost.localdomain>
References: <42EB6A12.70100@varma-el.com> <42EE15AF.5050902@hp.com>
	 <20050801181357.GA31144@suse.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E04eV-0004a5-JV
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Aug 2005 14:50:23 -0700
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E04dz-0005E4-Sn
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Aug 2005 14:50:23 -0700
In-Reply-To: <20050801181357.GA31144@suse.de>
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
To: Greg KH <gregkh@suse.de>
Cc: Jamey Hicks <jamey.hicks@hp.com>, Andrey Volkov <avolkov@varma-el.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 11:13 -0700, Greg KH wrote:
> > Good question.  I was about to submit a patch that created 
> > drivers/platform because the toplevel driver for MQ11xx is a 
> > platform_device driver.  Any thoughts on this?
> 
> drivers/platform sounds good to me.

In another thread (about the ucb1x00) we came up with the idea of
drivers/mfd (mfd = multi function devices).

The core and platform specific parts would live here with suitable clear
naming and the subsection specific parts that were separable would live
in the appropriate place within the kernel.

Just another idea to add to the mix and removes the dilemma of a
multifunction device with isn't platform based...

Richard



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
