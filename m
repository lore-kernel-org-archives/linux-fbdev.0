From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Fri, 14 May 2004 19:20:11 +0200
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <20040514172011.GA11990@pegasos>
References: <Pine.LNX.4.44.0405062327050.20402-100000@phoenix.infradead.org> <20040507005040.18258.qmail@web14925.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040507005040.18258.qmail@web14925.mail.yahoo.com>
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
Cc: James Simmons <jsimmons@infradead.org>, Nicolas Souchu <nsouch@free.fr>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Thu, May 06, 2004 at 05:50:40PM -0700, Jon Smirl wrote:
> --- James Simmons <jsimmons@infradead.org> wrote:
> > 2) Ben suggestion that we mount userland inside the kernel during early 
> >    boot and use a userland library. If we would use a library then it MUST 
> >    be OpenGL. This would be the forced standard on all platforms. This 
> >    would mean Mesa would be needed to build the kernel. We could move over 
> >    Mesa into the kernel like zlib is in the tree right now.
> 
> It is not true that it must be OpenGL. The suggestion is for an independent
> library that would support mode setting and cursor control. Actually OpenGL does
> not specify an API for these things, we would need to develop one.
> 
> But broader issues are at work. Microsoft has decided to recode all graphics in
> Longhorn to use Direct3D. This was done to get at the performance gains provided
> by D3D and hardware accelerated graphics. For example a Cairo implementation hat
> uses X rendering vs Cairo on OpenGL was benchmarked at being a 100:1 faster.
> 
> A proposal has been made that OpenGL be promoted as the primary base graphics
> API on Linux. Then things like Cairo and the xserver be implemented on top of
> OpenGL.
> 
> 1) OpenGL is the only fully accelerated API that Linux has. We don't have D3D or
> anything else like it. Fully accelerated interfaces are a pain to build and it
> would stupid to do another one.

Notice that this is not really true, as there is no free OpenGL
acceleration for any of the newer graphic cards coming out right now.
The fastest graphic card with full free acceleration is the radeon 9000,
which is now two generations old. This means that there is no
acceleration outside of the x86 world, since neither ATI nor Nvidia are
ready to build their proprietary drivers on anything else than x86. 

As long as this doesn't change, stating that we have an accelerated API
for OpenGL in linux is not only dead wrong, but is leading us in a
dangerous direction, where we will depend on a non-free component in the
kernel and were we are going to forget about graphic support on anything
non-x86.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
