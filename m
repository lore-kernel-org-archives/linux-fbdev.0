From: Gabriel C <nix.or.die@googlemail.com>
Subject: Re: [PATCH v2 0/5] uvesafb: a general description
Date: Sat, 30 Jun 2007 22:48:07 +0200
Message-ID: <4686C187.3090308@googlemail.com>
References: <20070630163101.GA3838@spock.one.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753592AbXF3UsX@vger.kernel.org>
In-Reply-To: <20070630163101.GA3838@spock.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: spock@gentoo.org
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, hpa@zytor.com

Michal Januszewski wrote:
> uvesafb is a generic driver for VBE2+ compliant video cards; an enhanced
> version of vesafb and a direct successor of vesafb-tng [1].
>
>   

Hi Michal,

I've just tested uvesafb on my workstation ( which has a really old 
GeForce2 MX 400 Nvidia card ) and it didn't worked here.

If I remember right vesafb-ntg worked here and vesafb works for sure :)

Here the error from dmesg :

....


[   37.397298] uvesafb: Getting VBE info block failed (eax=0x4f00, err=-3)
[   37.397358] uvesafb: vbe_init() failed with -22
[   37.397411] uvesafb: probe of uvesafb.0 failed with error -22


....

Here some infos I got with read-edid[1] tool:


./get-edid: get-edid version 1.4.1

        Performing real mode VBE call
        Interrupt 0x10 ax=0x4f00 bx=0x0 cx=0x0
        Function supported
        Call successful

        VBE version 300
        VBE string at 0x11110 "NVidia"

VBE/DDC service about to be called
        Report DDC capabilities

        Performing real mode VBE call
        Interrupt 0x10 ax=0x4f15 bx=0x0 cx=0x0
        Function supported
        Call successful

        Monitor and video card combination does not support DDC1 transfers
        Monitor and video card combination supports DDC2 transfers
        0 seconds per 128 byte EDID block transfer
        Screen is not blanked during DDC transfer

Reading next EDID block

VBE/DDC service about to be called
        Read EDID

        Performing real mode VBE call
        Interrupt 0x10 ax=0x4f15 bx=0x1 cx=0x0
        Function supported
        Call successful



.....

./parse-edid: parse-edid version 1.4.1
./parse-edid: EDID checksum passed.

        # EDID version 1 revision 3
Section "Monitor"
        # Block type: 2:0 3:ff
        # Block type: 2:0 3:fd
        # Block type: 2:0 3:fc
        Identifier "GD 7000S"
        VendorName "GRC"
        ModelName "GD 7000S"
        # Block type: 2:0 3:ff
        # Block type: 2:0 3:fd
        HorizSync 30-83
        VertRefresh 50-75
        # Max dot clock (video bandwidth) 140 MHz
        # Block type: 2:0 3:fc
        # DPMS capabilities: Active off:yes  Suspend:yes  Standby:yes

        Mode    "1280x1024"     # vfreq 60.013Hz, hfreq 63.974kHz
                DotClock        108.500000
                HTimings        1280 1344 1472 1696
                VTimings        1024 1025 1028 1066
                Flags   "+HSync" "+VSync"
        EndMode
        # Block type: 2:0 3:ff
        # Block type: 2:0 3:fd
        # Block type: 2:0 3:fc
EndSection

...

Let me know if you need more infos.

Regards,

Gabriel C

[1] http://john.fremlin.de/programs/linux/read-edid/


PS: You have an typo on line 702 in the patch from your website 
s/vesafb/uvesafb/ in that printk
