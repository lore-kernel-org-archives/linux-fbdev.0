From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: mode setting and console locking
Date: Mon, 17 May 2004 08:03:40 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1084745020.6445.18.camel@gaston>
References: <20040516155757.26612.qmail@web14927.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPToB-0002sd-7q
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 May 2004 15:08:35 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BPToA-0006vz-Qi
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 May 2004 15:08:34 -0700
In-Reply-To: <20040516155757.26612.qmail@web14927.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2004-05-17 at 01:57, Jon Smirl wrote:
> I have two video cards installed. I run X on the primary and fbdev on the
> secondary.  I'm having a problem setting the mode to the fbdev device from an
> xterm window. This was working six months ago in 2.6 but it is broken currently.
> 
> If I load fbdev on my primary card, then run X on it, fbset will work on the
> primary card fron the xterm window.
> 
> if I load fbdev on my secondary card (it is reset and fbdev loads without
> problem) then fbset from an xterm window will lock my box. fbset from a console
> window works fine. I have tried this both ways, swapping the primary and
> secondary cards, so it doesn't seem to be the card drivers.
> 
> Is there some locking going on in fbdev mode setting that is interacting with X?
> My X server does not have the fbdev driver loaded. The only thing I can think of
> is that the console is marked at being in KD_GRAPHICs. Any ideas?

No, there is currently no locking. There is locking between printk (fbcon)
and mode setting but not with userland clients. 

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
