From: Josh Myer <jbm@joshisanerd.com>
Subject: Re: Tridentfb updates?
Date: Sat, 23 Nov 2002 14:44:10 -0600 (CST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0211231442190.660-100000@blessed>
References: <Pine.GSO.4.21.0211232133510.20022-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0211232133510.20022-100000@vervain.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Sat, 23 Nov 2002, Geert Uytterhoeven wrote:

> On Fri, 22 Nov 2002, Josh Myer wrote:
> > I've got an EPIA board, with a trident CyberBlade chipset. Does anyone
> > have doco on this chipset? The random Xfree stuff available from VIA is
>
> Is this the Cyber9397? I have some PDF docs about that chip at home.
>
> Gr{oetje,eeting}s,
>
> 						Geert

Unfortunately, it's a CyberBlade i1, which looks to be distinct from that
chip in the driver source i have here.

lspci -vv:
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i1 (rev
6a) (prog-if 00 [VGA])
        Subsystem: Trident Microsystems CyberBlade/i1

--
/jbm, but you can call me Josh. Really, you can!
 "What's a metaphor?" "For sheep to graze in"
7958 1C1C 306A CDF8 4468  3EDE 1F93 F49D 5FA1 49C4
