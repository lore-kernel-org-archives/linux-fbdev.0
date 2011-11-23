From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 23 Nov 2011 06:59:07 +0000
Subject: Re: [PATCH 0/15] fbdev: sh_mipi_dsi: care un-explained register settings
Message-Id: <4ECC99BB.9030807@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <874nydc3vz.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nydc3vz.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Magnus, Kuninori,

On 11/21/2011 10:34 AM, Magnus Damm wrote:
> Hi Florian,
> 
> On Sat, Nov 12, 2011 at 12:37 AM, Florian Tobias Schandinat
> <FlorianSchandinat@gmx.de> wrote:
>> Hi Guennadi, Magnus,
>>
>> On 11/09/2011 04:32 AM, kuninori.morimoto.gx@renesas.com wrote:
>>> Dear Florian, Paul
>>>
>>> These are sh_mipi_dsi update patches.
>>>
>>> Kuninori Morimoto (15):
>>>       fbdev: sh_mobile_lcdcfb: fixup LDHAJR :: HSYNPAJ needs mask
>>>       fbdev: sh_mipi_dsi: tidyup dsip_clk
>>>       fbdev: sh_mipi_dsi: typo fix of SH_MIPI_DSI_HBPBM
>>>       fbdev: sh_mipi_dsi: tidyup VMCTR2 parameter expression
>>>       fbdev: sh_mipi_dsi: add SH_MIPI_DSI_HFPBM flag
>>>       fbdev: sh_mipi_dsi: add SH_MIPI_DSI_BL2E flag
>>>       fbdev: sh_mipi_dsi: add lane control support
>>>       fbdev: sh_mipi_dsi: add sync_pulses/sync_events/burst mode
>>>       fbdev: sh_mipi_dsi: add VMLEN1/VMLEN2 calculation
>>>       fbdev: sh_mipi_dsi: add set_dot_clock() for each platform
>>>       fbdev: sh_mipi_dsi: add HSxxCLK support
>>>       fbdev: sh_mipi_dsi: sh_mipi has pdata instead of dev
>>>       fbdev: sh_mipi_dsi: fixup setup timing of sh_mipi_setup()
>>>       fbdev: sh_mipi_dsi: fixup setup timing of SYSCONF
>>>       fbdev: sh_mipi_dsi: fixup setup timing DSICTRL
>>
>> can you have a look at these patches?
>> After a quick glance they look okay to me, but as this is all about hardware
>> (which I don't know) I'd be happier if someone more qualified could have a look
>> at it.
> 
> They all look fine to me. Please add:
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks for having a look. I've added it to all patches and applied them to my tree.


Thanks,

Florian Tobias Schandinat
