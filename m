From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH/RFC 2.6.20 1/2] fbdev,
	mm: Deferred IO support
Date: Fri, 2 Mar 2007 11:00:08 +0900
Message-ID: <20070302020008.GA6822@linux-sh.org>
References: <20070225051312.17454.80741.sendpatchset@localhost>
	<20070301140131.GA6603@linux-sh.org>
	<45a44e480703011602j698f67dev469b49d6b527f502@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMx6g-00012D-KV for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 18:02:50 -0800
Received: from smtp.ocgnet.org ([64.20.243.3])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HMx6f-0003cd-9m
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 18:02:50 -0800
Content-Disposition: inline
In-Reply-To: <45a44e480703011602j698f67dev469b49d6b527f502@mail.gmail.com>
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
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Thu, Mar 01, 2007 at 07:02:34PM -0500, Jaya Kumar wrote:
> On 3/1/07, Paul Mundt <lethal@linux-sh.org> wrote:
> >Any updates on this? If there are no other concerns, it would be nice to
> >at least get this in to -mm for testing if nothing else.
> 
> I think Andrew merged it into -mm.
> 
Ok, I didn't see it go in, sorry for the noise in that case.

> >Jaya, can you roll the fsync() patch in to your defio patch? There's not
> >much point in keeping them separate.
> >
> 
> I forgot to add that. Sorry about that. Should I resubmit with it or
> would you prefer to post it?

I'll repost it separately.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
