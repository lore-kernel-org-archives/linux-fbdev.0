From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 Jan 2011 04:10:02 +0000
Subject: Re: [PATCH] video: move SH_MIPI_DSI/SH_LCD_MIPI_DSI to the top of menu
Message-Id: <20110113041002.GC12013@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294845575-4508-1-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1294845575-4508-1-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 12, 2011 at 06:19:35PM +0300, Dmitry Eremin-Solenikov wrote:
> Kconfig entries SH_MIPI_DSI and SH_LCD_MIPI_DSI while being invisible to
> the user, broke the FrameBuffer menu (at least in menuconfig), as they
> aren't depending on respective menuconfig item (FB). In result several
> items got moved to the main "Graphics support" menu. Move these two
> problematic items to the top of drivers/video/Kbuild to restore nice
> display of FB menu.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Applied, thanks.
