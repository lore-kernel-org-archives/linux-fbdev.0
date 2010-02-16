From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 16 Feb 2010 15:38:24 +0000
Subject: Re: [PATCH 0/3] mx25: framebuffer support
Message-Id: <4B7ABBF0.1090102@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1265786237.git.baruch@tkos.co.il>
	<20100216151420.GD32332@jasper.tkos.co.il>
In-Reply-To: <20100216151420.GD32332@jasper.tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

Baruch Siach schrieb:
> Ping?
> 
> I'd really like to see this merged in .34.

if no one feels responsible for taking this stuff you might want to try 
sending it to Andrew Morton (CC'ed). Just a general advice I really 
don't know this framebuffer.


Regards,

Florian Tobias Schandinat

> On Wed, Feb 10, 2010 at 09:25:17AM +0200, Baruch Siach wrote:
>> This set of patches adds support for the i.MX25 LCD controller block using the 
>> imxfb driver. Platform code for the i.MX25 PDK board is also added.
>>
>> Tested on the i.MX25 PDK.
>>
>> Baruch Siach (3):
>>   imxfb: add support for i.MX25
>>   mx25: add platform support for imxfb
>>   mx25pdk: add LCD support
>>
>>  arch/arm/mach-mx25/clock.c                  |   12 ++++++
>>  arch/arm/mach-mx25/devices.c                |   23 +++++++++++
>>  arch/arm/mach-mx25/devices.h                |    1 +
>>  arch/arm/mach-mx25/mx25pdk.c                |   55 +++++++++++++++++++++++++++
>>  arch/arm/plat-mxc/include/mach/iomux-mx25.h |    2 +
>>  arch/arm/plat-mxc/include/mach/mx25.h       |    2 +
>>  drivers/video/Kconfig                       |    2 +-
>>  7 files changed, 96 insertions(+), 1 deletions(-)
> 

