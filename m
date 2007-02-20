From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 2.6.20 1/1] fbdev,
	mm: hecuba/E-Ink fbdev driver
Date: Tue, 20 Feb 2007 01:11:19 -0500
Message-ID: <45a44e480702192211i78b8f4b1lecb3dfc284fb9eea@mail.gmail.com>
References: <20070217104215.GB25512@localhost> <1171715652.5186.7.camel@lappy>
	<45a44e480702170525n9a15fafpb370cb93f1c1fcba@mail.gmail.com>
	<20070217135922.GA15373@linux-sh.org>
	<45a44e480702180331t7e76c396j1a9861f689d4186b@mail.gmail.com>
	<20070218235741.GA22298@linux-sh.org>
	<45a44e480702192013s7d49d05ai31e576f0448a485e@mail.gmail.com>
	<20070220043848.GA4092@linux-sh.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HJODh-0004mf-N9 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Feb 2007 22:11:23 -0800
Received: from nf-out-0910.google.com ([64.233.182.184])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HJODh-0003oX-9O
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Feb 2007 22:11:21 -0800
Received: by nf-out-0910.google.com with SMTP id c31so4903778nfb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 19 Feb 2007 22:11:19 -0800 (PST)
In-Reply-To: <20070220043848.GA4092@linux-sh.org>
Content-Disposition: inline
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
To: Paul Mundt <lethal@linux-sh.org>, Jaya Kumar <jayakumar.lkml@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org, jsimmons@infradead.org, Geert.Uytterhoeven@sonycom.com

On 2/19/07, Paul Mundt <lethal@linux-sh.org> wrote:
> On Mon, Feb 19, 2007 at 11:13:04PM -0500, Jaya Kumar wrote:
> >
> > Ok. Here's what I'm thinking for abstracting this:
> >
> > fbdev drivers would setup fb_mmap with their own_mmap as usual. In
> > own_mmap, they would do what they normally do and setup a vm_ops. They
> > are free to have their own nopage handler but would set the
> > page_mkwrite handler to be fbdev_deferred_io_mkwrite().
>
> The vast majority of drivers do not implement ->fb_mmap(), and with
> proper abstraction, this should be something that's possible as a direct
> alternative to drivers/video/fbmem.c:fb_mmap() for the people that want
> it. Of course it's just as easy to do something like the sbuslib.c route
> and then have drivers set their ->fb_mmap() from that too.
>

I was thinking about having that fb_mmap replacement too. But then I
got worried because that generic implementation of nopage/etc would
need to handle whether the driver's fb memory was vmalloced, kmalloced
or a mixture if some do that. So I figured let's aim low and just pull
in the core part that does the setup and page tracking stuff. I hope
that's okay.

> That works for me, though I'd prefer for struct page_list to be done with
> a scatterlist, then it's trivial to setup from the workqueue context
> without having to shuffle things around.
>

Ok. Will check out when implementing.

Thanks,
jaya

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
