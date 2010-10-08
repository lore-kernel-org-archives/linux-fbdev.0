From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Fri, 08 Oct 2010 09:52:23 +0000
Subject: Re: [PATCH v6 0/3] OMAP: DSS2: OMAPFB: Allow FB_OMAP2 to build
Message-Id: <1286531543.28499.1072.camel@tubuntu.research.nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1286520273-4892-1-git-send-email-svadivu@ti.com>
In-Reply-To: <1286520273-4892-1-git-send-email-svadivu@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ext Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: "hvaibhav@ti.com" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Fri, 2010-10-08 at 08:44 +0200, ext Guruswamy Senthilvadivu wrote:
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> The changelog till v6 are:
> 	- Address Multi-omap build issue
> 	- Added a check to warn the wrong usage of vrfb 
> 	in non-vrfb omap devices.
> 	- The patch subject is as per the naming conventions
> 	- patch 2/3 now has the changes in omap2/omapfb/Kconfig
> 	instead of omap2/Kconfig.  The functional effect remains
> 	the same, and the place of implementation is more appropriate.
> 	- Provide details of non-vrfb devices in commit description in patch 3/3
> 	- Removed extra paranthesis in cpu checks
> 

Thanks, looks fine to me. Applied to DSS2 tree.

 Tomi


