From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 24 May 2011 07:27:29 +0000
Subject: Re: [PATCH 1/3] fbdev/amifb: Correct check for video memory size
Message-Id: <20110524072729.GG11986@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306006976-32117-1-git-send-email-geert@linux-m68k.org> <1306006976-32117-3-git-send-email-geert@linux-m68k.org> <1306006976-32117-1-git-send-email-geert@linux-m68k.org> <1306006976-32117-2-git-send-email-geert@linux-m68k.org> <1306006976-32117-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1306006976-32117-3-git-send-email-geert@linux-m68k.org> <1306006976-32117-2-git-send-email-geert@linux-m68k.org> <1306006976-32117-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org

On Sat, May 21, 2011 at 09:42:54PM +0200, Geert Uytterhoeven wrote:
> The check should compare the available memory size with the highest allocation
> value (VIDEOMEMSIZE_*_2M), not with the lowest value (VIDEOMEMSIZE_*_1M).
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

On Sat, May 21, 2011 at 09:42:55PM +0200, Geert Uytterhoeven wrote:
> Fail gracefully instead.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

On Sat, May 21, 2011 at 09:42:56PM +0200, Geert Uytterhoeven wrote:
> amiga_chip_alloc() already aligns to the PAGE_SIZE
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

All applied, thanks.
