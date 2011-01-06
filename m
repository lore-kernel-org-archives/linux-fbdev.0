From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 06 Jan 2011 06:44:28 +0000
Subject: Re: [PATCH v3] video: imxfb: Fix the maximum value for yres
Message-Id: <20110106064428.GC15340@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1293193704-2855-1-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1293193704-2855-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 24, 2010 at 10:28:24AM -0200, Fabio Estevam wrote:
> MX27 and MX25 have 10 bits in the YMAX field of LCDC Size Register.
> 
> Fix the maximum value for yres.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
