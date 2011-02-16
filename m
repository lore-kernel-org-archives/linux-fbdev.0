From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 16 Feb 2011 13:11:54 +0000
Subject: Re: [PATCH 0/2] Add recommended bpp for omap dss2 generic dpi
Message-Id: <1297861914.988.1.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297530130-10355-1-git-send-email-daniel.morsing@gmail.com>
In-Reply-To: <1297530130-10355-1-git-send-email-daniel.morsing@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Morsing <daniel.morsing@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomba@iki.fi>, Bryan Wu <bryan.wu@canonical.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Sat, 2011-02-12 at 11:02 -0600, Daniel Morsing wrote:
> This series adds a mechanism for specifying a recommended bpp for
> generic dss2 dpi panels and adds a panel that uses this feature.
> 
> The panel added is the 4.3 inch display that is sold with the
> Devkit8000.

Hmm. Devkit8000's panel is connected with 24 datalines, according to the
board file. Why do you want to use 16 bpp format for that?

 Tomi


