From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: [2.5.59] radeonfb not working
Date: Fri, 14 Feb 2003 23:33:33 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030214223333.GA745@dreamland.darkstar.lan>
References: <20030129152703.GA539@dreamland.darkstar.lan> <Pine.LNX.4.44.0302122003230.31435-100000@phoenix.infradead.org>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail-3.tiscali.it ([195.130.225.149] helo=mail.tiscali.it)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18joPl-0000iG-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Feb 2003 14:34:37 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302122003230.31435-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Il Wed, Feb 12, 2003 at 08:04:19PM +0000, James Simmons ha scritto: 
> > If   I  append   a  specific   video  mode   I'll  get   "out  of   scan
> > range"   or  "no   signal"  depending   on  the   video  mode. This   is
> > "video=radeon:640x480-16@85" (no signal):
> 
> Ug. The default mode in the modeb must be not supported by your card. Can 
> you try lowering the value for 85.

I tried 75, 70, 60 without success. Btw both monitor and video card can
handle 640x480@85Hz (the monitor can go up to 100Hz).

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
