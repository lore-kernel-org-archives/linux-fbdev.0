From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 03 Aug 2017 17:09:05 +0000
Subject: Re: [PATCH 0/6] Support for LEGO MINDSTORMS EV3 LCD display
Message-Id: <CAHp75Vdaq0ersEa2_XneUQtsJMj2GCRZL4Wi=1HQorLkb4SaVg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
 <5d8f6518-8d7e-c029-2da4-e3417afb3e40@lechnology.com>
 <28188f5c-1daf-121b-6daf-1899668c3875@tronnes.org>
 <1ce36d43-b9dd-807e-23aa-bac4fda70fdc@lechnology.com>
 <bfb3d541-856b-0233-dd85-72512788939f@tronnes.org>
 <bbec0574-311a-e1b4-d7fd-f6fb15b078d2@lechnology.com>
 <b8ec0511-afd1-2a1b-6ffe-dfe951d79bf7@tronnes.org>
 <cf740449-c952-08d4-d63c-d92e71fa3092@lechnology.com>
In-Reply-To: <cf740449-c952-08d4-d63c-d92e71fa3092@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Lechner <david@lechnology.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, dri-devel@lists.freedesktop.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>

On Thu, Aug 3, 2017 at 6:18 PM, David Lechner <david@lechnology.com> wrote:

> The particular display I have is this one:
> http://wiki.seeed.cc/Grove-OLED_Display_1.12inch/
>
> It looks like it uses a command/data scheme like the MIPI displays, but
> doesn't use any of the standard values for the commands. The controller can
> do parallel, SPI and I2C, but the display I have is wired for I2C.

It looks very similar to ssd1306. Some description refers to ssd1308.

-- 
With Best Regards,
Andy Shevchenko
