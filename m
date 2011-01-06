From: daeinki <inki.dae@samsung.com>
Date: Thu, 06 Jan 2011 06:51:24 +0000
Subject: Re: [PATCH RE-SEND] s3c-fb: Add support S5PV310 FIMD
Message-Id: <4D25666C.4060102@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294128333-28736-1-git-send-email-kgene.kim@samsung.com>
 <001b01cbabf6$c62180a0$526481e0$%dae@samsung.com>
 <00db01cbad61$4a308d80$de91a880$%kim@samsung.com>
In-Reply-To: <00db01cbad61$4a308d80$de91a880$%kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, ben-linux@fluff.org, akpm@linux-foundation.org, lethal@linux-sh.org, 'Jonghun Han' <jonghun.han@samsung.com>, 'Sangbeom Kim' <sbkim73@samsung.com>

Hello, Mr. Kukjin.

Kukjin Kim 쓴 글:
> Inki Dae wrote:
>> Hello, Mr. Kukjin.
>>
> Hi,
> 
>> I know we had a discussion about your patch below.
>> after that, did you have some discussion about that?
>> If not, Paul advised to use clkdev lookup.
>>
>> Please, refer to below mail.
>>
> http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg03448.html
> 
> I think it's different with your approach even though the purpose is similar
> and I know, Mr. Han explained about clock configurable by call.

please, refer to below.
http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg03445.html

for identify clock types("lcd" for bus clock or "fimd" for sclk_fimd), 
using switch-case seems to be bad. for avoiding this one I suggested 
other way and the way clock type selection from platform data is also 
bad so Paul adviced us to use clk_dev lookup.

> 
> Paul, how do you think about this?
> 
> Personally, if we want to support S5PV310 FIMD now, this patch is good to
> support it and to us now.
> Of course, I think, we can upgrade it later.
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
>>> -----Original Message-----
>>> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
>>> owner@vger.kernel.org] On Behalf Of Kukjin Kim
>>> Sent: Tuesday, January 04, 2011 5:06 PM
>>> To: linux-samsung-soc@vger.kernel.org; linux-fbdev@vger.kernel.org
>>> Cc: ben-linux@fluff.org; akpm@linux-foundation.org; lethal@linux-sh.org;
>>> Jonghun Han; Sangbeom Kim; InKi Dae; Kukjin Kim
>>> Subject: [PATCH RE-SEND] s3c-fb: Add support S5PV310 FIMD
>>>
>>> From: Jonghun Han <jonghun.han@samsung.com>
>>>
>>> This patch adds struct s3c_fb_driverdata s3c_fb_data_s5pv310 for S5PV310
>>> and S5PC210. The clk_type is added to distinguish clock type in it and
>>> lcd_clk is added in structure s3c_fb to calculate divider for lcd panel.
>>>
>>> Please refer to below diagrams about clocks of FIMD IP. FIMD driver
> needs
>>> two clocks for FIMD IP and LCD pixel clock. Actually, the LCD pixel
> clock
>>> can be selected from 1.clk 'lcd' and 2.SCLK_FIMD before S5PV310. But
> from
>>> S5PV310, the 2.SCLK_FIMD can be used only for source of LCD pixel clock.
>>>
>>> FIMD_CLK_TYPE0:
>>>            ------------------------------------
>>>                       dsys bus
>>>            ----------------+-------------------
>>>                            |
>>>                            |1.clk 'lcd'
>>>                            |
>>>                            | FIMD block
>>>                        +---+-----------+
>>> 4.mout_mpll |\         |   |           |
>>>     --------|m|        | +-+-+ +----+  |
>>>             |u|-+      | |   +-+core|  |
>>>             |x| |      | |     +----+  |
>>>             |/  |      | | |\          |
>>>                 |      | +-|m|  +---+  |
>>>                 |      |   |u|--+div|  |
>>>                 +------+---|x|  +---+  |
>>>            2.SCLK_FIMD |   |/     |    |
>>>                        |          |    |
>>>                        +----------+----+
>>>                                   |
>>>            inside of SoC          |
>>>            -----------------------+--------------------------
>>>            outside of SoC         |
>>>                                   | 3.LCD pixel clock
>>>                                   |
>>>                           +--------------+
>>>                           | LCD module   |
>>>                           +--------------+
>>>
>>> FIMD_CLK_TYPE1:
>>>            ------------------------------------
>>>                       dsys bus
>>>            ----------------+-------------------
>>>                            |
>>>                            |1.clk 'fimd'
>>>                            |
>>>                            | FIMD block
>>>                        +---+-----------+
>>> 4.mout_mpll |\         |   |           |
>>>     --------|m|        |   |   +----+  |
>>>             |u|-+      |   +---+core|  |
>>>             |x| |      |       +----+  |
>>>             |/  |      |               |
>>>                 |      |        +---+  |
>>>                 |      |     +--+div|  |
>>>                 +------+-----+  +---+  |
>>>            2.SCLK_FIMD |          |    |
>>>                        |          |    |
>>>                        +----------+----+
>>>                                   |
>>>            inside of SoC          |
>>>            -----------------------+--------------------------
>>>            outside of SoC         |
>>>                                   | 3.LCD pixel clock
>>>                                   |
>>>                           +--------------+
>>>                           | LCD module   |
>>>                           +--------------+
>>>
>>> Signed-off-by: Jonghun Han <jonghun.han@samsung.com>
>>> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
>>> Cc: InKi Dae <inki.dae@samsung.com>
>>> Cc: Ben Dooks <ben-linux@fluff.org>
>>> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>>> ---
>>> Hi Paul,
>>>
>>> I and Mr. Han, Jonghun sent below patch several weeks ago.
>>> But I couldn't find it in your tree...
>>> (Re-made against on your latest fbdev-2.6.git #master)
>>>
>>> I think this should be merged for supporting S5PV310/S5PC210 frame
> buffer.
>>> So could you please let me know your opinion or plan about this?
>>>
>>> NOTE: Needs following platform device patches for S5PV310/S5PC210 frame
>>> buffer.
>>> And I already applied that in my tree as S5P SoCs architecture
> maintainer.
>>> 0001-ARM-S5PV310-Add-FIMD-resource-definition.patch
>>> 0002-ARM-S5PV310-Add-platform-device-and-helper-functio.patch
>>> 0004-ARM-S5PV310-Add-support-FIMD0-and-LTE480WV-LCD-for.patch
>>>
>>>  drivers/video/Kconfig  |    2 +-
>>>  drivers/video/s3c-fb.c |  125
>>> +++++++++++++++++++++++++++++++++++++++++++-----
>>>  2 files changed, 113 insertions(+), 14 deletions(-)
> 
> 

