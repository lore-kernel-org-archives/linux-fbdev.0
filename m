From: David Ung <davidu@nvidia.com>
Date: Tue, 18 Nov 2014 23:40:42 +0000
Subject: RE: [PATCH] video: fbdev: Add CVT timing calculations.
Message-Id: <f84f22229faa43b0a8c1f84a59c48658@HQMAIL102.nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415746455-28701-1-git-send-email-davidu@nvidia.com>
In-Reply-To: <1415746455-28701-1-git-send-email-davidu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


> -----Original Message-----
> From: David Ung [mailto:davidu@nvidia.com]
> Sent: Tuesday, November 11, 2014 2:54 PM
> To: plagnioj@jcrosoft.com; tomi.valkeinen@ti.com
> Cc: linux-fbdev@vger.kernel.org; David Ung
> Subject: [PATCH] video: fbdev: Add CVT timing calculations.
> 
> Currently fbmon is still relying on the old GTF timings when parsing the
> standard timings of the EDID.
> This causes problem with some monitor eg DELL U2410 which advertises
> high resolutions like 1920x1200@60 and GTF timing gives it 193mhz clock
> which is out of spec of the monitor which has dclkmax of 170mhz.
> This patch address the above problem by adding support for CVT with
> reduced timings.
> 
> Signed-off-by: David Ung <davidu@nvidia.com>

Ping?
