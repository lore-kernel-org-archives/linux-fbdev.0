From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 2.6.20 1/1] fbdev,
	mm: hecuba/E-Ink	fbdev driver
Date: Thu, 22 Feb 2007 07:43:33 +0800
Message-ID: <1172101413.4217.18.camel@daplas>
References: <20070217104215.GB25512@localhost> <1171715652.5186.7.camel@lappy>
	<45a44e480702170525n9a15fafpb370cb93f1c1fcba@mail.gmail.com>
	<20070217135922.GA15373@linux-sh.org>
	<45a44e480702180331t7e76c396j1a9861f689d4186b@mail.gmail.com>
	<20070218235741.GA22298@linux-sh.org>
	<45a44e480702192013s7d49d05ai31e576f0448a485e@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK14u-0002fx-Td for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 15:40:52 -0800
Received: from nz-out-0506.google.com ([64.233.162.225])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HK14u-0002rP-KS
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 15:40:52 -0800
Received: by nz-out-0506.google.com with SMTP id i11so4195668nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 21 Feb 2007 15:40:52 -0800 (PST)
In-Reply-To: <45a44e480702192013s7d49d05ai31e576f0448a485e@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: jsimmons@infradead.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Paul Mundt <lethal@linux-sh.org>, Geert.Uytterhoeven@sonycom.com, Jaya Kumar <jayakumar.lkml@gmail.com>

On Mon, 2007-02-19 at 23:13 -0500, Jaya Kumar wrote: 
> On 2/18/07, Paul Mundt <lethal@linux-sh.org> wrote:
> > Given that, this would have to be something that's dealt with at the
> > subsystem level rather than in individual drivers, hence the desire to
> > see something like this more generically visible.
> >
> 
> Hi Peter, Paul, fbdev folk,
> 
> Ok. Here's what I'm thinking for abstracting this:
> 
> fbdev drivers would setup fb_mmap with their own_mmap as usual. In
> own_mmap, they would do what they normally do and setup a vm_ops. They
> are free to have their own nopage handler but would set the
> page_mkwrite handler to be fbdev_deferred_io_mkwrite().
> fbdev_deferred_io_mkwrite would build up the list of touched pages and
> pass it to a delayed workqueue which would then mkclean on each page

Yes, this functionality is sorely needed by more than a few driver
writers.

> and then pass a copy of that page list down to a driver's callback
> function. The fbdev driver's callback function can then do the actual
> IO to the framebuffer or coalesce DMA based on the provided page list.
> I would like to add something like the following to struct fb_info:
> 
> #ifdef CONFIG_FB_DEFERRED_IO
> struct fb_deferred_io *defio;
> #endif
> 
> to store the mutex (to protect the page list), the touched page list,
> and the driver's callback function.
> 
> I hope this sounds sufficiently generic to meet everyone's (the two of
> us? :) needs.

There's definitely more than two :-).  For the past several years,
various people have been asking for this functionality.  So yes,
implementing this in a generic manner will be a big help.

Tony


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
