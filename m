From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: [PATCH] sisfb accel capabilities
Date: Thu, 03 Jun 2004 11:52:45 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40BEF4ED.7090909@winischhofer.net>
References: <20040603024412.GE20951@havoc.gtf.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVovF-0005Me-Sf
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Jun 2004 02:54:05 -0700
Received: from [213.229.38.66] (helo=mail.falke.at)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BVovF-0003YR-7C
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Jun 2004 02:54:05 -0700
In-Reply-To: <20040603024412.GE20951@havoc.gtf.org>
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
To: David Eger <eger@havoc.gtf.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


David,

David Eger wrote:
> Dear Thomas,
> 
> The following patch updates sisfb for the new fb accel capabilities
> patch I'm sending upstream.  By default, this patch will rely on your
> copyarea() and fillrect() accel functions instead of the panning.

Could you give me any hint why this should be faster than panning?

Frankly, I don't think that's a good idea... panning is by far the 
fastest of all scrollmodes, especially when the virtual screen is much 
larger than the visible area. sisfb (unless told not to do so) maximizes 
the virtual y resolution to the available video memory, so by default 
that's eg. about 1024x16000 with 32MB of video ram (which is usual these 
days). The console is fast as hell here...

Perhaps you should make the decision whether to use either 
fillrect/copyarea or panning by the size of the virtual framebuffer? I 
understand panning is not as fast if the virtual screen is only little 
bigger than the visible area, but as soon as it has a certain size that 
makes copying the entire screen to the start of the framebuffer a seldom 
event, it's much faster.

Hm. On second thought, even if the virtual screen is only little larger 
than the visible screen, using panning will reduce the times where a 
copy of the entire screen is required. With SCROLL_ACCEL, you need a 
copy/move over the entire screen on every scrolling event; each 
additional line of text that fits into the virtual screen means calling 
copy/move one time less.

What am I missing here?

BTW:

1) fillrect and copyarea WERE (resp. ARE) being called here despite your 
previous statement that they were not. Fillrect is used to clear every 
line after pressing enter, and copyrect was used to copy the buffer to 
the start of the virtual screen when the end was reached.)

2) I still don't understand the meaning of FBINFO_HWACCEL_XPAN 
(especially as your sisfb patch sets it although sisfb did not support 
x-panning until yesterday evening...)


> Please test the core patch + this patch, and let me know your console
> works.  I'm interested to hear what speeds you see :-)

I will, but it will take some while. I need to merge your changes into 
my development version (which has been modified quite a bit). 
Furthermore I need to make sure it still compiles and works under 2.4. 
(You may have missed this fact but the driver is unified for both 2.4 
and 2.6. No time to maintain two separate versions.)

(BTW: The "get rid of reference to setup variable" and "YWARP" stuff was 
already removed there... So your patch boils down to a very few lines in 
sis_main.c only.)


> Also, using fbset to turn acceleration on and off ought to work, though
> i still think this is better done via sysfs... just don't have time to
> learn that ATM...

This depends on that STUPID_ACCELF_TEXT_SHIT, right? Nice name... ;) 
Note that not only fbset needs this, but DirectFB as well.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net	       *** http://www.winischhofer.net
twini AT xfree86 DOT org


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
