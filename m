From: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: Status of radeonfb in 2.5?
Date: Fri, 18 Oct 2002 18:16:26 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <aoq14h$qqg$1@main.gmane.org>
References: <3DACA222.5030409@netscape.net> <20021016223613.17897@192.168.4.1> <3DADD22F.9030508@netscape.net> <1034977216.615.27.camel@daplas>
Reply-To: nwourms@netscape.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7Bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from main.gmane.org ([80.91.224.249])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 182fP8-0003i1-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Oct 2002 15:15:38 -0700
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 182fOE-00079G-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Oct 2002 00:14:42 +0200
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
To: linux-fbdev-devel@lists.sourceforge.net

Antonino Daplas wrote:

> Not necessarily painless...
> 
> Given timings in X modeline format (you can generate with xvidtune):
> 
> "XRESxYRES"     MHZ   XACTIVE FP_X HSYNC BP_X    YACTIVE  FP_Y  VSYNC
> BP_Y +hsync +vsync
> 
> Then timings in fb.mode:
> 
> mode "XRESxYRES MHZ"
>     # D: "MHZ, H: HorizSync kHz, V: VertRefresh Hz
>     geometry xres yres vxres vyres bpp
>     timings pixclock left right upper lower hsync vsync
>     hsync high
>     vsync high
> endmode
> 
> where:
> 
> pixclock = 1000000/MHZ
> left = BP_X - HSYNC
> right = FP_X - XACTIVE
> upper = BP_Y - VSYNC
> lower = FP_Y - YACTIVE
> hsync = HSYNC - FP_X
> vsync = VSYNC - FP_Y
> 
> What you need to concentrate on is the timings field of fb.modes. This
> also assumes that the driver actually reads the timings field.  Some
> drivers disregard those values (considers only xres and yres) then
> configure their own timings.
> 
Tony,

Thank you, this is *exactly* what I was looking for!  I never knew what 
xvidtune was really for, but this sure answers that one.

Cheers,
Nicholas




-------------------------------------------------------
This sf.net email is sponsored by:
Access Your PC Securely with GoToMyPC. Try Free Now
https://www.gotomypc.com/s/OSND/DD
