From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: atyfb in 2.5.51
Date: Sun, 22 Dec 2002 14:40:11 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.21.0212221438110.11726-100000@vervain.sonytel.be>
References: <1039775215.25097.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1039775215.25097.5.camel@irongate.swansea.linux.org.uk>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On 13 Dec 2002, Alan Cox wrote:
> On Fri, 2002-12-13 at 08:53, Geert Uytterhoeven wrote:
> > (At first I thought you meant an instruction where the opcode crosses those
> >  two memory types, but we don't put code in video RAM...)
> 
> I did. The frame buffer drivers support mmap(). x86 has no "non-exec"
> bit. So any user able to open /dev/fb can bring down such a box. Similar
> things apply with early athlon and prefetching /dev/fb

Weird... So it really crashes the box, not just throwing an exception?
On PPC you cannot use prefetching on non-cached memory, but if you try it won't
take down the whole box.

Then make sure /dev/fb is accessible by `trusted' users on such machines.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
