From: Andrey Volkov <avolkov@varma-el.com>
Subject: Re: Re: Where is place of arch independed companion
 chips?
Date: Wed, 03 Aug 2005 13:09:10 +0400
Message-ID: <42F089B6.8000304@varma-el.com>
References: <42EB6A12.70100@varma-el.com> <42EE15AF.5050902@hp.com>	 <20050801181357.GA31144@suse.de> <1123019379.7782.86.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E0FFf-00054b-Hf
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Aug 2005 02:09:27 -0700
Received: from [195.144.244.147] (helo=amanaus.varma-el.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E0FFd-0001fo-T0
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Aug 2005 02:09:27 -0700
In-Reply-To: <1123019379.7782.86.camel@localhost.localdomain>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Greg KH <gregkh@suse.de>, Jamey Hicks <jamey.hicks@hp.com>, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, tony.luck@intel.com, edwardsg@sgi.com

Richard Purdie wrote:
> On Mon, 2005-08-01 at 11:13 -0700, Greg KH wrote:
> 
>>>Good question.  I was about to submit a patch that created 
>>>drivers/platform because the toplevel driver for MQ11xx is a 
>>>platform_device driver.  Any thoughts on this?
>>
>>drivers/platform sounds good to me.
> 
> 
> In another thread (about the ucb1x00) we came up with the idea of
> drivers/mfd (mfd = multi function devices).
> 
> The core and platform specific parts would live here with suitable clear
> naming and the subsection specific parts that were separable would live
> in the appropriate place within the kernel.
> 
> Just another idea to add to the mix and removes the dilemma of a
> multifunction device with isn't platform based...
> 
drivers/mfd as drivers/mfd, I have not objections. Who will send the
patch first?

--
Regards
Andrey Volkov

P.S. Tony, Greg, may be it will someone from you? (I've in mind sn/ subdir)







-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
