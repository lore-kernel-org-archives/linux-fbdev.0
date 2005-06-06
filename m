From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [RFC/PATCH 2.6.12-rc5 1/1] Framebuffer driver
 for Arc LCD board
Date: Mon, 6 Jun 2005 20:00:12 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0506061958450.16950@pentafluge.infradead.org>
References: <200506061416.j56EG18b017582@intworks.biz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfMpg-0002Ft-BT
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Jun 2005 12:00:20 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DfMpe-0005nH-Aj
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Jun 2005 12:00:19 -0700
In-Reply-To: <200506061416.j56EG18b017582@intworks.biz>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@pol.net, linux-kernel@vger.kernel.org, akpm@osdl.org


> Hi Antonino, Andrew, FBdev folk,
> 
> I added akpm's fixes below, then further cleanup and irq support: 
> - coding style fixes
> - removing unneeded typecasts
> - namespace fixes
> 
> I had used skeletonfb.c to start with and that had fb_get_options.
> I've removed that and the redundant param retrieval from arcfb as 
> per akpm's mention of the redundancy of fb_get_options/*_setup. 
> I also cleaned up some other duplicate code. I've listed the 
> driver as maintained and added myself. I did this diff against
> rc5. Should I be doing it against -mm instead?
> 
> Please let me know if you have any feedback or suggestions.

It looks really good :-) Please apply.



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
