From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] two warning fixes
Date: Wed, 18 Jul 2007 22:32:09 -0400
Message-ID: <469ECD29.2010909@garzik.org>
References: <20070718235504.GA9601@havoc.gtf.org>
	<alpine.LFD.0.999.0707181834070.27353@woody.linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IBLoT-0000wE-Js for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 19:32:23 -0700
Received: from srv5.dvmed.net ([207.36.208.214] helo=mail.dvmed.net)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IBLoS-0002Mx-9p
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 19:32:21 -0700
In-Reply-To: <alpine.LFD.0.999.0707181834070.27353@woody.linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, benh@kernel.crashing.org, LKML <linux-kernel@vger.kernel.org>, ak@suse.de, Andrew Morton <akpm@linux-foundation.org>

Linus Torvalds wrote:
> So let's make a new rule:
> 
>   We absolutely NEVER add things like "must_check" unless not checking 
>   causes a real and obvious SECURITY ISSUE.
> 
>   And we absolutely *never* add crap like "deprecated", where the only 
>   point of the warning is to effectively hide *real* problems.
> 
> So realistically, the only thing that needs must_check is pretty much 
> things like "get_user()" and quite frankly, I'm not sure even about that 
> one.
> 
> Ok?


Sounds great to me...  My overall goal is killing useless warnings that 
continually obscure real ones.

	Jeff



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
