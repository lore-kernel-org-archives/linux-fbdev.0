From: Richard Smith <rsmith@bitworks.com>
Subject: Re: Generic VESA framebuffer driver and Video
 card BOOT?
Date: Mon, 18 Oct 2004 20:39:23 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4174704B.9050601@bitworks.com>
References: <9e47339104101814166bf4cfe5@mail.gmail.com> <41740384.5783.12A07B14@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJiyj-0001so-FB
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 18:39:57 -0700
Received: from [69.4.201.55] (helo=bitworks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CJiyd-0007Q5-N8
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 18:39:57 -0700
In-Reply-To: <41740384.5783.12A07B14@localhost>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: KendallB@scitechsoft.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Kendall Bennett wrote:

> Actually there is nothing wrong with the x86 BIOS from the perspective of 
> functionality and useability (or bloat for that matter). It contains all 
> the functionality we need and armed with something like the x86 emulator 
> we can use it for what we need on any platform.

> IMHO that is the best solution to the problem because it will be using 
> code that has been heavily tested by the vendor. The one thing x86 Video 
> BIOS'es can do reliably is POST the graphics card ;-)

I'm just going to take your word on this since you have messed with far 
more video bioses than I.  I've just got a few too many scars over the 
years from trying to make the whole BIOS sub-system robust enough for 
embedded standards.

> That would be nice if you could trim it down ;-) Would certainly save a 

Check out linux-tiny (http://www.selenic.com/tiny-about/)

> lot of code bloat. But if you do that, then you would need this code in 
> the kernel since now it would be the boot loader as well ;-)

Exactly. Which is why I like your project and I think its a good thing. 
    The only reason I have to carry around the legacy BIOS baggage is 
for video.

How big is your in-kernel implementation?

-- 
Richard A. Smith




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
