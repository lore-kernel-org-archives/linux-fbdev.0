From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 08:54:47 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200404280854.47596.adaplas@hotpop.com>
References: <Pine.LNX.4.44.0404280019070.23153-100000@phoenix.infradead.org> <408EF0D9.6000403@undead.cc> <20040428002919.GG22495@guug.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIdLa-0001ID-HV
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 17:54:46 -0700
Received: from snickers.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BIdLZ-00038c-2k
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 17:54:45 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by snickers.hotpop.com (Postfix) with SMTP id F0EDF722D9
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 Apr 2004 00:09:18 +0000 (UTC)
In-Reply-To: <20040428002919.GG22495@guug.org>
Content-Disposition: inline
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
To: Otto Solares <solca@guug.org>, John Zielinski <grim@undead.cc>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wednesday 28 April 2004 08:29, Otto Solares wrote:
> On Tue, Apr 27, 2004 at 07:46:33PM -0400, John Zielinski wrote:
> > An added bonus is that if you have multiple video cards or a dual head
> > configuration with each head on a different fbx device the 5,255 device
> > would figure out which console you are on when you start the program and
> > use the appropriate fb device.  Once the radeon dual head code gets
> > written I'll have to try to start X on fb0 (head 1) and leave the fbcon
> > running on fb1 (head two).
>
> I was wondering if it is possible currently (kernel 2.6.5) to
> have 2 differents video cards in 2 differents VCs and in 2
> differents fbdev's.  I have an old trident pci card and one
> radeon agp card.  I want to run X (Xfbdev) in the trident one
> and mesa-solo in the radeon one, is that possible? how?
>

Yes, I've tried that in 2.5.x, assuming nothing broke in between.  You need a 
utility to map which console to which fbdev (con2fbmap?).  However, you can't 
use them simultaneously (switching to one console inactivates the other), 
that's for the ruby project.

Tony





-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
