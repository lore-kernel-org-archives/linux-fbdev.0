From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: New radeonfb, mostly untested
Date: Wed, 10 Sep 2003 19:50:10 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1063216209.1356.80.camel@gaston>
References: <1062952639.655.6.camel@gaston>
	 <20030907230334.GA847@dreamland.darkstar.lan>
	 <1063000866.659.9.camel@gaston>
	 <20030908190527.GA1731@dreamland.darkstar.lan>
	 <20030910164101.GA437@dreamland.darkstar.lan>
	 <1063212505.642.77.camel@gaston>
	 <20030910174654.GA422@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19x96r-0003BY-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 10:50:29 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19x96q-0007pW-GP
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Sep 2003 10:50:28 -0700
In-Reply-To: <20030910174654.GA422@dreamland.darkstar.lan>
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
To: Kronos <kronos@kronoz.cjb.net>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-09-10 at 19:46, Kronos wrote:
> Il Wed, Sep 10, 2003 at 06:48:26PM +0200, Benjamin Herrenschmidt ha scritto: 
> > > This is very  annoying because I must re-center the  screen every time I
> > > switch from  console to X and  viceversa. I had the same  issue with the
> > > old driver + i2c code.
> > > 
> > > That doesn't happen with the standard modedb. At 1024x768 with
> > > ignore_edid it's ok. At 1280x1024 it falls back to 800x600.
> > 
> > Can you try tweaking the hSync and vSync polarity ?
> 
> Tried,  I doesn't  change. I'm  looking  at radeonfb_set_par. What  does
> hSyncPol and vSyncPol do? They seem  useless, they aren't used anywhere.
> I  changed h_sync_pol  and v_sync_pol  (first  one, then  the other  and
> finally both).

The ones from the panel infos ? we should use them indeed rather than
the ones in the mode...

Anyway, if your EDID returns incorrect infos, then we are screwed, or
maybe we aren't calculating the horizontal margin properly when building
the mode.

How does XFree works for you ? You can try comparing what XFree programs
in registers with what we do.

Ben.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
