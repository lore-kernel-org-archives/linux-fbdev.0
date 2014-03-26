From: Timur Tabi <timur@tabi.org>
Date: Wed, 26 Mar 2014 18:46:56 +0000
Subject: Re: [PATCH 1/2] video/fsl: make the diu driver work without platform hooks
Message-Id: <533320A0.8010507@tabi.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395855704-19908-1-git-send-email-Jason.Jin@freescale.com>
In-Reply-To: <1395855704-19908-1-git-send-email-Jason.Jin@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Jin <Jason.Jin@freescale.com>
Cc: b07421@freescale.com, linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, r58472@freescale.com

On 03/26/2014 12:41 PM, Jason Jin wrote:
> This board sepecific initialization mechanism is not feasible i
> for corenet platform as the corenet platform file is a
> abstraction of serveral platforms.

You can't make it 100% abstract.  The DIU driver requires some sort of 
board support.  I think you can make a generic platform file for the DIU.

> However, the DIU is already initialized in u-boot and we can
> rely on the settings in u-boot for corenet platform,

I don't like that at all.

> the only
> issue is that when DIU wake up from the deepsleep, some of the
> board specific initialization will lost, such as the pixel clock
> setting.

That is a BIG issue.  This is why we have a platform file -- to handle 
the platform issues.



