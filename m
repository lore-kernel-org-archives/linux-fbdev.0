From: Paulo Marques <pmarques@grupopie.com>
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video
 card BOOT?
Date: Wed, 27 Oct 2004 12:11:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <417F8269.2070307@grupopie.com>
References: <200410160841.08441.adaplas@hotpop.com> <417E9E3D.573.3C0CDE1A@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262375AbUJ0LMP@vger.kernel.org>
In-Reply-To: <417E9E3D.573.3C0CDE1A@localhost>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, penguinppc-team@lists.penguinppc.org, linuxconsole-dev@lists.sourceforge.net

Kendall Bennett wrote:
> Paulo Marques <pmarques@grupopie.com> wrote:
> .....
>>If the same treatment is applied to ops2.c and prim_ops.c, I
>>believe it would be possible to have a functional emulator for
>>about 32kb of kernel code size, which seems pretty reasonable to
>>me and could solve a lot of problems. 
> 
> 
> Wow, that is great!

Thanks :)

> 
>>The decrease in source code size also helps maintenance, since
>>there is not so much repeated code has it was before. 
>>
>>Of course, these changes are optimizing the emulator for code
>>size, and not execution speed. I haven't done any benchmarks to
>>see if there is a noticeable difference in speed. 
> 
> 
> Did you get the latest code? I have been sick with the flu and I think I 
> forgot to send you the latest code to play with. We should get you set up 
> so you can merge your changes into our tree and then we can update the 
> one in the X.org tree as well (Egbert Eich usually does that from our 
> tree).

No, I didn't get the latest source (you did disapear for a while :) ).

I started to work on the old source because:

  A - I really wanted to know if this could be done and what kind of 
improvements could be expected, even if the actual changes were thrown 
away in the end

  B - you said that only small bug fixes were made since this version, 
so I probably could diff the source I started from against the latest 
and do the same fixes to my latest source.

One other thing, is there a simple way to test the emulator? I've been 
careful with the changes I did not to change the resulting behaviour of 
the emulator, but I can not _absolutely_ sure that I didn't break 
anything. It would be very good to try the emulator in a controlled 
environment.

Anyway, I think I'll have some more time tonight, so probably tomorrow 
I'll have more information about the final code size.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
