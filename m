From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Wed, 20 Oct 2004 10:01:27 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <41763777.27136.1B3B687B@localhost>
References: <416E6ADC.3007.294DF20D@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKJqI-0000Ja-Iz
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 20 Oct 2004 10:01:42 -0700
Received: from mail.scitechsoft.com ([63.195.13.67])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CKJqI-0008S7-3h
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 20 Oct 2004 10:01:42 -0700
In-reply-to: <20041019211114.GC1142@elf.ucw.cz>
Content-description: Mail message body
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Pavel Machek <pavel@ucw.cz> wrote:

> BTW, does this look like right way to POST VGA BIOS from real
> mode? It is what we currently use... and it works on some
> machines... 
> 
>         movw    $0xb800, %ax
>         movw    %ax,%fs
>         movw    $0x0e00 + 'L', %fs:(0x10)

What is this for?

>         cli
>         cld
> 
>         # setup data segment
>         movw    %cs, %ax
>         movw    %ax, %ds                                        # Make ds:0 point to wakeup_start
>         movw    %ax, %ss
>         mov     $(wakeup_stack - wakeup_code), %sp              # Private stack is needed for ASUS board
>         movw    $0x0e00 + 'S', %fs:(0x12)

We have never needed to set up a private stack. What ASUS board was it 
that you had problems with and needed to do this for?

>         pushl   $0                                              # Kill any dangerous flags
>         popfl
> 
>         movl    real_magic - wakeup_code, %eax
>         cmpl    $0x12345678, %eax
>         jne     bogus_real_magic
> 
>         testl   $1, video_flags - wakeup_code
>         jz      1f
>         lcall   $0xc000,$3

The call to 0xC000:0x0003 is the entry point to POST the card. However 
for PCI cards you need to make sure that AX is loaded with the bus, slot 
and function for the card that is being POST'ed. It will pass this value 
to the PCI BIOS Int 0x1A functions in order to find itself, so if this is 
not set many BIOS'es will not work.

The rest of the code you have above seems superfluous to me as we have 
never needed to do that. Then again we boot the card using the BIOS 
emulator, which is different because it runs within a protected machine 
state.

Have you taken a look at the X.org code? They have code in there to POST 
the video card also (either using vm86() or the BIOS emulator).

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
