From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] x86_64 EFI boot support: EFI
 frame buffer driver
Date: Thu, 9 Aug 2007 10:40:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708091038060.12872@anakin>
References: <1186647633.15539.15.camel@caritas-dev.intel.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IJ3Yy-0000ER-GB for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 09 Aug 2007 01:40:12 -0700
Received: from agave.telenet-ops.be ([195.130.137.77])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IJ3Yv-0007iU-Tb
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 09 Aug 2007 01:40:12 -0700
In-Reply-To: <1186647633.15539.15.camel@caritas-dev.intel.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Chandramouli Narayanan <mouli@linux.intel.com>, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, "Antonino A. Daplas" <adaplas@pol.net>, akpm@linux-foundation.org

On Thu, 9 Aug 2007, Huang, Ying wrote:
> Changelog between this version and previous version (v3 of x86_64 EFI
> support patch).
> 
> 1. The include files of efifb.c is cleaned up.
> 2. Make CONFIG_FB_EFI do not depend on CONFIG_EFI.

BTW, the recommended place to put changelogs (so the tools will strip
it automatically when importing your patch) is after the first `---' and
before the diffstat output

> ---

Bogus `---' :-)

> This patch adds Graphics Output Protocol support to the kernel.
> UEFI2.0 spec deprecates Universal Graphics Adapter (UGA) protocol and
> only Graphics Output Protocol (GOP) is produced. Therefore, the boot
> loader needs to query the UEFI firmware with appropriate Output
> Protocol and pass the video information to the kernel. As a result of
> GOP protocol, an EFI framebuffer driver is needed for displaying
> console messages. The patch adds a EFI framebuffer driver. The EFI
> frame buffer driver in this patch is based on the Intel Mac
> framebuffer driver.
> 
> The ELILO bootloader takes care of passing the video information as
> appropriate for EFI firmware.
> 
> The framebuffer driver has been tested in i386 kernel and x86_64
> kernel on EFI platform.
> 
> Signed-off-by: Chandramouli Narayanan <mouli@linux.intel.com>
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> 

Missing `---' ;-)

>  drivers/video/Kconfig       |   11 ++
>  drivers/video/Makefile      |    1 
>  drivers/video/efifb.c       |  232 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/screen_info.h |    1 
>  4 files changed, 245 insertions(+)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
