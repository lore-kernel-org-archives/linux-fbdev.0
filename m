From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 21 Nov 2011 10:34:50 +0000
Subject: Re: [PATCH 0/15] fbdev: sh_mipi_dsi: care un-explained register settings
Message-Id: <CANqRtoQ+nEk3PUAaHzEkqTei5Ndwk=2nBTWkeHqi03Ood3KW-A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <874nydc3vz.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nydc3vz.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Florian,

On Sat, Nov 12, 2011 at 12:37 AM, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
> Hi Guennadi, Magnus,
>
> On 11/09/2011 04:32 AM, kuninori.morimoto.gx@renesas.com wrote:
>> Dear Florian, Paul
>>
>> These are sh_mipi_dsi update patches.
>>
>> Kuninori Morimoto (15):
>> =A0 =A0 =A0 fbdev: sh_mobile_lcdcfb: fixup LDHAJR :: HSYNPAJ needs mask
>> =A0 =A0 =A0 fbdev: sh_mipi_dsi: tidyup dsip_clk
>> =A0 =A0 =A0 fbdev: sh_mipi_dsi: typo fix of SH_MIPI_DSI_HBPBM
>> =A0 =A0 =A0 fbdev: sh_mipi_dsi: tidyup VMCTR2 parameter expression
>> =A0 =A0 =A0 fbdev: sh_mipi_dsi: add SH_MIPI_DSI_HFPBM flag
>> =A0 =A0 =A0 fbdev: sh_mipi_dsi: add SH_MIPI_DSI_BL2E flag
>> =A0 =A0 =A0 fbdev: sh_mipi_dsi: add lane control support
>> =A0 =A0 =A0 fbdev: sh_mipi_dsi: add sync_pulses/sync_events/burst mode
>> =A0 =A0 =A0 fbdev: sh_mipi_dsi: add VMLEN1/VMLEN2 calculation
>> =A0 =A0 =A0 fbdev: sh_mipi_dsi: add set_dot_clock() for each platform
>> =A0 =A0 =A0 fbdev: sh_mipi_dsi: add HSxxCLK support
>> =A0 =A0 =A0 fbdev: sh_mipi_dsi: sh_mipi has pdata instead of dev
>> =A0 =A0 =A0 fbdev: sh_mipi_dsi: fixup setup timing of sh_mipi_setup()
>> =A0 =A0 =A0 fbdev: sh_mipi_dsi: fixup setup timing of SYSCONF
>> =A0 =A0 =A0 fbdev: sh_mipi_dsi: fixup setup timing DSICTRL
>
> can you have a look at these patches?
> After a quick glance they look okay to me, but as this is all about hardw=
are
> (which I don't know) I'd be happier if someone more qualified could have =
a look
> at it.

They all look fine to me. Please add:

Acked-by: Magnus Damm <damm@opensource.se>

Thanks for your help,

/ magnus
