From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 09 Oct 2018 07:51:43 +0000
Subject: Re: [RESEND PATCH v2 3/3] ARM: dts: imx28-cfa10036: Fix the reset gpio signal polarity
Message-Id: <20181009075145eucas1p2691c7d04aa8328080af7cbc4ab5e03b9~b4WFAVFkx0235802358eucas1p2c@eucas1p2.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
        <1538040281-21319-3-git-send-email-michal.vokac@ysoft.com>
        <68f4da21-6f0d-5bf9-b352-cdc423269080@ysoft.com>
        <CGME20181009002056epcas5p24207204c9e65e8f34382de6672adb993@epcas5p2.samsung.com>
        <20181009002031.GU3587@dragon>
In-Reply-To: <20181009002031.GU3587@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Shawn Guo <shawnguo@kernel.org>
Cc: =?UTF-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>, Fabio Estevam <fabio.estevam@nxp.com>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>


On 10/09/2018 02:20 AM, Shawn Guo wrote:
> On Mon, Oct 08, 2018 at 11:45:36AM +0000, Vokáč Michal wrote:
>> On 27.9.2018 11:24, Michal Vokáč wrote:
>>> The reset signal of the SSD1306 OLED display is actually active-low.
>>> Adapt the DT to reflect the real world.
>>>
>>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>>> ---
>>> v2 changes: New patch in the series
>>
>> Bartlomiej just queued the first two patches for v4.20.
>> Will somebody take this one? Otherwise this SoM will end up with
>> broken OLED display reset.
> 
> Well, it means the change breaks the ABI between kernel and device tree,
> e.g. the new kernel will not work with existing/installed DTBs.

Should I revert this sdd10307fb patch then?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
