From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Tue, 11 Mar 2003 22:03:18 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E6E4F16.1080307@winischhofer.net>
References: <Pine.LNX.4.44.0303111607080.23668-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18] helo=home.winischhofer.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18sqv5-0002IH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 13:04:19 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

James Simmons wrote:
>>However, the brokenness is really on the driver side.  They are unable
>>to change the video mode unless they are supplied with the correct
>>timing parameters where in fact they actually have the best knowledge on
>>how to calculate them.  
>>
>>So the question:  Do we let fbcon spoonfeed the timings to fbdev, or do
>>we let the drivers calculate it for themselves?  I go for the latter, as
>>fbcon really should not have any business with hardware.
> 
> 
> I agree. 

Me Too(tm). SiSfb (sorry for mentioning this one over and over, but 
that's the only one I am working on) does that now, according to the 
following assumptions:

If old_x == new_x && old_y == new_y && old_clock == new_clock

	-> assume a change in depth, hence recalculate the clock
	based on the htotal and vtotal values (which are calculated
	using var's horizontal and vertical timing.

else if (old_x != new_x || old_y != new_y) && old_clock == new_clock

	-> assume a mode change originating from fbcon_resize (where
	only xres and yres are changed, everything else left unchanged; 	 
hence, use the default clock (user selectable) because clock is
	invalid.

else if(timings are valid)

	-> use these timings, they originate from an application
	using the framebuffer device properly (directFB, for instance)

else -> use default clock

Works perfectly. Tested all possible applications (mplayer, sdl stuff, 
etc), no problems.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net          *** http://www.winischhofer.net



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
