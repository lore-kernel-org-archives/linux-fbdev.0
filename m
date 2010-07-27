From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 27 Jul 2010 08:30:31 +0000
Subject: Re: [PATCH 5/6 v3] fbdev: sh-mobile: HDMI support for SH-Mobile SoCs
Message-Id: <AANLkTimRvT4B3F-6oV5emPtoPNsMwWEmp2yMEQRr9w63@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1007211156030.16933@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1007211156030.16933@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Jul 21, 2010 at 7:13 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Some SH-Mobile SoCs have an HDMI controller and a PHY, attached to one of their
> LCDC interfaces. This patch adds a preliminary static support for such
> controllers, this means, that only the 720p mode is handled ATM. Support for
> more modes and a dynamic switching between them will be added by a follow up
> patch.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

[v3]

Acked-by: Magnus Damm <damm@opensource.se>
