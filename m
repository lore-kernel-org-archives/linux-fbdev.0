From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Wed, 20 Oct 2004 19:31:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20041020173102.GB19940@elf.ucw.cz>
References: <416E6ADC.3007.294DF20D@localhost> <41763777.27136.1B3B687B@localhost>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268670AbUJTRrk@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <41763777.27136.1B3B687B@localhost>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Hi!

> > BTW, does this look like right way to POST VGA BIOS from real
> > mode? It is what we currently use... and it works on some
> > machines... 
> > 
> >         movw    $0xb800, %ax
> >         movw    %ax,%fs
> >         movw    $0x0e00 + 'L', %fs:(0x10)
> 
> What is this for?

Debugging.

> >         cli
> >         cld
> > 
> >         # setup data segment
> >         movw    %cs, %ax
> >         movw    %ax, %ds                                        # Make ds:0 point to wakeup_start
> >         movw    %ax, %ss
> >         mov     $(wakeup_stack - wakeup_code), %sp              # Private stack is needed for ASUS board
> >         movw    $0x0e00 + 'S', %fs:(0x12)
> 
> We have never needed to set up a private stack. What ASUS board was it 
> that you had problems with and needed to do this for?

This is running at system resume, so it is not normal boot. Some ASUS
Athlon 900MHz machine needed this; I'm no longer using this one.

> >         pushl   $0                                              # Kill any dangerous flags
> >         popfl
> > 
> >         movl    real_magic - wakeup_code, %eax
> >         cmpl    $0x12345678, %eax
> >         jne     bogus_real_magic
> > 
> >         testl   $1, video_flags - wakeup_code
> >         jz      1f
> >         lcall   $0xc000,$3
> 
> The call to 0xC000:0x0003 is the entry point to POST the card. However 
> for PCI cards you need to make sure that AX is loaded with the bus, slot 
> and function for the card that is being POST'ed. It will pass this value 
> to the PCI BIOS Int 0x1A functions in order to find itself, so if this is 
> not set many BIOS'es will not work.

Ok, this one is bad... ... In case of just one vga adapter, we should
be able to store its parameters in some well-known place. For more
than one adapter, we'll definitely need to run BIOS in emulator.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
