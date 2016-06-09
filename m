From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 09 Jun 2016 12:25:51 +0000
Subject: [powerpc] offb: red / blue color inversion
Message-Id: <CA+7wUsw+LHgCz6SDHxrbPiwrpN53WB7+KxaAgnVYdwrp4OyVQQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Dear all,

I am trying to fix an issue with color inversion in the current offb.c
implementation. I am using a Mac Mini G4 (PPC) with:

[    0.844144] fb0: Open Firmware frame buffer device on
/pci@f0000000/ATY,RockHopper2Parent@10/ATY,RockHopper2_A@0

reported as [*]. I have tried looking at the upstream code source, and
it appears that my configuration falls into the 'cmap_simple'. But
other than that I failed to understand what could be wrong (palette
would be setup backward).

What are the low level tool (user-space) I can use to try to
understand what is wrong with offb on my machine without rebuilding
the kernel (CONFIG_FB_OF is not a module) ?

Thanks much,



[*] $ fbset -i

mode "800x600-186"
    # D: 100.000 MHz, H: 119.048 kHz, V: 186.012 Hz
    geometry 800 600 800 600 8
    timings 10000 16 16 16 16 8 8
    rgba 8/0,8/0,8/0,0/0
endmode

Frame buffer device information:
    Name        : OFfb ATY,RockHo
    Address     : 0x9c008000
    Size        : 614400
    Type        : PACKED PIXELS
    Visual      : PSEUDOCOLOR
    XPanStep    : 0
    YPanStep    : 0
    YWrapStep   : 0
    LineLength  : 1024
    Accelerator : No
