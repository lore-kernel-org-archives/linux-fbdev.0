From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: atyfb in 2.5.51
Date: 13 Dec 2002 10:26:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1039775215.25097.5.camel@irongate.swansea.linux.org.uk>
References: <Pine.GSO.4.21.0212130949450.6939-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0212130949450.6939-100000@vervain.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David S. Miller" <davem@redhat.com>, James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2002-12-13 at 08:53, Geert Uytterhoeven wrote:
> (At first I thought you meant an instruction where the opcode crosses those
>  two memory types, but we don't put code in video RAM...)

I did. The frame buffer drivers support mmap(). x86 has no "non-exec"
bit. So any user able to open /dev/fb can bring down such a box. Similar
things apply with early athlon and prefetching /dev/fb
