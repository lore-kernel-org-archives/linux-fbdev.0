From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [RFC] Initial OLPC Viafb merge
Date: Fri, 09 Apr 2010 07:43:35 +0200
Message-ID: <4BBEBE87.4000809@gmx.de>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1270746946-12467-1-git-send-email-corbet@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

Hi Jon,

Jonathan Corbet schrieb:
> The following patches are the beginning of an effort to move work done for
> the OLPC XO 1.5 machine into the mainline.  What's here is basic support
> for the VX855 chipset, I2C, suspend/resume, and the OLPC panel display.

Thanks a lot for your work I appreciate it very much.
However there are 2 things I'd like to ask for:

Could you please forward port them to latest mainline? There went some 
changes in for 2.6.34 that break some of your patches (but not many and 
at least the first conflict is easy to fix) as I generally prefer to 
test a version that does not contain too much changes from myself.

Please make checkpatch happy where appropriate. (whitespaces, ...)

> What's coming in the future is a reworking of the viafb driver into
> something resembling a proper multifunction device, GPIO support, and
> camera support.  But I'd like to start here.

Yeah, that's already a whole bunch of stuff. I agree that it's time to 
get this in.

> If there's no objections, I'll start a tree and get it into linux-next in
> the near future, with an eye toward a 2.6.35 merge.

At least I'd like to see your work as early as possible so that we can 
avoid conflicts (in patches and design). I hope this will get a bit 
better after viafb is split up.
I don't have a strong opinion on the patch submission route as long as I 
have the possibility to work on viafb and get some patches in as getting 
to far ahead/away from mainline really sucks especially if one has not 
all the hardware to test with. That said I'd be glad if we could 
work/discuss the issues on these patches and get them in the next merge 
window somehow.
Fortunately I still have a bit time left to finish the review of the 
remaining patches in the next days but I would really appreciate it very 
much if you could publish your work more frequently in the future.


Thanks,

Florian Tobias Schandinat

> Chris Ball (2):
>       viafb: Add 1200x900 DCON/LCD panel modes for OLPC XO-1.5
>       viafb: Do not probe for LVDS/TMDS on OLPC XO-1.5
> 
> Deepak Saxena (3):
>       Minimal support for viafb suspend/resume
>       VIAFB: Update suspend/resume to selectively restore registers
>       Remove cursor restore hack in viafb
> 
> Harald Welte (4):
>       [FB] viafb: Fix various resource leaks during module_init()
>       viafb: use proper pci config API
>       viafb: Determine type of 2D engine and store it in chip_info
>       viafb: rework the I2C support in the VIA framebuffer driver
> 
> Jonathan Corbet (5):
>       viafb: Unmap the frame buffer on initialization error
>       viafb: Retain GEMODE reserved bits
>       viafb: complete support for VX800/VX855 accelerated framebuffer
>       viafb: rework suspend/resume
>       viafb: Only suspend/resume on VX855
> 
> Paul Fox (2):
>       suppress verbose debug messages:  change printk() to DEBUG_MSG()
>       fix register save count, so it matches the restore count.
> 
>  drivers/video/via/accel.c    |   87 ++++++++++++++-----
>  drivers/video/via/accel.h    |   40 +++++++++
>  drivers/video/via/chip.h     |    8 +
>  drivers/video/via/dvi.c      |   35 +++----
>  drivers/video/via/hw.c       |   84 +++++++++++++-----
>  drivers/video/via/hw.h       |    4 
>  drivers/video/via/ioctl.h    |    2 
>  drivers/video/via/lcd.c      |   29 ++++--
>  drivers/video/via/lcd.h      |    2 
>  drivers/video/via/share.h    |    8 +
>  drivers/video/via/via_i2c.c  |  172 ++++++++++++++++++++++++--------------
>  drivers/video/via/via_i2c.h  |   43 ++++++---
>  drivers/video/via/viafbdev.c |  191 +++++++++++++++++++++++++++++++++++++++----
>  drivers/video/via/viafbdev.h |    5 -
>  drivers/video/via/viamode.c  |   14 +++
>  drivers/video/via/vt1636.c   |   36 +++-----
>  drivers/video/via/vt1636.h   |    2 
>  17 files changed, 568 insertions(+), 194 deletions(-)
> 
