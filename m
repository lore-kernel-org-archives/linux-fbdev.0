From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: FBdev updates.
Date: Wed, 5 Mar 2003 20:22:26 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303052015250.27760-100000@phoenix.infradead.org>
References: <20030303203500.GA2916@vana.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qfPq-0004Ns-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 12:23:03 -0800
In-Reply-To: <20030303203500.GA2916@vana.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Hi,
>   while waiting on these updates I updated matroxfb a bit
> (ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.5.63.gz),
> so that it now uses fb_* for cfb modes, and putcs/... hooks for
> text mode. I have still dozen of changes in fbcon.c which I have
> to eliminate (mainly logo painting and cursor handling - for now
> I still use revc method, mainly because of I did not make into it yet).

I grabbed your latest patch and started to merge it with my latest work on 
the matrox driver. As soon as I'm done merging my matrox changes I will 
send you a patch right away.

>   My main concern now is 12x22 font... Accelerator setup
> is so costly for each separate painted character that for 8bpp 
> accelerated version is even slower than unaccelerated one :-(
> (and almost twice as slow when compared with 2.4.x).

Try the latest patch I released.
 
>   And one (or two...) generic questions: why is not pseudo_palette
> u32* pseudo_palette, or even directly u32 pseudo_palette[17] ?

pseudo_palette was originally designed to be a pointer to some kind of 
data for color register programming. For example many PPC graphics cards 
have a color register region. Now you could have that point to 
pseudo_palette.  Note pseudo_palette is only visiable in fbmem.c for the 
logo drawing code. Personally I liek to see that hidden.

> And why we do not fill this pseudo_palette with
> i * 0x01010101U for 8bpp pseudocolor and i * 0x11111111U for 4bpp
> pseudocolor? This allowed me to remove couple of switches and tests
> from acceleration fastpaths (and from cfb_imageblit and cfb_fillrect,
> but I did not changed these two in my benchmarks below).

??? Does your accel engine require these kinds of values?




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
