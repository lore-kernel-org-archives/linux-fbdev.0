From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Tue, 06 Oct 2015 19:13:25 +0000
Subject: Re: [PATCH v2] video: fbdev: add Marvell PXA framebuffer binding
Message-Id: <8737xnbyju.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443954683-13126-1-git-send-email-robert.jarzmik@free.fr>
	<CA+gwMcciuonC5Ektt3wdUcp7RW3E+caCuktYrhcYSqTrnVng9Q@mail.gmail.com>
In-Reply-To: <CA+gwMcciuonC5Ektt3wdUcp7RW3E+caCuktYrhcYSqTrnVng9Q@mail.gmail.com>
	(Philipp Zabel's message of "Tue, 6 Oct 2015 08:58:08 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

Philipp Zabel <philipp.zabel@gmail.com> writes:

> On Sun, Oct 4, 2015 at 12:31 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> +       lcd-controller@40500000 {
>> +               compatible = "marvell,pxa2xx-lcdc";
>> +               reg = <0x44000000 0x10000>;
>> +               interrupts = <17>;
>> +               clocks = <&clks CLK_LCD>;
>> +               interrupts = <23>;
>
> The interrupt line is duplicated in the example.
Indeed, I'll fix that.
>
>> +               status = "okay";
>> +
>> +               port {
>> +                       lcdc_out: endpoint {
>> +                               remote-endpoint = <&panel_in>;
>> +                               bus-width = <16>;
>> +                       };
>> +               };
>> +       };
>> +
>> +PXA LCDC Display
>> +----------------
>> +Required properties (as per of_videomode_helper):
>> + - lcd-type: either "mono-stn", "mono-dstn", "color-stn", "color-dstn",
>> +                   "color-tft", "smart-panel"
>
> Would it make sense to make this property optional and have the
> default be "color-tft"? That is probably the most common one by far.
Yes, sure, let's do it that way for v3.

Cheers.

-- 
Robert
