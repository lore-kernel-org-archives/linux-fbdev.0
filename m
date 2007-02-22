From: Luca Tettamanti <kronos@people.it>
Subject: Re: [PATCH] nvidiafb: allow ignoring EDID info
Date: Thu, 22 Feb 2007 21:39:04 +0100
Message-ID: <20070222203904.GA15349@dreamland.darkstar.lan>
References: <21d7e9970701281612q56b694edp6efd1a5556dea3fe@mail.gmail.com>
	<20070128162907.370f5476.akpm@osdl.org>
	<21d7e9970701281639w57edc2efw4ba620d4c1bdcee7@mail.gmail.com>
	<cb7bb73a0701290637q2ce0ff16t28f82d0c0339a2ba@mail.gmail.com>
	<20070130203301.GA15067@dreamland.darkstar.lan>
	<20070204201713.GA12867@dreamland.darkstar.lan>
	<Pine.LNX.4.64.0702062034380.9224@pentafluge.infradead.org>
	<cb7bb73a0702061508x767882dcia1b13f85d898b6e7@mail.gmail.com>
	<1172101406.4217.16.camel@daplas>
	<cb7bb73a0702220001u6acbdd95ncdc9fad10d06b421@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKKiZ-0003pB-G9 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 12:39:11 -0800
Received: from joe.tiscali.it ([213.205.33.54])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HKKiX-0007mm-KQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 12:39:07 -0800
Content-Disposition: inline
In-Reply-To: <cb7bb73a0702220001u6acbdd95ncdc9fad10d06b421@mail.gmail.com>
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
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>, linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>, Dave Airlie <airlied@gmail.com>

Il Thu, Feb 22, 2007 at 09:01:52AM +0100, Giuseppe Bilotta ha scritto: 
> On 2/22/07, Antonino A. Daplas <adaplas@gmail.com> wrote:
> >On Wed, 2007-02-07 at 00:08 +0100, Giuseppe Bilotta wrote:
> >>
> >> As mentioned in another post in this thread, I can't get any info out
> >> of the i2c busses, because even when I have them available (i.e. after
> >> loading nvidiafb) I get XXXX all around (on all three of them).
> >> Suggestions on how to get the information welcome.
> >
> >Is this the same monitor you posted here?
> >
> >http://marc.theaimsgroup.com/?l=linux-kernel&m=112807065616218&w=2
> >
> >If yes, we already have the manufacturer and model code. The main
> >problem is that the EDID of this display has no sync range (H: 75-75kHz
> >and V: 60-60Hz).  Extending Hsync from 30-75kHz as a fix to the EDID
> >block shouldn't be too hard.
> 
> Yes, that's it! Jeepers, I can't believe that even re-reading the past
> LKML posts (even those!) I couldn't find the EDID info and how we had
> gotten them. I guess I need stronger glasses.
> 
> Wonder why Luca's proposed patch makes the EDID undetectable, now, and
> why can't it be retrieved at a later time via i2c. Timeouts too small?

Still scratching my head :|

Tony,
this is the patch (modulo cosmetic stuff) that I sent to Giuseppe. I
believe it's correct (I cross checked with X.org driver):

diff --git a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
index b858897..7e64341 100644
--- a/drivers/video/nvidia/nv_i2c.c
+++ b/drivers/video/nvidia/nv_i2c.c
@@ -70,8 +70,6 @@ static int nvidia_gpio_getscl(void *data)
 	if (VGA_RD08(par->PCIO, 0x3d5) & 0x04)
 		val = 1;
 
-	val = VGA_RD08(par->PCIO, 0x3d5);
-
 	return val;
 }
 

Luca
-- 
Non sempre quello che viene dopo e` progresso.
Alessandro Manzoni

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
