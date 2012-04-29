From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 29 Apr 2012 23:18:24 +0000
Subject: Re: [PULL for v3.5] fb: exynos: Fix MIPI/DSI front/back porch settings
Message-Id: <4F9DCC40.7000808@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4788368.X6fyZNtHh2@avalon>
In-Reply-To: <4788368.X6fyZNtHh2@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 04/24/2012 12:44 PM, Laurent Pinchart wrote:
> Hi Florian,
> 
> Could you please pull the following fix ?
> 
> The following changes since commit d313a86d2efb2c5568832389663322e93e291c59:
> 
>   i.MX28: Shut down the LCD controller to avoid BootROM sampling bug 
> (2012-04-21 21:53:12 +0000)
> 
> are available in the git repository at:
>   git://linuxtv.org/pinchartl/fbdev.git fixes

Merged.


Thanks,

Florian Tobias Schandinat

> 
> Laurent Pinchart (1):
>       fb: exynos: Fix MIPI/DSI front/back porch settings
> 
>  drivers/video/exynos/exynos_mipi_dsi_common.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 

