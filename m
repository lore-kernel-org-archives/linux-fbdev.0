From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 22 Apr 2013 14:28:45 +0000
Subject: Re: [RFC v2] video: ARM CLCD: Add DT & CDF support
Message-Id: <20130422142845.GO14496@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130418102444.GL14496@n2100.arm.linux.org.uk> <1366306402-21651-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1366306402-21651-1-git-send-email-pawel.moll@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pawel Moll <pawel.moll@arm.com>
Cc: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>

On Thu, Apr 18, 2013 at 06:33:21PM +0100, Pawel Moll wrote:
> This patch adds basic DT bindings for the PL11x CLCD cells
> and make their fbdev driver use them, together with the
> Common Display Framework.
> 
> The DT provides information about the hardware configuration
> and limitations (eg. the largest supported resolution)
> but the video modes come exclusively from the Common
> Display Framework drivers, referenced to by the standard CDF
> binding.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Much better.

I will point out though that there be all sorts of worms here when you
come to the previous ARM evaluation boards (which is why the capabilities
stuff got written in the first place) where there's a horrid mixture of
BGR/RGB ordering at various levels of the system - some of which must be
set correctly because the CLCD output isn't strictly used as R bits
G bits and B bits (to support different formats from the CLCD's native
formats.)
