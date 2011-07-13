From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 13 Jul 2011 08:18:43 +0000
Subject: Re: [PATCH v2] video: da8xx-fb: Interrupt configuration of revised LCDC IP
Message-Id: <20110713081843.GE13701@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1309861280-32240-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1309861280-32240-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Jul 05, 2011 at 03:51:20PM +0530, Manjunathappa, Prakash wrote:
> An upcoming SoC of TI comes with an LCD controller which is an updated
> version of that found on TI's DA850 SoC. The da8xx-fb driver can support
> this LCD with some enhancements.
> This patch adds support for updated interrupt configuration on the new
> SoC.
> 1) Registers for setting and clearing interrupts are different.
> 2) Raw and masked status registers are different.
> The updates have been tested on an emulation platform for new features
> and the patch has been tested on DA850 platform to make sure nothing
> existing breaks.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>

Applied, thanks.
