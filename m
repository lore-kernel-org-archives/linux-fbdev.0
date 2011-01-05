From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 05 Jan 2011 08:33:18 +0000
Subject: Re: [PATCH 0/2 v2] runtime PM for the sh-mobile MIPI DSI driver
Message-Id: <20110105083318.GE23889@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1012271115470.669@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1012271115470.669@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Dec 27, 2010 at 11:23:02AM +0100, Guennadi Liakhovetski wrote:
> This is v2 of the patch series, implementing runtime-pm for the sh-mobile 
> mipi-dsi driver and removing the static clock configuration on the AP4EVB 
> board.

On Wed, Dec 29, 2010 at 09:12:18AM +0100, Guennadi Liakhovetski wrote:
> These patches teach the sh-mobile MIPI DSI driver to use platform data to 
> support different SoC with register layout variations and different LCD 
> panels. Two of these patches affect the actual driver and one - currently 
> its only user - the ap4evb board. To avoid compilation and run-time 
> regressions we have to first add new gields to the header, then set them 
> in the affected platform, and only then modify the driver to use them. 
> This produces an unpleasant dependency chain. Alternatively, all these 
> patches could be merged into one, but that would span multiple subsystems. 
> I leave it to the maintainer to decide:)

I've merged both of these patch series in to the common/fdev-mipi branch
in the SH/R-Mobile tree and then merged that topic branch in to the fbdev
tree. Both needed a bit of mangling to merge on top of Magnus's earlier
patches, so you may want to verify that I haven't broken anything
accidentally.
