From: Shawn Guo <shawn.guo@linaro.org>
Date: Wed, 08 May 2013 14:00:06 +0000
Subject: Re: [PATCH 2/2] ARM: dts: cfa10036: Change the OLED display to SSD1306
Message-Id: <20130508140004.GC26072@S2101-09.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366624555-5616-1-git-send-email-maxime.ripard@free-electrons.com>
 <1366624555-5616-3-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1366624555-5616-3-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Apr 22, 2013 at 11:55:55AM +0200, Maxime Ripard wrote:
> The SSD1307 was used in an early prototype that will never get
> distributed. The final board now has a SSD1306 instead, that has its own
> power generation unit and thus doesn't need any PWM. The panel attached
> to it also changed.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied, thanks.

