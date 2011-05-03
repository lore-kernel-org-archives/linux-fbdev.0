From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 03 May 2011 07:54:04 +0000
Subject: Re: [PATCHv2 0/2] OMAP: DSS: Support new dpi panels
Message-Id: <1304409244.2180.26.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1304406457-5109-1-git-send-email-eballetbo@iseebcn.com>
In-Reply-To: <1304406457-5109-1-git-send-email-eballetbo@iseebcn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tue, 2011-05-03 at 09:07 +0200, Enric Balletbo i Serra wrote:
> Hi all,
> 
> These patches add support for two new panels to the generic-dpi-panel.
> 
> The first patch adds support for the Seiko 70WVW1TZ3 LCD panel, and the second
> adds support for the Powertip PH480272T LCD panel.
> 
> Tested with an IGEP v2 board.
> 
> Changes since v1:
>   - Change the names of both panels in the panel_config struct to
>     include the name of the manufacturer.
>   - Mention the board which uses those panels.
> 
> Please consider to add in next merge window, thanks,
> 
> Enric Balletbo i Serra (2):
>   OMAP: DSS2: Support for Seiko 70WVW1TZ3
>   OMAP: DSS2: Support for Powertip PH480272T
> 
>  drivers/video/omap2/displays/panel-generic-dpi.c |   50 ++++++++++++++++++++++
>  1 files changed, 50 insertions(+), 0 deletions(-)

Thanks, applied to DSS tree.

 Tomi



