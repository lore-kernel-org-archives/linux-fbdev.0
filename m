From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: atyfb in 2.5.51
Date: Fri, 13 Dec 2002 09:53:04 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.21.0212130949450.6939-100000@vervain.sonytel.be>
References: <1039642510.18467.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1039642510.18467.40.camel@irongate.swansea.linux.org.uk>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On 11 Dec 2002, Alan Cox wrote:
> On Wed, 2002-12-11 at 20:43, David S. Miller wrote:
> > fbdev is nice, in the specific cases where the device fits the fbdev
> > model, because once you have the kernel bits you have X support :)
> 
> fbdev also can't be used in some situations on x86. Deeply fascinating
> things happen on some x86 processors if you execute a loop of code with
> an instruction that crosses two different memory types.

Do you mean one load/store access to memory where the first and the last part
(e.g. first 2 and last 2 bytes for a 32-bit word) are to different memory types
(e.g. main RAM and video RAM on PCI)? If yes, where does that happen? If no,
can you please clarify?

(At first I thought you meant an instruction where the opcode crosses those
 two memory types, but we don't put code in video RAM...)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
