From: Donghwa Lee <dh09.lee@samsung.com>
Date: Wed, 25 Jan 2012 00:14:58 +0000
Subject: Re: [PATCH v7 1/2] video: support MIPI-DSI controller driver
Message-Id: <4F1F4982.5050000@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4F17AA10.7080604@samsung.com> <4F182ACF.8010302@ti.com>
 <20120120155121.18880dff.akpm@linux-foundation.org>
In-Reply-To: <20120120155121.18880dff.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, 21 Jan 2012 08:51, Andrew Morton wrote:

> On Thu, 19 Jan 2012 20:08:07 +0530
> Archit <a0393947@ti.com> wrote:
> 
>> On Thursday 19 January 2012 10:58 AM, Donghwa Lee wrote:
>>> Samsung S5PC210 and EXYNOS SoC platform has MIPI-DSI controller and MIPI-DSI
>>> based LCD Panel could be used with it. This patch supports MIPI-DSI driver
>>> based Samsung SoC chip.
>>>
>>> LCD panel driver based MIPI-DSI should be registered to MIPI-DSI driver at
>>> machine code and LCD panel driver specific function registered to mipi_dsim_ddi
>>> structure at lcd panel init function called system init.
>>> In the MIPI-DSI driver, find lcd panel driver by using registered
>>> lcd panel name, and then initialize lcd panel driver.
>>>
>>> Changes since v6:
>>> 	- remove obscure compile problems.
>>> 	- remove useless codes.
>>> 	- modify return errno codes properly
>>
>> One more comment about 'mipi_dsim.h', it would be better to put it in
>> include/video and not 'include/linux'.
> 
> Yes, that is desirable.
> 
>>> ---
>>>   drivers/video/Kconfig                 |    6 +
>>>   drivers/video/Makefile                |    2 +
>>>   drivers/video/s5p_mipi_dsi.c          |  599 ++++++++++++++++++++++
>>>   drivers/video/s5p_mipi_dsi_common.c   |  896 +++++++++++++++++++++++++++++++++
>>>   drivers/video/s5p_mipi_dsi_common.h   |   46 ++
>>>   drivers/video/s5p_mipi_dsi_lowlevel.c |  617 +++++++++++++++++++++++
>>>   drivers/video/s5p_mipi_dsi_lowlevel.h |  112 ++++
>>>   drivers/video/s5p_mipi_dsi_regs.h     |  149 ++++++
>>>   include/linux/mipi_dsim.h             |  359 +++++++++++++
>>>   9 files changed, 2786 insertions(+), 0 deletions(-)
> 
> or we could put it in drivers/video/.  It all depends on which other
> drivers we expect will need access to this header.
> 

No, mipi_dsim.h file includes global interface data, callback function called by machine 
file, platform data for mipi-dsi driver and so on. So I think it would be better to put
in 'include/video' or 'include/linux'. 
Of course it is much better to change name to 's5p_mipi_dsim.h'

Thank you, 
Donghwa Lee

 


