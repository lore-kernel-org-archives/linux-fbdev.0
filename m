From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: Re: [PATCH] video: SuperH Mobile LCDC Driver
Date: Fri, 30 May 2008 17:14:54 +0900
Message-ID: <20080530171454.1c0eb6c6.iwamatsu@nigauri.org>
References: <20080529092451.19666.91541.sendpatchset@rx1.opensource.se>
	<20080530135928.9a555aca.iwamatsu@nigauri.org>
	<20080530051554.GA21499@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20080530051554.GA21499@roarinelk.homelinux.net>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, lethal@linux-sh.org, akpm@linux-foundation.org, linux-sh@vger.kernel.org

Hi, Manuel.

On Fri, 30 May 2008 07:15:54 +0200
Manuel Lauss <mano@roarinelk.homelinux.net> wrote:

> > This is a proposal. 
> > I am coding sh7763's frame buffer driver.
> 
>  I wrote a driver for the SH7760 LCDC 2 years ago. From a quick glance at
> the respective datasheets it seems both 7760 and 7763 have identical
> register layout.  Looking at Magnus' driver, the 7722/7723 LCDC seems to
> be an extended version of the 7760/63 LCDC. Maybe we can unify them somehow?

Thank you for your comments.

I comment on SH7760 and SH7763 because Magnus is writing for SH7722 and SH7723. 

I checked these data sheets. Most registers are the same. 
I think that I can merge it. 

Can I check the driver of SH7760 that you wrote where?

And I need found SH7760 LCDC suport board .....

Best regards,
 Nobuhiro

-- 
Nobuhiro Iwamatsu
