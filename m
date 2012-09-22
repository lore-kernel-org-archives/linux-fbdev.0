From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Sat, 22 Sep 2012 15:43:03 +0000
Subject: Re: [alsa-devel] [PATCH v2 00/34] i.MX multi-platform support
Message-Id: <20120922154303.GO4495@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
 <201209200739.34899.arnd@arndb.de>
 <20120920145342.GI2450@S2101-09.ap.freescale.net>
 <201209201556.57171.arnd@arndb.de>
 <20120921080123.GM2450@S2101-09.ap.freescale.net>
 <CAOesGMi6CbvFikycJVdE8W-DxLD3W7+CyScz+YT103dxR31U9g@mail.gmail.com>
In-Reply-To: <CAOesGMi6CbvFikycJVdE8W-DxLD3W7+CyScz+YT103dxR31U9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olof Johansson <olof@lixom.net>
Cc: alsa-devel@alsa-project.org, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, linux-fbdev@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, rtc-linux@googlegroups.com, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, Chris Ball <cjb@laptop.org>, linux-media@vger.kernel.org, linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org, Vinod Koul <vinod.koul@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Javier Martin <javier.martin@vista-silicon.com>, Andrew Morton <akpm@linux-foundation.org>, Shawn Guo <shawn.guo@linaro.org>G

On Fri, Sep 21, 2012 at 01:26:43AM -0700, Olof Johansson wrote:

> I'll take a look at merging it tomorrow after I've dealt with smp_ops;
> if it looks reasonably conflict-free I'll pull it in. We need the
> sound dependency sorted out (or agreed upon) first though.

I guess in the light of the rest of the thread it doesn't much matter
for this merge window but I just pushed:

 git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.7

which is signed so can happily be merged elsewhere.
