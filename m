From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Status of radeonfb in 2.5?
Date: 19 Oct 2002 05:40:19 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1034977216.615.27.camel@daplas>
References: <3DACA222.5030409@netscape.net>
	<20021016223613.17897@192.168.4.1>  <3DADD22F.9030508@netscape.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 182exc-0003D5-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Oct 2002 14:47:12 -0700
In-Reply-To: <3DADD22F.9030508@netscape.net>
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
To: Nicholas Wourms <nwourms@netscape.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2002-10-17 at 04:55, Nicholas Wourms wrote:

> B) Does anyone have a painless, yet precise way of 
> generating modelines for fb.modes if you are using 
> XFree-4.2?  I only ask because the XFree modelines are all 
> determined by i2c DDC probing, thus there are none in the 
> XF86Config file.  The modeline output captured in the log 
> XFree.0.log is not the same output which modeline2fb 
> expects.  Anyhow, I've tried using some of the information 
> in the log, but I always get funky results.  I may be 
> looking in the wrong place, but the documentation for both 
> the fbdev kernel drivers and the X drivers are sorely out of 
> date, so please excuse me if this is a question that has 
> previously been answered.  I just need some formulae to 
> convert values between what shows up in XFree.0.log when i2c 
> DDC probes for the modelines and what needs to go in 
> fb.modes.  Thanks in advance!
> 

Not necessarily painless...

Given timings in X modeline format (you can generate with xvidtune):

"XRESxYRES"     MHZ   XACTIVE FP_X HSYNC BP_X    YACTIVE  FP_Y  VSYNC 
BP_Y +hsync +vsync

Then timings in fb.mode:

mode "XRESxYRES MHZ"
    # D: "MHZ, H: HorizSync kHz, V: VertRefresh Hz
    geometry xres yres vxres vyres bpp
    timings pixclock left right upper lower hsync vsync
    hsync high
    vsync high
endmode

where:

pixclock = 1000000/MHZ
left = BP_X - HSYNC
right = FP_X - XACTIVE
upper = BP_Y - VSYNC
lower = FP_Y - YACTIVE
hsync = HSYNC - FP_X
vsync = VSYNC - FP_Y

What you need to concentrate on is the timings field of fb.modes. This
also assumes that the driver actually reads the timings field.  Some
drivers disregard those values (considers only xres and yres) then
configure their own timings.

Tony



-------------------------------------------------------
This sf.net email is sponsored by:
Access Your PC Securely with GoToMyPC. Try Free Now
https://www.gotomypc.com/s/OSND/DD
