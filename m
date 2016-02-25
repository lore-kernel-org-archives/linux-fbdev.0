From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 25 Feb 2016 19:30:35 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <CACRpkdYowXJinONTd2qREfCtEDCon+HSQtdd6t1QQA91f6PJdw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
 <6859810.tb1t0IEONi@wuerfel> <56CC57FC.20707@ti.com>
 <CACRpkdYNaNtQQJ-tsBe5ksa4-z380ZQj-zN8ZnK0ED2kNPUwvg@mail.gmail.com>
 <56CC60C4.6040908@ti.com>
 <CACRpkdZd8TLdsi7_cOrqzcqWKJrfdp4Vz2sx5ozpwJXOj0fa+Q@mail.gmail.com>
 <56CF2FB1.106@ti.com>
In-Reply-To: <56CF2FB1.106@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Feb 25, 2016 at 5:45 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 25/02/16 16:04, Linus Walleij wrote:

>> *All* the others
>> will be very happy with *ONE* display defined as panel in the
>> device tree, and off they go. Usually VGA. And that will look
>
> You keep mentioning VGA. So is there are VGA output? Or do you just mean
> MIPI DPI panels, which happen to take the same video timings as VGA?

Russell beat me to it, yes there is an external VGA encoder.
It needs some bits set up through the "misc registers" system
controller as indicated. From the CLCD hardware point of view
it's no different than any other panel. So the DTS fragment looks
like so:

                        panel {
                                compatible = "panel-dpi";

                                port {
                                        clcd_panel: endpoint {
                                                remote-endpoint = <&clcd_pads>;
                                        };
                                };

                                /* Standard 640x480 VGA timings */
                                panel-timing {
                                        clock-frequency = <25175000>;
                                        hactive = <640>;
                                        hback-porch = <48>;
                                        hfront-porch = <16>;
                                        hsync-len = <96>;
                                        vactive = <480>;
                                        vback-porch = <33>;
                                        vfront-porch = <10>;
                                        vsync-len = <2>;
                                };
                        };


This is reported as the default display type if no LCD panel
is connected.

If a LCD panel is also connected, it take precedence.

Yours,
Linus Walleij
