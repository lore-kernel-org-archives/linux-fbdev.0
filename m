From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Jun 2011 07:35:31 +0000
Subject: Re: [PATCH] fbdev/atyfb: Fix 2 defined-but-not-used warnings
Message-Id: <20110614073531.GH17891@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1307988778-21644-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1307988778-21644-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ville Syrjala <syrjala@sci.fi>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org

On Mon, Jun 13, 2011 at 08:12:58PM +0200, Geert Uytterhoeven wrote:
> If CONFIG_FB_ATY_BACKLIGHT=y but CONFIG_PCI=n:
> 
> drivers/video/aty/atyfb_base.c:2272: warning: ???aty_bl_exit??? defined but not used
> 
> If CONFIG_ATARI=y for a modular build:
> 
> drivers/video/aty/atyfb_base.c:2794: warning: ???store_video_par??? defined but not
> used
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied, thanks.
