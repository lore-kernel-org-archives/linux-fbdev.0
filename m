From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 04 Jan 2018 14:10:56 +0000
Subject: Re: [PATCH] omapfb: dss: Do not duplicate features data
Message-Id: <3826269.phH0ahbWjF@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171129123308.GA26578@lenoch>
In-Reply-To: <20171129123308.GA26578@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wednesday, November 29, 2017 06:03:14 PM Ladislav Michl wrote:
> On Wed, Nov 29, 2017 at 10:45:52AM -0600, Adam Ford wrote:
> [snip]
> > If it's correct and the patch is this one:
> > https://patchwork.kernel.org/patch/10082025/
> 
> Yes.
> 
> > Then you can mark me as:
> > 
> > Tested-by: Adam Ford <aford173@gmail.com> #omap3630
> 
> Thank you for testing. I'll wait a bit more for eventual objections
> and Marcus' decision about his credit before sending v2 :)

After adding Adam's Tested-by tag and fixing minor CodingStyle
errors reported by checkpatch.pl:

ERROR: "foo* bar" should be "foo *bar"
#37: FILE: drivers/video/fbdev/omap2/omapfb/dss/dispc.c:3979:
+static const struct dispc_features* dispc_get_features(void)

ERROR: "foo* bar" should be "foo *bar"
#114: FILE: drivers/video/fbdev/omap2/omapfb/dss/dss.c:890:
+static const struct dss_features* dss_get_features(void)

ERROR: "foo* bar" should be "foo *bar"
#199: FILE: drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c:192:
+static const struct hdmi_phy_features* hdmi_phy_get_features(void)

I've queued your patch for 4.16, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

