From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Re: FBdev updates.
Date: 21 Feb 2003 18:46:44 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1045824362.1202.4.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0302211007080.9232-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18mAgt-0004iG-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 21 Feb 2003 02:46:04 -0800
In-Reply-To: <Pine.GSO.4.21.0302211007080.9232-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Petr Vandrovec <vandrove@vc.cvut.cz>, Dave Jones <davej@codemonkey.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2003-02-21 at 17:09, Geert Uytterhoeven wrote:
> On 21 Feb 2003, Antonino Daplas wrote:
> > Note: I cannot test with 12x22 fonts in 2.4 because some/most drivers do
> > not support it.
> 
> Which specific drivers are you talking about? All drivers for popular cards
> support fontwidth 12 (Matrox, ATI, nVidia, 3Dfx, Permedia, VESA, ...).
> 
>
You're absolutely correct, I'm wondering why I thought that :-)  Here's
a benchmark for 12x22, and it's 2x slower than 8x16, 2.4.x or 2.5.x. 
Still, the 2.5.x version is slower than 2.4.x.

Tony

no accel
scrollmode: yredraw
font: 12x22
visual: packed pixels

time cat /usr/src/linux/MAINTAINERS

linux 2.4.20

bpp8
----
real    0m4.984s
user    0m0.000s
sys     0m4.940s

bpp16
-----
real    0m9.188s
user    0m0.000s
sys     0m9.090s

bpp24
-----
real    0m14.574s
user    0m0.000s
sys     0m14.380s

bpp32
-----
real    0m18.578s
user    0m0.000s
sys     0m18.390s

linux-2.5.62

bpp8
----
real    0m5.247s
user    0m0.001s
sys     0m5.245s

bpp16
-----
real    0m9.640s
user    0m0.001s
sys     0m9.591s

bpp24
-----
real    0m15.943s
user    0m0.001s
sys     0m15.944s

bpp32
-----
real    0m19.653s
user    0m0.002s
sys     0m19.651s




-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
