From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 20 Nov 2012 19:43:59 +0000
Subject: Re: [PATCHv7] video: Add support for the Solomon SSD1307 OLED Controller
Message-Id: <20121120114359.e69a51bb.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353421237-4100-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1353421237-4100-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, 20 Nov 2012 15:20:37 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> This patch adds support for the Solomon SSD1307 OLED
> controller found on the Crystalfontz CFA10036 board.
> 
> This controller can drive a display with a resolution up
> to 128x39 and can operate over I2C or SPI.
> 
> The current driver has only been tested on the CFA-10036,
> that is using this controller over I2C to driver a 96x16
> OLED screen.

Looks OK to my little eye.  I merged it into -mm.  If this
patch (or a variant of it) turns up in linux-next (via Florian's
tree) then I shall autodrop it again.
