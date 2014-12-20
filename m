From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 20 Dec 2014 15:52:54 +0000
Subject: Re: [PATCH v2 4/7] imx-drm: ipuv3-crtc: Implement mode_fixup
Message-Id: <20141220155254.GJ11285@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1418954426-21909-1-git-send-email-steve_longerbeam@mentor.com>
 <1418954426-21909-5-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1418954426-21909-5-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Longerbeam <slongerbeam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, linux-fbdev@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Denis Carikli <denis@eukrea.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Thu, Dec 18, 2014 at 06:00:23PM -0800, Steve Longerbeam wrote:
> Ask the IPU display interface, via ipu_di_adjust_videomode(), to
> adjust a video mode to meet any DI restrictions. The function takes
> a subsystem independent videomode, so the drm_display_mode must be
> converted to videomode first, and then the adjusted mode converted
> back to a drm_display_mode.

What is the reason to use videomode (apart from it being subsystem
independent)?  Do we forsee implementation of other output subsystems
for the IPU?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
