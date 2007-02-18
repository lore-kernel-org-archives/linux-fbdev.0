From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 2.6.20 1/1] fbdev,
	mm: hecuba/E-Ink fbdev driver
Date: Sun, 18 Feb 2007 06:31:23 -0500
Message-ID: <45a44e480702180331t7e76c396j1a9861f689d4186b@mail.gmail.com>
References: <20070217104215.GB25512@localhost> <1171715652.5186.7.camel@lappy>
	<45a44e480702170525n9a15fafpb370cb93f1c1fcba@mail.gmail.com>
	<20070217135922.GA15373@linux-sh.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HIkGN-00039i-Uz for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Feb 2007 03:31:28 -0800
Received: from nf-out-0910.google.com ([64.233.182.186])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HIkGN-0007Kp-FI
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Feb 2007 03:31:27 -0800
Received: by nf-out-0910.google.com with SMTP id c31so3971205nfb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 18 Feb 2007 03:31:24 -0800 (PST)
In-Reply-To: <20070217135922.GA15373@linux-sh.org>
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
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-mm@kvack.org, linux-fbdev-devel@lists.sourceforge.net, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org

On 2/17/07, Paul Mundt <lethal@linux-sh.org> wrote:
> On Sat, Feb 17, 2007 at 08:25:07AM -0500, Jaya Kumar wrote:
> > On 2/17/07, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> > >And, as Andrew suggested last time around, could you perhaps push this
> > >fancy new idea into the FB layer so that more drivers can make us of it?
> >
> > I would like to do that very much. I have some ideas how it could work
> > for devices that support clean partial updates by tracking touched
> > pages. But I wonder if it is too early to try to abstract this out.
> > James, Geert, what do you think?
> >
> This would also provide an interesting hook for setting up chained DMA
> for the real framebuffer updates when there's more than a couple of pages
> that have been touched, which would also be nice to have. There's more
> than a few drivers that could take advantage of that.
>

Hi Paul,

I could benefit from knowing which driver and display device you are
considering to be applicable.

I was thinking the method used in hecubafb would only be useful to
devices with very slow update paths, where "losing" some of the
display activity is not an issue since the device would not have been
able to update fast enough to show that activity anyway.

What you described with chained DMA sounds different to this. I
suppose one could use this technique to coalesce framebuffer IO to get
better performance/utilization even for fast display devices. Sounds
interesting to try. Did I understand you correctly?

Thanks,
jaya

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
