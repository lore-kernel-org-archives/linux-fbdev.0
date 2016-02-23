From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 Feb 2016 10:10:33 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <3695074.sKSIyOjpjD@wuerfel>
In-Reply-To: <3695074.sKSIyOjpjD@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 23, 2016 at 10:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 23 February 2016 10:08:05 Linus Walleij wrote:
>> I will think of a better solution, if any, for this for v4.6, but will
>> put forward something that handles the Nomadik and all the
>> other ARM reference designs for now.
>>
>
> How about still describing all known panels in the DT marked 'status="disabled"',
> but then having a minimal piece of board specific code that just enables
> whichever one gets detected at boot time?

Close but no cigar :D

It means that all panels (enabled and all disabled) have to have the same
endpoint in the of_graph.

I tried it:

    panel@0 {
        compatible = "panel-dpi";
        port {
            clcd_panel: endpoint {
                remote-endpoint = <&clcd_pads>;
            };
        };
(...)

    panel@1 {
        compatible = "panel-dpi";
        port {
            clcd_panel: endpoint {
                remote-endpoint = <&clcd_pads>;
            };
        };
(...)


        display@10120000 {
(...)
            port {
(...)
                clcd_pads: endpoint@0 {
                    reg = <0>;
                    remote-endpoint = <&clcd_panel>;
                    arm,pl11x,tft-r0g0b0-pads = <1 7 13>;
                };
            };



Building the device tree:

ERROR (duplicate_label): ERROR (duplicate_label): Duplicate label
'clcd_panel' on /panel@1/port/endpoint and /panel@0/port/endpoint
Duplicate label 'clcd_panel' on /panel@1/port/endpoint and
/panel@0/port/endpoint

So the dtc does not allow duplicate node labels for the phandle
even if the node it resides in is disabled. Tough luck...

Yours,
Linus Walleij
