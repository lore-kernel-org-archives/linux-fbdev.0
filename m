From: Richard Smith <rsmith@bitworks.com>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video
 card BOOT?
Date: Mon, 18 Oct 2004 16:04:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <41742FF2.9090409@bitworks.com>
References: <4173B865.26539.117B09BD@localhost> <4173C981.13925.11BDE111@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267378AbUJRVHS@vger.kernel.org>
In-Reply-To: <4173C981.13925.11BDE111@localhost>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: KendallB@scitechsoft.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Kendall Bennett wrote:

> Richard Smith <rsmith@bitworks.com> wrote:
> 
> Good, so my assumption was incorrect which I am happy about. Since it 
> makes the work we did more useful ;-)
> 
> Anyway in your case do you need diagnostic messages just from the kernel 
> or from the firmware as well?

Firmware messages are the most critical since none of the app code is 
running yet and can't self-heal or cry for help.

Some units boot off of a compact flash.  Try as we might to make these 
babies robust they do fail.  So in that case the boot message from the 
firmware needs to be displayed.  In other cases the system net boots 
which increases the firmware error message level by about a factor of 10.

 > To get it in the firmware the video boot
 > code would need to be ported there (U-Boot has a version of it already,
 > but it is the only firmware I am aware of that supports this).

LinuxBIOS has some suport for this.  Not by emulation though.  It uses 
the bios from the BOCHS project as a payload.  Some glue drops the 
system back into real mode and runs the BOCHS bios which scans the 
legacy regions for ROM expansion modules.  So as long as I copy my video 
bios up int 0x0C0000 prior to this I get video.  Otherwise I have to 
wait until X comes up and soft-boots the display device.

-- 
Richard A. Smith
