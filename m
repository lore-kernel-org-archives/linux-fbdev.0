From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 2.6.20 1/1] fbdev,
	mm: hecuba/E-Ink fbdev driver
Date: Sat, 17 Feb 2007 22:59:22 +0900
Message-ID: <20070217135922.GA15373@linux-sh.org>
References: <20070217104215.GB25512@localhost> <1171715652.5186.7.camel@lappy>
	<45a44e480702170525n9a15fafpb370cb93f1c1fcba@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HIQ8A-0004bU-K2 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 17 Feb 2007 06:01:38 -0800
Received: from smtp.ocgnet.org ([64.20.243.3])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HIQ89-0001UQ-7r
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 17 Feb 2007 06:01:38 -0800
Content-Disposition: inline
In-Reply-To: <45a44e480702170525n9a15fafpb370cb93f1c1fcba@mail.gmail.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-mm@kvack.org, linux-fbdev-devel@lists.sourceforge.net, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org

On Sat, Feb 17, 2007 at 08:25:07AM -0500, Jaya Kumar wrote:
> On 2/17/07, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> >And, as Andrew suggested last time around, could you perhaps push this
> >fancy new idea into the FB layer so that more drivers can make us of it?
> 
> I would like to do that very much. I have some ideas how it could work
> for devices that support clean partial updates by tracking touched
> pages. But I wonder if it is too early to try to abstract this out.
> James, Geert, what do you think?
> 
This would also provide an interesting hook for setting up chained DMA
for the real framebuffer updates when there's more than a couple of pages
that have been touched, which would also be nice to have. There's more
than a few drivers that could take advantage of that.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
