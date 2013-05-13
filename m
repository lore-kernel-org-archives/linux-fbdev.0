From: Shawn Guo <shawn.guo@freescale.com>
Date: Mon, 13 May 2013 05:39:41 +0000
Subject: Re: [RFC 32/42] drivers/video: don't check resource with devm_ioremap_resource
Message-Id: <20130513053939.GA8542@S2101-09.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
 <1368173847-5661-33-git-send-email-wsa@the-dreams.de>
 <002c01ce4e09$218612b0$64923810$@samsung.com>
In-Reply-To: <002c01ce4e09$218612b0$64923810$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Wolfram Sang' <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, Fabio Estevam <fabio.estevam@freescale.com>

On Sat, May 11, 2013 at 02:33:56PM +0900, Jingoo Han wrote:
> On Friday, May 10, 2013 5:17 PM, Wolfram Sang wrote:
> > 
> > devm_ioremap_resource does sanity checks on the given resource. No need to
> > duplicate this in the driver.
> > 
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> 
> CC'ed Tomi Valkeinen, Shawn Guo, Fabio Estevam

Acked-by: Shawn Guo <shawn.guo@linaro.org>

