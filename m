From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Mon, 07 Dec 2015 20:50:28 +0000
Subject: Re: [PATCH v5 2/2] video: fbdev: pxafb: initial devicetree conversion
Message-Id: <87bna2kmp7.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447792337-13876-1-git-send-email-robert.jarzmik@free.fr>
	<1447792337-13876-2-git-send-email-robert.jarzmik@free.fr>
	<5665B3C1.1080005@ti.com>
In-Reply-To: <5665B3C1.1080005@ti.com> (Tomi Valkeinen's message of "Mon, 7
	Dec 2015 18:28:49 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Herring <robh+dt@kernel.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> On 17/11/15 22:32, Robert Jarzmik wrote:
>> This patch brings a first support of pxa framebuffer devices to a
>> devicetree pxa platform, as was before platform data.
>> 
>> There are restrictions with this port, the biggest one being the lack of
>> support of smart panels. Moreover the conversion doesn't provide a way
>> to declare multiple framebuffer configurations with different bits per
>> pixel, only the LCD hardware bus width is used.
>> 
>> The patch was tested on both pxa25x, pxa27x and pxa3xx platform (namely
>> lubbock, mainstone and zylonite).
>> 
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> ---
>> Since v1: Philipp's review: of_graph usage
>> Since v3: of_device_id sentinel, and all compatible ids added
>> Since v4: fixed of_device_id table : rebase error on my side, with
>>           braces which were incorrectly added
>> ---
>>  drivers/video/fbdev/Kconfig |   2 +
>>  drivers/video/fbdev/pxafb.c | 163 +++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 162 insertions(+), 3 deletions(-)
>
> I see we already have
> Documentation/devicetree/bindings/display/marvell,pxa2xx-lcdc.txt in the
> mainline. I think the patch adding the binding doc should have been kept
> in this series.
Ah, I think Rob took it through his tree already. Probably my fault also, I hope
I had not forgotten to Cc: you on the binding patch ...

> It seems that at least "depth" is missing from the binding document.
You're right.

Actually depth is not a "hardware" caracteristic. Moreover it's just used as an
overlay for pxafb_set_pixfmt() to superseed var->bits_per_pixel. I'm wondering
if the right path for of_get_pxafb_mode_info() would be to remove completely
depth, and leave it initialized at 0 for the DT case.

What do you think of this approach ? The other one would be to modify the
binding, and yet I feel this depth doesn't belong to the binding, it's my patch
which requires another spin IMHO.

Cheers.

-- 
Robert
