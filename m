From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH/RFC 2.6.20-rc4 1/1] fbdev,
	mm: hecuba/E-Ink fbdev driver
Date: Thu, 11 Jan 2007 23:25:22 -0800
Message-ID: <20070111232522.491e57fb.akpm@osdl.org>
References: <20070111142427.GA1668@localhost>
	<20070111133759.d17730a4.akpm@osdl.org>
	<45a44e480701111622i32fffddcn3b4270d539620743@mail.gmail.com>
	<1168586145.26496.35.camel@twins>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H5Gn6-000489-AH for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 11 Jan 2007 23:25:32 -0800
Received: from smtp.osdl.org ([65.172.181.24])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1H5Gn5-0003Lt-1h
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 11 Jan 2007 23:25:32 -0800
In-Reply-To: <1168586145.26496.35.camel@twins>
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
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-fbdev-devel@lists.sourceforge.net, Jaya Kumar <jayakumar.lkml@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org

On Fri, 12 Jan 2007 08:15:45 +0100
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> How about implementing the sync_page() aop?

That got deleted in Jens's tree - the unplugging rework.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
