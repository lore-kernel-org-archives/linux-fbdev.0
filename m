From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Linux 2.6.12-rc2
Date: Thu, 26 May 2005 15:14:58 +1000
Message-ID: <1117084498.9076.57.camel@gaston>
References: <Pine.LNX.4.58.0504040945100.32180@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org>
	 <E1DJE6t-0001T5-UD@localhost.localdomain>
	 <20050525215637.252cbaba.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbAih-0005es-4V
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 22:15:47 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DbAif-0005AU-Bv
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 22:15:46 -0700
In-Reply-To: <20050525215637.252cbaba.akpm@osdl.org>
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Moritz Muehlenhoff <jmm@inutil.org>, linux-fbdev-devel@lists.sourceforge.net

On Wed, 2005-05-25 at 21:56 -0700, Andrew Morton wrote:
> Moritz Muehlenhoff <jmm@inutil.org> wrote:
> >
> > Linus Torvalds wrote:
> > > Benjamin Herrenschmidt:
> > >   o radeonfb: Implement proper workarounds for PLL accesses
> > >   o radeonfb: DDC i2c fix
> > >   o radeonfb: Fix mode setting on CRT monitors
> > >   o radeonfb: Preserve TMDS setting
> > 
> > One of these patches introduced two regressions on my Thinkpad X31 with
> > "ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])":
> > 
> > 1. When resuming from S3 suspend and having switched off the backlight
> > with radeontool the backlight isn't switched back on any more.
> > 
> > 2. I'm using fbcon as my primary work environment, but tty switching has
> > become _very_ sloppy, it's at least a second now, while with 2.6.11 it
> > was as fast as a few ms. Is this caused by the "proper PLL accesses"?
> > 
> 
> Moritz, can you tell us whether either of these problems remain in 2.6.12-rc5?

The later will not be fixed. It's a side effect of some workarounds ATI
had me put in for the M6 which has a theorical hardware bug... unless we
decide the bug never happens and comment out the fix =P

The former, I'm not sure. x86 BIOSes are doing all sort of funny things,
I'm not sure what's going on specifically in this case. Also, the
backlight control code has known issues that I haven't find a way to fix
completely for everybody yet, it seems that different "races" of panels
need different solutions here, and by fixing one sort, I break another.
I'm still trying to get ATI to give me more infos about that, but
without luck so far.

However, why would you need to switch the backlight off with radeontool
when going to S3 ? You should let the firmware do it, or radeonfb do it,
but not manually. What if you just leave it "alone", what happens when
you go to/from S3 ? And if stays off, can you bring it back with
radeontool ?

Ben.




-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
