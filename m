From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Fri, 14 May 2004 21:25:03 +0200
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <20040514192503.GA27048@pegasos>
References: <20040514172011.GA11990@pegasos> <20040514173556.5782.qmail@web50101.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040514173556.5782.qmail@web50101.mail.yahoo.com>
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
To: Alex Deucher <agd5f@yahoo.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Jon Smirl <jonsmirl@yahoo.com>, James Simmons <jsimmons@infradead.org>, Nicolas Souchu <nsouch@free.fr>, dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Fri, May 14, 2004 at 10:35:56AM -0700, Alex Deucher wrote:
> > Notice that this is not really true, as there is no free OpenGL
> > acceleration for any of the newer graphic cards coming out right now.
> > The fastest graphic card with full free acceleration is the radeon
> > 9000,
> > which is now two generations old. This means that there is no
> > acceleration outside of the x86 world, since neither ATI nor Nvidia
> > are
> > ready to build their proprietary drivers on anything else than x86. 
> > 
> 
> There is the possiblity that graphics vendors may provide an open
> source DRM and mode setting code and then closed source 3D libraries. 
> this would at least allow you to at least get something on the screen. 

Yes, that would be greatm but i have the feeling that they even see the
dma buffer handling stuff as highly proprietary or something such.

> > As long as this doesn't change, stating that we have an accelerated
> > API
> > for OpenGL in linux is not only dead wrong, but is leading us in a
> > dangerous direction, where we will depend on a non-free component in
> > the
> > kernel and were we are going to forget about graphic support on
> > anything
> > non-x86.
> 
> well what should we do then?  ignore graphics on linux since most

Well, what to do is a difficult thing, but the least we can do is not
handle this as if everything is all right, and let declaration as the
above pass without notice. Technically, it can even be argued that the
binary-only drm modules are breaking the GPL, altough i know that Linus
and the rest of the kernel crowd have decided not to pursue this.

So, pursue this issue as we are doing it, but clearly stating that the
current situation without free low level drivers is not acceptable to
us. I believe that we are now in a position to put some pressure to at
least some of the graphic companies to release at least a partial
integrated drm/fbdev module as free software, but this will not happen
if we don push for it. (But then, i have a vested interest in this,
since my main plateform is powerpc, both personally and proffesionnaly).

> future graphics chips drivers closed source?  keep the same kludgey
> xfree86 solution?  We can still provide a solution for non-x86 or chips
> without 3D, it will just have to be software based (or marginally
> accelerated using 2d). why re-invent openGL when we already have it? 
> If we can provide a good system for graphics on linux perhaps more
> vendors will use it.

Yes, but only if we don forget about non-x86 architectures, and don't
conform us with a proprietary solution. Remember that many folk build
the fbdev driver in the kernel to have early fbdev console, and this
will not be possible with a x86 binary only module.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
