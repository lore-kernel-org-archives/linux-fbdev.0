From: "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>
Date: Thu, 27 Mar 2014 03:30:35 +0000
Subject: RE: [PATCH 1/2] video/fsl: make the diu driver work without platform hooks
Message-Id: <f6883c3f759a4544936acec5dc7e542b@BLUPR03MB373.namprd03.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395855704-19908-1-git-send-email-Jason.Jin@freescale.com>
 <533320A0.8010507@tabi.org>
In-Reply-To: <533320A0.8010507@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur@tabi.org>
Cc: Scott Wood <scottwood@freescale.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

> On 03/26/2014 12:41 PM, Jason Jin wrote:
> > This board sepecific initialization mechanism is not feasible i for
> > corenet platform as the corenet platform file is a abstraction of
> > serveral platforms.
> 
> You can't make it 100% abstract.  The DIU driver requires some sort of
> board support.  I think you can make a generic platform file for the DIU.
> 
[Jason Jin-R64188] Provide the generic diu platform file is reasonable, but it is will be just the board specific initialization file collection, if we really need to reinitialize something in kernel. 

> > However, the DIU is already initialized in u-boot and we can rely on
> > the settings in u-boot for corenet platform,
> 
> I don't like that at all.
[Jason Jin-R64188] What's the potential issue of this? Most of the IPs need the platform initialization in u-boot. For example, the hwconfig in u-boot used for board specific settings for most platform.

The diu_ops structure is still open for any board specific initialization if the platform needed. We at least can let the platform to select to use the diu_ops or not. This is the purse for this patch.

> 
> > the only
> > issue is that when DIU wake up from the deepsleep, some of the board
> > specific initialization will lost, such as the pixel clock setting.
> 
> That is a BIG issue.  This is why we have a platform file -- to handle
> the platform issues.
[Jason Jin-R64188] Yes, this is an issue, Actually, this is a SOC level issue, We can try to fix it in the driver by saving the pixel clock in suspend function and restored it in resume function.

Thanks.
