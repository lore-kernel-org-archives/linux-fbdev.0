From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH/RFC 2.6.20-rc4 1/1] fbdev,
	mm: hecuba/E-Ink fbdev driver
Date: Sat, 17 Feb 2007 10:47:54 +0100
Message-ID: <45a44e480702170147x73d1e5c8v6439ac412b952a7@mail.gmail.com>
References: <20070111142427.GA1668@localhost>
	<20070111133759.d17730a4.akpm@osdl.org>
	<45a44e480701111622i32fffddcn3b4270d539620743@mail.gmail.com>
	<45A6DAA2.8070605@yahoo.com.au>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HIMAi-00078a-J8 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 17 Feb 2007 01:48:04 -0800
Received: from nf-out-0910.google.com ([64.233.182.184])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HIMAh-0001vL-8M
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 17 Feb 2007 01:48:00 -0800
Received: by nf-out-0910.google.com with SMTP id c31so3461976nfb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 17 Feb 2007 01:47:55 -0800 (PST)
In-Reply-To: <45A6DAA2.8070605@yahoo.com.au>
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
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On 1/12/07, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Jaya Kumar wrote:
> > - write so get page_mkwrite where we add this page to a list
> > - also schedules a workqueue task to be run after a delay
> > - app continues writing to that page with no additional cost
> > - the workqueue task comes in and unmaps the pages on the list, then
> >  completes the work associated with updating the framebuffer
>
> Have you thought about implementing a traditional write-back cache using
> the dirty bits, rather than unmapping the page?
>

Ah, sorry, I erred in my description. I'm not unmapping pages, I'm
calling page_mkclean which uses the dirty bits.

Thanks,
jaya

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
