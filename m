From: Richard Smith <rsmith@bitworks.com>
Subject: Re: Generic VESA framebuffer driver and Video
 card BOOT?
Date: Mon, 18 Oct 2004 17:34:45 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <41744505.4080507@bitworks.com>
References: <200410160946.32644.adaplas@hotpop.com>	 <4173B865.26539.117B09BD@localhost> <417428F2.2050402@bitworks.com> <9e47339104101814166bf4cfe5@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJg5b-0002oW-M5
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 15:34:51 -0700
Received: from [69.4.201.55] (helo=bitworks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CJg5b-0002rk-4W
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 15:34:51 -0700
In-Reply-To: <9e47339104101814166bf4cfe5@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

Jon Smirl wrote:

> Every system has to be able to somehow indicate that it can find/load the
> kernel image or that the image is corrupt or that hardware diagnostics failed.
> Displaying this info is the responsibility of the BIOS.
> 

Jon, I agree with you 100%.  I was merely responding to a statement I 
saw as false.

If we could get the video chip manufacturers to provide me with all the 
necessary documentation we embedded folk would be happy to do exactly as 
you say.  We could code up a nice robust boot time init procedure to 
serve our purposes.  OF would be great if all the mfgs would support it.

Its a sad fact though that we are (x86 anyway) dependant on some 
amazingly fragile, stupid, usually binary only, legacy bloated, and 
quite often buggy, 16-bit realmode video init code that should have been 
put to pasture many years ago.

LinuxBIOS has been trying to come up with a solution to the video BOOT 
problems for good while now.  Emulation seems to be the only thing that 
really has a chance of working.

I don't currently (see next paragraph) need the kernel to try and do all 
that stuff for me since I need it prior to when the kernel loads.  But 
what I would like is to be able to use/build on kernel framework without 
having to completely re-invent the wheel.

A long term goal of LinuxBIOS however is to use Linux _AS_ the bios 
which kind of nullifies your BIOS responsibility statement.  Some of the 
LANL clusters are doing this right now.  The only reason we aren't doing 
it 100% of the time is that a lot of motherboards don't have a big 
enough flash. Yet.  But with projects like linux-tiny and larger flashes 
headed our way those days are numbered.

Linux far exceeds the hardware support level and flexablity of any bios 
and already does 90% of the job a bios does anyway. In most cases better 
than the bios ever could.  Linux booting Linux is the ultimate 
bios/bootloader.

-- 
Richard A. Smith




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
