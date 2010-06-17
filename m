From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Thu, 17 Jun 2010 09:03:59 +0000
Subject: Re: [PATCH v3 2/3] DSS2: make VRFB depends on OMAP2,3
Message-Id: <1276765439.12438.80.camel@tubuntu.research.nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1276169037-2598-1-git-send-email-svadivu@ti.com>
	 <1276169037-2598-2-git-send-email-svadivu@ti.com>
In-Reply-To: <1276169037-2598-2-git-send-email-svadivu@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ext Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "hvaibhav@ti.com" <hvaibhav@ti.com>

Hi,

On Thu, 2010-06-10 at 13:23 +0200, ext Guruswamy Senthilvadivu wrote:
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> config VRFB should depend on ARCH_OMAP2 or ARCH_OMAP3.
> 
> Changes from v1:
> 	- Addressed multi-omap build issue

Did you mean the VRFB config option to be visible via Kconfig? It
doesn't show there.

Please use the same patch subject as the other dss patches (applies to
other patches in this set also):

OMAP: DSS2: <subsys>: foobar

Don't add changelogs into the patch message.

 Tomi


