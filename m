From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Wed, 05 Mar 2003 15:16:36 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E6606C4.801@winischhofer.net>
References: <3E65EAFB.7020208@winischhofer.net> <1046870342.1291.86.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [213.229.38.66] (helo=mail.falke.at)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qZjy-0007NU-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 06:19:27 -0800
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Further to my mail from a few minutes ago:

I wrote:
 > But I noticed another issue here:
 >
 > When switching to gfx mode during boot (ie as soon as the penguin
 > appears), the text console is aligned correctly at all edges, with all
 > lines visible.

 > But when "initial console" starts, the mode is again changed, and now
 > the last line of text is nearly invisible, its upper half appears at
 > the lower screen edge, the lower half is below the screen's edge. The
 > space between the penguin and the text is notably thicker.
 >
 > This can be recovered by switching to another VT and back. This makes
 > the penguin disappear, and restores the console dimensions/edges to
 > normal.

 > Interestingly, this only happens with 800x600; this mode is chosen
 > upon requesting 800x592 (because of the font size). At 1024x768,
 > everything is as it should.

I am almost sure that this has to do with the fact that I adapt var in 
my check_var from 800x592 to 800x600. Console (or whoever) seems to 
attempt to change the mode to its initially desired dimension on many 
occasions.

- This leads to the (unncessary) second mode switch during boot (when 
the "initial console" starts), assumingly because the xres does not 
match fontsize * rows,

- and probably is the reason for that vertical offset I see after this 
mode switch: The text area on the screen is shifted down by exactly 8 
pixels - 600-592=8

Any hints?

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net            http://www.winischhofer.net/





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
