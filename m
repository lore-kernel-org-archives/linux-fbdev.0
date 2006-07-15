From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Subject: Re: please disconsider bl_mutex patch
Date: Sat, 15 Jul 2006 11:22:42 -0300
Message-ID: <20060715142242.GA4969@cathedrallabs.org>
References: <20060704015311.GJ27596@cathedrallabs.org>
	<44B8E204.30807@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G1l2g-0000tS-Il for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Jul 2006 07:22:50 -0700
Received: from tinc.cathedrallabs.org ([72.9.252.66])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G1l2e-0003KP-L2
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Jul 2006 07:22:50 -0700
Content-Disposition: inline
In-Reply-To: <44B8E204.30807@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>, linux-fbdev-devel@lists.sourceforge.net

> > 	just noticed that the bl_mutex removal from nvidiafb_blank() is
> > 	wrong. while at that, noticed that recursive bl_mutex retrieval
> > 	is also present at least on aty128fb and riva. checking how to
> > 	fix it properly now.
> > 
> 
> What's the status of this patch?
Michael Hanselmann is working in an improved version. How's the status
on this Michael?

-- 
Aristeu


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
