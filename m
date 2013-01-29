From: Shawn Guo <shawn.guo@linaro.org>
Date: Tue, 29 Jan 2013 02:47:17 +0000
Subject: Re: [PATCH RESEND v4] video: imxfb: Do not crash on reboot
Message-Id: <20130129024715.GA11546@S2101-09.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359427171-18109-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1359427171-18109-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Andrew,

On Tue, Jan 29, 2013 at 12:39:31AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Issuing a "reboot" command after the LCD times out causes the following
> warnings:

Please ignore this one.  It has hit mainline through arm-soc tree
with 3.8-rc series, as we categorized it as a critical bug fixing.

Shawn

