From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: pxafb and am200epd question
Date: Tue, 6 May 2008 08:05:30 -0400
Message-ID: <45a44e480805060505r2b280717p60d0046e083adf98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JtLvK-00061R-In for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 May 2008 05:05:34 -0700
Received: from wr-out-0506.google.com ([64.233.184.231])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JtLvI-0008Pk-63
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 May 2008 05:05:34 -0700
Received: by wr-out-0506.google.com with SMTP id c48so66910wra.1
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 06 May 2008 05:05:31 -0700 (PDT)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: eric.miao@marvell.com
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Hi Eric,

I just noticed commit ce4fb7b892a6d6c6a0f87366b26fd834d2923dd7 which
splits out the pxa LCD defines from pxa-regs.h into a separate
regs-lcd.h. Unfortunately,  drivers/video/am200epd.c had a dependency
on the LCD definitions from pxa-regs.h so its build is temporarily
broken. I will do a quick patch to make am200epd use regs-lcd.h and
also switch to the __raw_read/write just like pxafb. That'll fix
things in the short term.

I think I am at fault here because maybe I shouldn't be directly
touching the pxa LCDC regs. I think I should explain some of the
background so that we can figure out a solution. Okay, so here are the
details:

* metronomefb is the arch independent code that handles talking to an
E-Ink controller called Metronome. It uses a vmalloc-ed framebuffer
that is memory mappable by userspace apps (using fb_defio) which is
then backed by a physically contiguous dma-able framebuffer which also
has to store other non-framebuffer things like a waveform used by the
E-Ink controller.
* am200epd is the "platform device", ie: board specific code (runs on
a gumstix pxa255 board) that provides the functions called by
metronomefb that sets up board specific gpio, LCD controller setup,
interrupt from gpio and other board related things. This is the driver
that is the source of the problem. It touches stuff from the pxa's
LCDC in order to set the LCDC to use the metronomefb framebuffer and
also set up a custom modeline.

Temporarily am200epd will need to depend on regs-lcd.h because I
haven't figured out all the different panels that E-Ink have and how
to handle resolution setup for them. Longer term, maybe am200epd can
share some code with pxafb to setup various parameters on its behalf.
So basically am200epd could call a pxa-lcdc type function to say
"please setup the LCDC with the following desired mode parameters and
give me a physically contiguous framebuffer of this size".

The other alternative is to just leave things as they are and have
am200epd keep some private LCDC setup. I guess its not much code,
maybe 20-50 lines of LCDC register init and we would then need to
share regs-lcd.h.

Let me know what you think.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
