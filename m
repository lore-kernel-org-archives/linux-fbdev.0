From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Tue, 19 Oct 2004 23:11:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20041019211114.GC1142@elf.ucw.cz>
References: <416E6ADC.3007.294DF20D@localhost>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S269863AbUJSVgX@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <416E6ADC.3007.294DF20D@localhost>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, penguinppc-team@lists.penguinppc.org

Hi!

> I am writing this email to guage the interest in having code contributed 
> to the main stream Linux kernel that would support the user of a generic, 
> full featured VESA framebuffer driver that works on any CPU architecture 
> along with a generic Video card BOOT or POST mechanism.

BTW, does this look like right way to POST VGA BIOS from real mode? It
is what we currently use... and it works on some machines...

        movw    $0xb800, %ax
        movw    %ax,%fs
        movw    $0x0e00 + 'L', %fs:(0x10)

        cli
        cld

        # setup data segment
        movw    %cs, %ax
        movw    %ax, %ds                                        # Make ds:0 point to wakeup_start
        movw    %ax, %ss
        mov     $(wakeup_stack - wakeup_code), %sp              # Private stack is needed for ASUS board
        movw    $0x0e00 + 'S', %fs:(0x12)

        pushl   $0                                              # Kill any dangerous flags
        popfl

        movl    real_magic - wakeup_code, %eax
        cmpl    $0x12345678, %eax
        jne     bogus_real_magic

        testl   $1, video_flags - wakeup_code
        jz      1f
        lcall   $0xc000,$3
        movw    %cs, %ax
        movw    %ax, %ds                                        # Bios might have played with that
        movw    %ax, %ss
1:

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
