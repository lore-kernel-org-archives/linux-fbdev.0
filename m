From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: Re: New radeonfb, mostly untested
Date: Wed, 10 Sep 2003 20:41:23 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030910184123.GA3500@dreamland.darkstar.lan>
References: <1062952639.655.6.camel@gaston> <20030907230334.GA847@dreamland.darkstar.lan> <1063000866.659.9.camel@gaston> <20030908190527.GA1731@dreamland.darkstar.lan> <20030910164101.GA437@dreamland.darkstar.lan> <1063212505.642.77.camel@gaston> <20030910174654.GA422@dreamland.darkstar.lan> <1063216209.1356.80.camel@gaston>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19x9v7-0002BZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 11:42:25 -0700
Received: from mail-5.tiscali.it ([195.130.225.151])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19x9v6-0001Hy-9c
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Sep 2003 11:42:24 -0700
Content-Disposition: inline
In-Reply-To: <1063216209.1356.80.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Il Wed, Sep 10, 2003 at 07:50:10PM +0200, Benjamin Herrenschmidt ha scritto: 
> On Wed, 2003-09-10 at 19:46, Kronos wrote:
> > Il Wed, Sep 10, 2003 at 06:48:26PM +0200, Benjamin Herrenschmidt ha scritto: 
> > > > This is very  annoying because I must re-center the  screen every time I
> > > > switch from  console to X and  viceversa. I had the same  issue with the
> > > > old driver + i2c code.
> > > > 
> > > > That doesn't happen with the standard modedb. At 1024x768 with
> > > > ignore_edid it's ok. At 1280x1024 it falls back to 800x600.
> > > 
> > > Can you try tweaking the hSync and vSync polarity ?
> > 
> > Tried,  I doesn't  change. I'm  looking  at radeonfb_set_par. What  does
> > hSyncPol and vSyncPol do? They seem  useless, they aren't used anywhere.
> > I  changed h_sync_pol  and v_sync_pol  (first  one, then  the other  and
> > finally both).
> 
> The ones from the panel infos ? we should use them indeed rather than
> the ones in the mode...

My LCD is using the VGA port, panel_info isn't used.

> Anyway, if your EDID returns incorrect infos, then we are screwed, or
> maybe we aren't calculating the horizontal margin properly when building
> the mode.
> 
> How does XFree works for you ? 

XFree is ok, Windows idem.

> You can try comparing what XFree programs in registers with what we
> do.

I'm doing this right now.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Una donna sposa un uomo sperando che cambi, e lui non cambiera`. Un
uomo sposa una donna sperando che non cambi, e lei cambiera`.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
