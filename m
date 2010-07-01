From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 01 Jul 2010 09:30:37 +0000
Subject: Re: [PATCH 0/6] fbdev: sh-mobile: HDMI support for SH-Mobile SoCs
Message-Id: <AANLkTimFd21-FyUr-a7bJOAWqNiQSffD7KGNmxvu6qGD@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1006301128310.17489@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1006301128310.17489@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Guennadi,

On Wed, Jun 30, 2010 at 6:55 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> This patch set adds a static HDMI support to SH-Mobile SoCs, specifically,
> to sh7372 (ap4evb) in this version. "Static" means only 720p is supported
> ATM. Also hotplug support is implemented without changing the framebuffer
> geometry. Dynamic geometry reconfiguration is planned for a future patch.

I just gave your patches a quick try, and they seem to work fine on my
AP4EVB board.

The timings are not perfect for my 16:9 LG monitor, but this is much
better than nothing. I suppose next step will be to parse the EDID and
dynamically configure the LCDC. This version ties in the LCDC, but
does nothing with sound, right?

With this set of patches the HDMI port comes up as /dev/fb1. My AP4EVB
board does not have any LCD panel mounted - both MIPI-DSI ports are
empty and I have not bothered attaching the Ecovec WVGA panel. I've
heard that's the case for most AP4EVB boards these days. So /dev/fb0
ends up being unused.

Not sure how to get console output to /dev/fb1 easily - in my quick
test I ended up removing the LCDC0 platform devices to get the HDMI on
/dev/fb0. Also, I'm very sad to discover that the penguin is gone. I
wonder why, hint-hint. =)

I'll look at the patches in more detail tomorrow.

Thanks!

/ magnus
