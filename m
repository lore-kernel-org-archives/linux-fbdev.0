From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: Detect switching to X?
Date: Mon, 28 Nov 2005 09:12:35 +0100
Message-ID: <438ABBF3.20104@t-online.de>
References: <43894E39.9080902@t-online.de> <438A3568.50100@gmail.com> <438A9BA8.3070600@t-online.de> <438AB24C.60405@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ege84-0007uJ-U2
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Nov 2005 00:12:52 -0800
Received: from mailout03.sul.t-online.com ([194.25.134.81])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ege81-0000tH-LZ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Nov 2005 00:12:52 -0800
In-Reply-To: <438AB24C.60405@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Tony,

>The patch is not really palatable.  It is a patch that attempts to fix
>bugs in X, not fbcon.  Unless the problem is really widespread, then maybe
>I'll go for it for mainline.
>
>  
>

>You need not do that (do a periodic check).  A set_par() will always be
>called by fbcon whenever the console transitions from KD_GRAPHICS to
>KD_TEXT.  So all you need to do is possibly check some register that says
>the hardware is in legacy mode.
>  
>

The problem is _not_ the transition KD_GRAPHICS to KD_TEXT, that is handled
perfectly well. The problem is that after switching from KD_TEXT to 
KD_GRAPHICS
the trident X driver is unable to set the correct screen start address 
because cyblafb
disabled the bits of several registers the trident driver uses for that 
purpose.

If I would submit a patch to the X team to enhance the trident driver, 
that would only
solve the problem for those that use that new driver. I would have to 
wait several years
until I could be reasonably sure not to break the system of too many people.

Even without that problem it would be nice to inform the framebuffer 
drivers about
an ongoing switch to/from KD_GRAPHICS. Now there often is garbage displayed
for some fractions of  a second while switching to X, that could be 
prevented if the
framebuffer drivers would have the chance to e.g. clear the whole 
framebuffer memory
before the X driver starts to switch video mode  etc.

Today framebuffer drivers are limited by the fact that they need to 
leave the graphics
engine in a state that current and older (but still used) X drivers can 
handle. That
unreasonable limitation should be removed, and it can be removed by 
those optional
fb_save_state() and fb_restore_state() hooks.

cu,
 Knut


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
