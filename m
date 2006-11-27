From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: 2.6.19-rc5: Geode GX frame buffer takes 13
 seconds to initialize
Date: Mon, 27 Nov 2006 14:07:41 -0700
Message-ID: <20061127210741.GB5169@cosmic.amd.com>
References: <808c8e9d0611160829k28a8fdf9mafb9c7e27163cf4b@mail.gmail.com>
	<Pine.LNX.4.64.0611201633240.17639@pentafluge.infradead.org>
	<808c8e9d0611201447y6e053e89m9a5333af91a235aa@mail.gmail.com>
	<20061121003447.GD5160@cosmic.amd.com>
	<808c8e9d0611210618n2d54aaft1e2afb1c73dcf74a@mail.gmail.com>
	<808c8e9d0611270828m4ff91349mdc7bf03fd6875e91@mail.gmail.com>
	<Pine.LNX.4.64.0611271820450.16234@pentafluge.infradead.org>
	<20061127183930.GF588@cosmic.amd.com>
	<20061127115403.059e5f19.akpm@osdl.org>
	<20061127123502.4253210c.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GoncN-0002c8-Oc for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Nov 2006 13:02:23 -0800
Received: from outbound-blu.frontbridge.com ([65.55.251.16]
	helo=outbound2-blu-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GoncK-0001co-TJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Nov 2006 13:02:23 -0800
In-Reply-To: <20061127123502.4253210c.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 27/11/06 12:35 -0800, Andrew Morton wrote:
 
> It seems that there's duplication between Herbert's git-cryptodev tree
> and your git-geode tree.
> 
> What's the story here?

Does - I'm an idiot count as an explanation?  I committed the crime of
a duplicate commit (well, actually several crimes).

Go ahead and pull the tree from your list.  I've decided to rebuild the
tree from scratch without the newbie behavior.  I'll let you know when
its clean again.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
