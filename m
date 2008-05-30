From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [PATCH] video: SuperH Mobile LCDC Driver
Date: Fri, 30 May 2008 14:24:26 +0900
Message-ID: <aec7e5c30805292224n46786be2td59a1c982138bfc2@mail.gmail.com>
References: <20080529092451.19666.91541.sendpatchset@rx1.opensource.se>
	 <20080530135928.9a555aca.iwamatsu@nigauri.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20080530135928.9a555aca.iwamatsu@nigauri.org>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, lethal@linux-sh.org, akpm@linux-foundation.org, linux-sh@vger.kernel.org

Hi Iwamatsu-san!

On Fri, May 30, 2008 at 1:59 PM, Nobuhiro Iwamatsu <iwamatsu@nigauri.org> wrote:
> Hi, Magnus.
>
> On Thu, 29 May 2008 18:24:51 +0900
> Magnus Damm <magnus.damm@gmail.com> wrote:
>
>> This patch adds frame buffer support for the LCDC block found in
>> SuperH Mobile processors. The hardware supports up to two LCD panels
>> per LCDC block, and both RGB and SYS interfaces can be used to hook
>> up LCD panels/modules.
>>
>> The device driver is a regular platform driver, so LCD configuration
>> and board specific hooks are passed to the driver using platform data.
>> LCD modules using SYS interface often require special configuration
>> using the SYS bus, and to solve this cleanly the driver provides SYS
>> interface operations to the board code.
>>
>> Tested on sh7723 and sh7722 processors with a SYS16A QVGA panel and
>> WVGA panels using RGB16 and RGB18 interfaces.
>>
>> Signed-off-by: Magnus Damm <damm@igel.co.jp>
>> ---
>>
>>  drivers/video/Kconfig            |   10
>>  drivers/video/Makefile           |    2
>>  drivers/video/sh_mobile_lcdcfb.c |  742 ++++++++++++++++++++++++++++++++++++++
>>  include/asm-sh/sh_mobile_lcdc.h  |   66 +++
>
> This is a proposal.
> I am coding sh7763's frame buffer driver.

That's great news!

> I think that the number of FB drivers of SH will increase in the future.
> I think that I want to make the driver/video/sh directory, and to bring
> SH together in this directory for the future.
> Do you think about it?

I think grouping drivers together by architecture is a good
suggestion, but I personally prefer a step by step approach. So I
think we should deal with it later when we actually have more drivers
upstream.

I'm aiming for having this driver included in 2.6.27. Your driver is
targeted for some release later on, right?

Thanks!

/ magnus
