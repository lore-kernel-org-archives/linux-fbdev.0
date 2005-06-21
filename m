From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: PATCH: move soft_cursor into fbconsole
Date: Tue, 21 Jun 2005 01:07:30 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0506210103540.18685@pentafluge.infradead.org>
References: <9e47339105061021571f479b10@mail.gmail.com> 
 <Pine.LNX.4.62.0506120942100.11197@numbat.sonytel.be> 
 <9e47339105061518346d1df105@mail.gmail.com>  <200506161111.27115.adaplas@hotpop.com>
 <9e4733910506152037193300fa@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkWJ7-000391-Rp
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 20 Jun 2005 17:08:01 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DkWIg-0000qr-Jb
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 20 Jun 2005 17:08:01 -0700
In-Reply-To: <9e4733910506152037193300fa@mail.gmail.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@gmail.com>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@pentafluge.infradead.org>


> On 6/15/05, Antonino A. Daplas <adaplas@hotpop.com> wrote:
> > On Thursday 16 June 2005 09:34, Jon Smirl wrote:
> > > Are there still issues with this patch?
> > 
> > Maybe.  A few drivers will set the fb_cursor field to either
> > soft_cursor or the driver-specific cursor function, depending
> > on the kernel boot options or setting of the var.accel flag.
> 
> I think there were three driver implementing hardware cursors. 
> I tried to keep them working, they only needed minor touchups.
> 
> If they had fallbacks to the software cursor I removed those and
> returned an error instead. Instead fbconsole will get the error and
> switch to software cursor. If HW cursors are going to work from user
> space they can't contain SW cursor fallbacks.
> 
> The patch should move softcursor.c into the fbconsole subdirectory but
> I can't figure out how to do that with git yet.
> 
> > 
> > The changes required are probably minor.
> > 
> > Tony

I agree we should not fall back to the software cursor when the hardware 
cursor fails. Do we really want to eliminate the cursor from the device 
interface if it is not a hardware cursor? Shouldn't the cursor always 
work? That is the question.
 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
