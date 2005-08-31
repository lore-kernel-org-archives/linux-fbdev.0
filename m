From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
Date: Wed, 31 Aug 2005 14:42:36 +0800
Message-ID: <4315515C.1040208@gmail.com>
References: <43148610.70406@t-online.de> <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be> <43149E5B.7040006@t-online.de> <Pine.LNX.4.61.0508302039160.3743@scrub.home> <4314DD2E.7060901@t-online.de> <Pine.LNX.4.61.0508310159290.3728@scrub.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932400AbVHaGnF@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0508310159290.3728@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Knut Petersen <Knut_Petersen@t-online.de>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Jochen Hein <jochen@jochen.org>

Roman Zippel wrote:
> Hi,
> 
> On Wed, 31 Aug 2005, Knut Petersen wrote:
> 
>> How could I make it an inline function? It is used in console/bitblit.c,
>> nvidia/nvidia.c,
>> riva/fbdev.c and softcursor.c.
> 
> Something like below, which has the advantange that there is still only 
> one implementation of the function and if it's still slower, we really 
> need to check the compiler.
> 

I do get better numbers with this, not much, but better than Knut's (5ms), and
definitely much better than the old uninlined one (100ms).

Andrew, don't get this yet.  I'll incorporate this with the bit_putcs()
breakup that I'm currently doing.

Roman, okay if you have a 'Signed-off-by' line?

Tony
