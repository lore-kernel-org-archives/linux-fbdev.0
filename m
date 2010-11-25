From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 0/4] S5PC110: MIPI-DSI support.
Date: Thu, 25 Nov 2010 09:31:50 +0900
Message-ID: <006501cb8c38$28c61b00$7a525100$%kim@samsung.com>
References: <AANLkTi=_BAN2HewcDP+rKFY6fK4APLp_wFBDt1wXh9B9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <AANLkTi=_BAN2HewcDP+rKFY6fK4APLp_wFBDt1wXh9B9@mail.gmail.com>
Content-language: ko
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'InKi Dae' <daeinki@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
Cc: 'Andrew Morton' <akpm@linux-foundation.org>, lethal@linux-sh.org, kyungmin.park@samsung.com

InKi Dae wrote:
> 
> Hello all,
> 
> This patch is a MIPI-DSI driver for S5PC110.
> 
> PATCH 1/4 : add a structure for CPU interface to linux/fb.h
> - RGB or CPU interface could be used as display mode but framebuffer
> framework doesn't consider CPU interface so I added this structure
> because fb_cpumode structure could be used commonly.
> 
> PATCH 2/4 : add parameters for CPU interface to plat-samsung/fb.h
> . MIPI-DSI driver would use s3c-fb driver so I added some parameters
> because MIPI-DSI driver supports CPU interface also.
> 
> PATCH 3/4 : add MIPI-DSI support for platform and machine.
> 
> PATCH 4/4: add MIPI-DSI driver.
> 
> Thank you.

Hi,

Please~~~ add patch version and changes.
Otherwise, have to read/check everything again :-(
I think it is always helpful to reviewer or maintainer.

Is it possible to add it at least changes from your previous?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
