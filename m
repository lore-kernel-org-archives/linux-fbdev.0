From: Simon Horman <horms@verge.net.au>
Date: Mon, 07 Dec 2015 06:23:50 +0000
Subject: Re: [PATCH] fbdev: Remove unused SH-Mobile HDMI driver
Message-Id: <20151207062349.GC22834@verge.net.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449244903-23336-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449244903-23336-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Dec 04, 2015 at 05:01:43PM +0100, Geert Uytterhoeven wrote:
> As of commit 44d88c754e57a6d9 ("ARM: shmobile: Remove legacy SoC code
> for R-Mobile A1"), the SH-Mobile HDMI driver is no longer used.
> In theory it could still be used on R-Mobile A1 SoCs, but that requires
> adding DT support to the driver, which is not planned.
> 
> Remove the driver, it can be resurrected from git history when needed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

