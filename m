From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Tue, 26 Oct 2004 18:58:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <417E9E3D.573.3C0CDE1A@localhost>
References: <200410160841.08441.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261514AbUJ0B6W@vger.kernel.org>
In-reply-to: <417E317C.2020703@grupopie.com>
Content-description: Mail message body
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Paulo Marques <pmarques@grupopie.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, penguinppc-team@lists.penguinppc.org, linuxconsole-dev@lists.sourceforge.net

Paulo Marques <pmarques@grupopie.com> wrote:

> Well, I played with the emulator last night to see if I could
> reduce the code size, so that it would be easier to make it to the
> official kernel. 
> 
> I only took ops.c and did some transformations, like using a
> single function to make several operations based on the opcode,
> instead of a separate function for each opcode, etc.[1] 
> 
> This is the result. Before:
> 
> Size of stripped libx86emu.a: ~74kb
> ops.c source code lines: 11682
> ops.o .text size: 36136
> ops.o .data: 1312
> 
> After:
> 
> Size of stripped libx86emu.a: ~57kb
> ops.c source code lines: 5908
> ops.o .text size: 19320
> ops.o .data: 1280
> 
> If the same treatment is applied to ops2.c and prim_ops.c, I
> believe it would be possible to have a functional emulator for
> about 32kb of kernel code size, which seems pretty reasonable to
> me and could solve a lot of problems. 

Wow, that is great!

> The decrease in source code size also helps maintenance, since
> there is not so much repeated code has it was before. 
> 
> Of course, these changes are optimizing the emulator for code
> size, and not execution speed. I haven't done any benchmarks to
> see if there is a noticeable difference in speed. 

Did you get the latest code? I have been sick with the flu and I think I 
forgot to send you the latest code to play with. We should get you set up 
so you can merge your changes into our tree and then we can update the 
one in the X.org tree as well (Egbert Eich usually does that from our 
tree).

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~
