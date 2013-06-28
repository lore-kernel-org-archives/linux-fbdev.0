From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Fri, 28 Jun 2013 14:11:22 +0000
Subject: Re: pmag-aa-fb
Message-Id: <alpine.LFD.2.03.1306281507480.11253@linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMuHMdUfXUJTZ3fjMPicE1Z9D1mT4h-OzCfmCwBtppcK-3z01g@mail.gmail.com>
In-Reply-To: <CAMuHMdUfXUJTZ3fjMPicE1Z9D1mT4h-OzCfmCwBtppcK-3z01g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On Wed, 26 Jun 2013, Geert Uytterhoeven wrote:

> While investigating the users of (now static) fb_display, I noticed
> the DECstation
> PMAG AA frame buffer driver suffers from serious bit rot:
> 
> drivers/video/pmag-aa-fb.c:38:24: error: asm/dec/tc.h: No such file or directory
> drivers/video/pmag-aa-fb.c:40:25: error: video/fbcon.h: No such file
> or directory
> drivers/video/pmag-aa-fb.c:41:30: error: video/fbcon-cfb8.h: No such
> file or directory
> drivers/video/pmag-aa-fb.c:86: error: field ‘disp’ has incomplete type
> drivers/video/pmag-aa-fb.c: In function ‘aafbcon_cursor’:
> drivers/video/pmag-aa-fb.c:118: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:121: error: implicit declaration of
> function ‘fontwidth’
> drivers/video/pmag-aa-fb.c:122: error: implicit declaration of
> function ‘fontheight’
> drivers/video/pmag-aa-fb.c:130: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:131: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c: In function ‘aafbcon_set_font’:
> drivers/video/pmag-aa-fb.c:150: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:152: error: implicit declaration of
> function ‘attr_bgcol_ec’
> drivers/video/pmag-aa-fb.c:152: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c: At top level:
> drivers/video/pmag-aa-fb.c:208: error: variable ‘aafb_switch8’ has
> initializer but incomplete type
> drivers/video/pmag-aa-fb.c:209: error: unknown field ‘setup’ specified
> in initializer
> drivers/video/pmag-aa-fb.c:209: error: ‘fbcon_cfb8_setup’ undeclared
> here (not in a function)
> drivers/video/pmag-aa-fb.c:209: warning: excess elements in struct initializer
> drivers/video/pmag-aa-fb.c:209: warning: (near initialization for
> ‘aafb_switch8’)
> drivers/video/pmag-aa-fb.c:210: error: unknown field ‘bmove’ specified
> in initializer
> drivers/video/pmag-aa-fb.c:210: error: ‘fbcon_cfb8_bmove’ undeclared
> here (not in a function)
> drivers/video/pmag-aa-fb.c:210: warning: excess elements in struct initializer
> drivers/video/pmag-aa-fb.c:210: warning: (near initialization for
> ‘aafb_switch8’)
> drivers/video/pmag-aa-fb.c:211: error: unknown field ‘clear’ specified
> in initializer
> drivers/video/pmag-aa-fb.c:211: error: ‘fbcon_cfb8_clear’ undeclared
> here (not in a function)
> drivers/video/pmag-aa-fb.c:211: warning: excess elements in struct initializer
> drivers/video/pmag-aa-fb.c:211: warning: (near initialization for
> ‘aafb_switch8’)
> drivers/video/pmag-aa-fb.c:212: error: unknown field ‘putc’ specified
> in initializer
> drivers/video/pmag-aa-fb.c:212: error: ‘fbcon_cfb8_putc’ undeclared
> here (not in a function)
> drivers/video/pmag-aa-fb.c:212: warning: excess elements in struct initializer
> drivers/video/pmag-aa-fb.c:212: warning: (near initialization for
> ‘aafb_switch8’)
> drivers/video/pmag-aa-fb.c:213: error: unknown field ‘putcs’ specified
> in initializer
> drivers/video/pmag-aa-fb.c:213: error: ‘fbcon_cfb8_putcs’ undeclared
> here (not in a function)
> drivers/video/pmag-aa-fb.c:213: warning: excess elements in struct initializer
> drivers/video/pmag-aa-fb.c:213: warning: (near initialization for
> ‘aafb_switch8’)
> drivers/video/pmag-aa-fb.c:214: error: unknown field ‘revc’ specified
> in initializer
> drivers/video/pmag-aa-fb.c:214: error: ‘fbcon_cfb8_revc’ undeclared
> here (not in a function)
> drivers/video/pmag-aa-fb.c:214: warning: excess elements in struct initializer
> drivers/video/pmag-aa-fb.c:214: warning: (near initialization for
> ‘aafb_switch8’)
> drivers/video/pmag-aa-fb.c:215: error: unknown field ‘cursor’
> specified in initializer
> drivers/video/pmag-aa-fb.c:215: warning: excess elements in struct initializer
> drivers/video/pmag-aa-fb.c:215: warning: (near initialization for
> ‘aafb_switch8’)
> drivers/video/pmag-aa-fb.c:216: error: unknown field ‘set_font’
> specified in initializer
> drivers/video/pmag-aa-fb.c:216: warning: excess elements in struct initializer
> drivers/video/pmag-aa-fb.c:216: warning: (near initialization for
> ‘aafb_switch8’)
> drivers/video/pmag-aa-fb.c:217: error: unknown field ‘clear_margins’
> specified in initializer
> drivers/video/pmag-aa-fb.c:217: error: ‘fbcon_cfb8_clear_margins’
> undeclared here (not in a function)
> drivers/video/pmag-aa-fb.c:217: warning: excess elements in struct initializer
> drivers/video/pmag-aa-fb.c:217: warning: (near initialization for
> ‘aafb_switch8’)
> drivers/video/pmag-aa-fb.c:218: error: unknown field ‘fontwidthmask’
> specified in initializer
> drivers/video/pmag-aa-fb.c:218: error: implicit declaration of
> function ‘FONTWIDTH’
> drivers/video/pmag-aa-fb.c:219: warning: excess elements in struct initializer
> drivers/video/pmag-aa-fb.c:219: warning: (near initialization for
> ‘aafb_switch8’)
> drivers/video/pmag-aa-fb.c: In function ‘aafb_set_disp’:
> drivers/video/pmag-aa-fb.c:250: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:251: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:252: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:252: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:252: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:253: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:253: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:254: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:255: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:258: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:259: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:260: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:261: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:262: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:263: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:264: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:265: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:266: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:267: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:268: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:268: error: ‘SCROLL_YREDRAW’ undeclared
> (first use in this function)
> drivers/video/pmag-aa-fb.c:268: error: (Each undeclared identifier is
> reported only once
> drivers/video/pmag-aa-fb.c:268: error: for each function it appears in.)
> drivers/video/pmag-aa-fb.c: In function ‘aafb_get_cmap’:
> drivers/video/pmag-aa-fb.c:279: error: too many arguments to function
> ‘fb_copy_cmap’
> drivers/video/pmag-aa-fb.c: In function ‘aafb_switch’:
> drivers/video/pmag-aa-fb.c:308: error: ‘fb_display’ undeclared (first
> use in this function)
> drivers/video/pmag-aa-fb.c:311: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:311: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:311: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:312: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c:312: error: dereferencing pointer to incomplete type
> drivers/video/pmag-aa-fb.c: In function ‘aafb_update_var’:
> drivers/video/pmag-aa-fb.c:381: error: ‘fb_display’ undeclared (first
> use in this function)
> drivers/video/pmag-aa-fb.c: At top level:
> drivers/video/pmag-aa-fb.c:402: error: unknown field ‘fb_get_fix’
> specified in initializer
> drivers/video/pmag-aa-fb.c:402: warning: initialization from
> incompatible pointer type
> drivers/video/pmag-aa-fb.c:403: error: unknown field ‘fb_get_var’
> specified in initializer
> drivers/video/pmag-aa-fb.c:403: warning: initialization from
> incompatible pointer type
> drivers/video/pmag-aa-fb.c:404: error: unknown field ‘fb_set_var’
> specified in initializer
> drivers/video/pmag-aa-fb.c:404: warning: initialization from
> incompatible pointer type
> drivers/video/pmag-aa-fb.c:405: error: unknown field ‘fb_get_cmap’
> specified in initializer
> drivers/video/pmag-aa-fb.c:405: warning: initialization from
> incompatible pointer type
> drivers/video/pmag-aa-fb.c:406: error: unknown field ‘fb_set_cmap’
> specified in initializer
> drivers/video/pmag-aa-fb.c:406: warning: initialization from
> incompatible pointer type
> drivers/video/pmag-aa-fb.c: In function ‘init_one’:
> drivers/video/pmag-aa-fb.c:412: error: implicit declaration of
> function ‘get_tc_base_addr’
> drivers/video/pmag-aa-fb.c:430: error: ‘struct fb_info’ has no member
> named ‘modename’
> drivers/video/pmag-aa-fb.c:434: error: ‘struct fb_info’ has no member
> named ‘disp’
> drivers/video/pmag-aa-fb.c:435: error: ‘struct fb_info’ has no member
> named ‘changevar’
> drivers/video/pmag-aa-fb.c:436: error: ‘struct fb_info’ has no member
> named ‘switch_con’
> drivers/video/pmag-aa-fb.c:437: error: ‘struct fb_info’ has no member
> named ‘updatevar’
> drivers/video/pmag-aa-fb.c:438: error: ‘struct fb_info’ has no member
> named ‘blank’
> drivers/video/pmag-aa-fb.c:462: error: implicit declaration of
> function ‘GET_FB_IDX’
> drivers/video/pmag-aa-fb.c:462: error: ‘struct fb_info’ has no member
> named ‘modename’
> drivers/video/pmag-aa-fb.c: In function ‘pmagaafb_init’:
> drivers/video/pmag-aa-fb.c:485: error: implicit declaration of
> function ‘search_tc_card’
> drivers/video/pmag-aa-fb.c:487: error: implicit declaration of
> function ‘claim_tc_card’
> drivers/video/pmag-aa-fb.c: In function ‘pmagaafb_exit’:
> drivers/video/pmag-aa-fb.c:500: error: implicit declaration of
> function ‘release_tc_card’
> 
> search_tc_card() was removed in in 2007 in commit
> b454cc6636d254fbf6049b73e9560aee76fb04a3 ("[TC] MIPS: TURBOchannel
> update to the driver model").
> 
> include/video/fbcon.h was moved to drivers/video/console/fbcon.h in ... 2002.
> 
> Anyone who cares to resurrect it? If not, we should just remove it.

 I'll have a look, thanks for the heads-up.  Not a card I usually use -- I 
wonder if I've got a patch somewhere that I forgot to post while rewriting 
TURBOchannel support though.

  Maciej
