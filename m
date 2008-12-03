From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/2] lcd: add support for Toppoly
	TDO35S series to tdo24m driver
Date: Wed, 03 Dec 2008 08:56:17 +0000
Message-ID: <1228294577.7529.2.camel@ted>
References: <492E8349.40309@compulab.co.il>
	<f17812d70811271713v7cc0e798pcd3c35bf2b3c84e8@mail.gmail.com>
	<49324176.8040904@compulab.co.il>
	<f17812d70811292340s6ca3cf4ds64070c8d9a5c42ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <f17812d70811292340s6ca3cf4ds64070c8d9a5c42ec@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, eric miao <eric.miao@marvell.com>, ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>

On Sun, 2008-11-30 at 15:40 +0800, Eric Miao wrote:
> On Sun, Nov 30, 2008 at 3:32 PM, Mike Rapoport <mike@compulab.co.il> wrote:
> > Eric Miao wrote:
> >> Looks generally OK, yet I'd prefer
> >>
> >>   1. tdo24m.h being placed in "include/linux/spi/"
> >>   2. when platform_data == NULL, default to TDO24M model?
> >
> > Ok, no problem.
> >
> > Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> 
> Acked-by: Eric Miao <eric.miao@marvell.com>
> 
> Richard,
> 
> Could you please help merge this into your backlight tree?

Done.

Cheers,

Richard

-- 
Richard Purdie
Intel Open Source Technology Centre


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
