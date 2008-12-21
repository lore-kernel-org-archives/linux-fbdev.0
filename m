From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 00/05] video: deferred io fixes and sh_mobile_lcdcfb support
Date: Sun, 21 Dec 2008 15:53:58 +0900
Message-ID: <20081221065358.GA12631@linux-sh.org>
References: <20081219063359.2703.85817.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081219063359.2703.85817.sendpatchset@rx1.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>, Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-sh@vger.kernel.org

On Fri, Dec 19, 2008 at 03:33:59PM +0900, Magnus Damm wrote:
> video: deferred io fixes and sh_mobile_lcdcfb support
> 
> [PATCH 01/05] video: fix deferred io fsync()
> [PATCH 02/05] video: deferred io cleanup
> [PATCH 03/05] video: deferred io with physically contiguous memory
> [PATCH 04/05] video: sh_mobile_lcdcfb deferred io support 
> [PATCH 05/05] sh: enable deferred io LCDC on Migo-R
> 
> This patchset adds deferred io support to sh_mobile_lcdcfb.
> 
> The LCDC hardware block managed by the sh_mobile_lcdcfb driver supports
> RGB or SYS panel configurations. SYS panels come with an external display
> controller that is resposible for refreshing the actual LCD panel. RGB
> panels are controlled directly by the LCDC and they need to be refreshed
> by the LCDC hardware.
> 
> In the case of SYS panels we can save some power by configuring the LCDC
> hardware block in one-shot mode. In this one-shot mode panel refresh is
> managed by software. This works well together with deferred io since it
> allows us to stop clocks for most of the time and only enable clocks when
> we actually want to trigger an update. When there is no fbdev activity
> the clocks are kept stopped which allows us to deep sleep.
> 
> May I suggest merging the first 3 patches with other framebuffer changes,
> but handling patch 4 and 5 with other SuperH changes? That strategy
> should be fine since there are no compile time dependencies. To keep
> things running please apply patch number 5 when all other changes are in.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

I have no particular issues with this series anyways. If Jaya is fine
with the first three, I will take the last two. Or I can just take the entire
series, as it's fairly insular and no one else is likely to care about it
presently. Jaya?
