From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Fri, 14 May 2004 21:31:12 +0200
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <20040514193112.GB27048@pegasos>
References: <20040514172011.GA11990@pegasos> <20040514175135.41336.qmail@web14921.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040514175135.41336.qmail@web14921.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>, James Simmons <jsimmons@infradead.org>, Nicolas Souchu <nsouch@free.fr>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Fri, May 14, 2004 at 10:51:35AM -0700, Jon Smirl wrote:
> Just look at this picture and you can see the trend of 2D vs 3D (coprocessor
> based) graphics.
> http://www.de.tomshardware.com/graphic/20040504/images/architecture.gif
> Within one or two generations the 2D box is going to be gone.

Sorry, but i am not able to see this over the remote link i am having
now, i will look at it more in detail when i am back home on sunday.

> If Linux wants to stay current with technology we have to start using the
> coprocessor features of the GPU. Most of the benchmarks I have seen show
> coprocessor vs programmed at 100:1 speed differential. This is also a
> competitive problem, Microsoft and Apple have both decided to go with the GPU
> coprocessor this year. 

Fine with me, i believe that this is also the way to go, but saddly
this is probably not going to happen unless we put some pressure on the
graphic companies, and i somehow doubt that nvidia will go with it. I
only wanted to raise the problematic, so we don forget about where we
come from, and create a framework which would depend on non-free parts.

> Lack of free drivers is no reason to ignore the GPU coprocessor. It just means

Well, it probably means nonaccelerated drivers, if even that.

> more effort needs to be put into mesa and prying the docs out of the graphics
> chip vendors. If the current open drivers don't work on a non-x86 platform just
> go fix them. All of the necessary data is available. Progress is being made with
> ATI for getting the R300 specs now that the R400 series has shipped.
> 

If this is true, then it would be a great new, but still, if you want to
go forward with this plan, we have to get at least a partial
functionality open source drm/fbdev module for even the newer model of
graphic cards, and even from players like nvidia. They can hide all
their stuff in proprietary userland libraries afterward still, but the
right thing would be to have this integrated kernel driver be a real
GPLed driver, with source and all.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
