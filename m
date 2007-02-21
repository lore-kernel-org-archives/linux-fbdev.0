From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 2.6.20 1/1] fbdev,
	mm: hecuba/E-Ink fbdev driver
Date: Wed, 21 Feb 2007 11:46:21 -0500
Message-ID: <45a44e480702210846u218045bmfe6854fb894d7bbd@mail.gmail.com>
References: <20070217104215.GB25512@localhost> <1171715652.5186.7.camel@lappy>
	<45a44e480702170525n9a15fafpb370cb93f1c1fcba@mail.gmail.com>
	<20070217135922.GA15373@linux-sh.org>
	<45a44e480702180331t7e76c396j1a9861f689d4186b@mail.gmail.com>
	<20070218235741.GA22298@linux-sh.org>
	<45a44e480702192013s7d49d05ai31e576f0448a485e@mail.gmail.com>
	<20070220043848.GA4092@linux-sh.org>
	<45a44e480702192211i78b8f4b1lecb3dfc284fb9eea@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HJubs-00007L-I0 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 08:46:29 -0800
Received: from ug-out-1314.google.com ([66.249.92.169])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HJubr-0003vN-Ao
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 08:46:28 -0800
Received: by ug-out-1314.google.com with SMTP id z38so1053673ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 21 Feb 2007 08:46:21 -0800 (PST)
In-Reply-To: <45a44e480702192211i78b8f4b1lecb3dfc284fb9eea@mail.gmail.com>
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

On 2/20/07, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> On 2/19/07, Paul Mundt <lethal@linux-sh.org> wrote:
> > That works for me, though I'd prefer for struct page_list to be done with
> > a scatterlist, then it's trivial to setup from the workqueue context
> > without having to shuffle things around.
> >
>
> Ok. Will check out when implementing.
>

Took  a quick look. If I used scatterlist, I'd still need to build a
list of scatterlist to pass to the driver callback. The alternative
being a preallocated array of scatterlist based on the page count of
the framebuffer, which seems expensive since scatterlist has page,
offset, dma and length.

On a separate note, Peter pointed out that it may be possible to reuse
page->lru instead of using a struct page_list. This would enable
something like:

in mkwrite:
mutex_lock
list_add(page->lru, defio->pagelist)
mutex_unlock

in deferred handler:
mutex_lock
for_each page {
lock_page
mkclean
unlock_page
}
callback(fb_info, pagelist)
for_each page {
list_del
}
mutex_unlock

The advantage of reusing page->lru is that avoids needing the struct
page_list and allocation in mkwrite. Is the above exploitation of
->lru ok with mm folk?

In above, we're iterating over the page list twice. I have to mkclean
before calling the callback to avoid the situation where a touched
page is missed by the callback. I don't see a way around that part.

Thanks,
jaya

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
