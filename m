From: Shawn Guo <shawnguo@kernel.org>
Date: Tue, 09 Oct 2018 00:20:33 +0000
Subject: Re: [RESEND PATCH v2 3/3] ARM: dts: imx28-cfa10036: Fix the reset gpio signal polarity
Message-Id: <20181009002031.GU3587@dragon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
 <1538040281-21319-3-git-send-email-michal.vokac@ysoft.com>
 <68f4da21-6f0d-5bf9-b352-cdc423269080@ysoft.com>
In-Reply-To: <68f4da21-6f0d-5bf9-b352-cdc423269080@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Fabio Estevam <fabio.estevam@nxp.com>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Mon, Oct 08, 2018 at 11:45:36AM +0000, Vokáč Michal wrote:
> On 27.9.2018 11:24, Michal Vokáč wrote:
> > The reset signal of the SSD1306 OLED display is actually active-low.
> > Adapt the DT to reflect the real world.
> > 
> > Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> > ---
> > v2 changes: New patch in the series
> 
> Bartlomiej just queued the first two patches for v4.20.
> Will somebody take this one? Otherwise this SoM will end up with
> broken OLED display reset.

Well, it means the change breaks the ABI between kernel and device tree,
e.g. the new kernel will not work with existing/installed DTBs.

Shawn
