From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Fri, 14 May 2004 10:51:35 -0700 (PDT)
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <20040514175135.41336.qmail@web14921.mail.yahoo.com>
References: <20040514172011.GA11990@pegasos>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <20040514172011.GA11990@pegasos>
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: James Simmons <jsimmons@infradead.org>, Nicolas Souchu <nsouch@free.fr>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

Just look at this picture and you can see the trend of 2D vs 3D (coprocessor
based) graphics.
http://www.de.tomshardware.com/graphic/20040504/images/architecture.gif
Within one or two generations the 2D box is going to be gone.

If Linux wants to stay current with technology we have to start using the
coprocessor features of the GPU. Most of the benchmarks I have seen show
coprocessor vs programmed at 100:1 speed differential. This is also a
competitive problem, Microsoft and Apple have both decided to go with the GPU
coprocessor this year. 

Lack of free drivers is no reason to ignore the GPU coprocessor. It just means
more effort needs to be put into mesa and prying the docs out of the graphics
chip vendors. If the current open drivers don't work on a non-x86 platform just
go fix them. All of the necessary data is available. Progress is being made with
ATI for getting the R300 specs now that the R400 series has shipped.

--- Sven Luther <sven.luther@wanadoo.fr> wrote:
> As long as this doesn't change, stating that we have an accelerated API
> for OpenGL in linux is not only dead wrong, but is leading us in a
> dangerous direction, where we will depend on a non-free component in the
> kernel and were we are going to forget about graphic support on anything
> non-x86.

I said OpenGL is the only accelerated API available on Linux. Can you name
another? There is a little acceleration in framebuffer, but I don't know of any
others. Also, software mesa works just fine to provide OpenGL on dumb 2D cards.

You have to choose. Either we stay with programmed IO and low speed 2D graphics
forever or we have to embrace the GPU coprocessor. No one is going to make you
buy a high end ATI or Nvidia card. But if you want to use one you have to deal
with the realities of the situation. ATI and Nvidia own their technology and if
they don't want to open it all we can do is complain to them or use their
proprietary drivers. 

If being free is critical to you then you won't be using any high graphics
cards. Stick with an R200 or less type card. Your system will work fine with the
OpenGL based xserver. But graphics cards are evolving and Linux can't ignore
them. We just have to hope that Nvidia and API can see the light someday and
open their specs.

=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
SBC Yahoo! - Internet access at a great low price.
http://promo.yahoo.com/sbc/


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
