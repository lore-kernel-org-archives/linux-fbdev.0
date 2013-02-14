From: Archit Taneja <archit@ti.com>
Date: Thu, 14 Feb 2013 07:29:19 +0000
Subject: Re: [PATCH 00/33] OMAPDSS: platform_enable/disable callback removal from panel drivers
Message-Id: <511C8F7F.1060504@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <20130213164647.GF7144@atomide.com>
In-Reply-To: <20130213164647.GF7144@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tony Lindgren <tony@atomide.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi,

On Wednesday 13 February 2013 10:16 PM, Tony Lindgren wrote:
> * Archit Taneja <archit@ti.com> [130213 06:26]:
>> init functions in omap board files request panel specific gpios, and provide
>> functions which omapdss panel drivers call to enable or disable them.
>>
>> Instead of the board files requesting these gpios, they should just pass the
>> platform specific data(like the gpio numbers), the panel should retrieve the
>> platform data and request the gpios. Doing this prevents the need of the panel
>> driver calling platform functions in board files.
>>
>> Panel drivers have their own platform data struct, and the board files populate
>> these structs and pass the pointer to the 'data' field of omap_dss_device. This
>> work will make it easier for the panel drivers be more adaptable to the
>> DT model.
>>
>> There is also removal of passing panel reset_gpio numbers through
>> omap_dss_device struct directly, reset gpios are passed through platform data
>> only.
>
> To avoid merge conflicts and dependencies between drivers and core
> Soc code, please break thes kind of patches into following parts:
>
> 1. Any platform_data header changes needed so both I and Tomi
>     can pull it in as needed.
>
> 2. Changes to DSS drivers. Please keep stubs around for the
>     board specific callback functions so omap2plus_defconfig
>     won't break with just #1 merged into arm soc tree.

The build won't break, and the kernel will boot up properly, but the 
panels won't work till the time #3 is also merged,

>
> 3. All the arch/arm/*omap* changes based on #1 above to
>     drop obsolete callback functions and add new pdata if still
>     needed. This needs to build and boot on #1 so I can merge
>     this in via arm soc tree.
>
> 4. Any .dts changes needed.

We don't have any .dts changes for DSS as of now.

I'll split the patches accordingly.

Thanks,
Archit
