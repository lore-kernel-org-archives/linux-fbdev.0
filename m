From: Otto Solares <solca@guug.org>
Subject: Re: [PATCH] neofb patches
Date: Tue, 27 Apr 2004 18:29:19 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040428002919.GG22495@guug.org>
References: <Pine.LNX.4.44.0404280019070.23153-100000@phoenix.infradead.org> <408EF0D9.6000403@undead.cc>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIcxE-0003yz-9Z
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 17:29:36 -0700
Received: from guug.org ([168.234.203.30])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BIcxD-00073K-Tx
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 17:29:36 -0700
Content-Disposition: inline
In-Reply-To: <408EF0D9.6000403@undead.cc>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Zielinski <grim@undead.cc>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, Apr 27, 2004 at 07:46:33PM -0400, John Zielinski wrote:
> An added bonus is that if you have multiple video cards or a dual head 
> configuration with each head on a different fbx device the 5,255 device 
> would figure out which console you are on when you start the program and 
> use the appropriate fb device.  Once the radeon dual head code gets 
> written I'll have to try to start X on fb0 (head 1) and leave the fbcon 
> running on fb1 (head two).

I was wondering if it is possible currently (kernel 2.6.5) to
have 2 differents video cards in 2 differents VCs and in 2
differents fbdev's.  I have an old trident pci card and one
radeon agp card.  I want to run X (Xfbdev) in the trident one
and mesa-solo in the radeon one, is that possible? how?

-otto



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
