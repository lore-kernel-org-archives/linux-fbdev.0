From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 13285] New: INTELFB: Colors display incorrectly
Date: Tue, 12 May 2009 15:19:34 -0700
Message-ID: <20090512151934.d7e6c54e.akpm@linux-foundation.org>
References: <bug-13285-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.sourceforge.net>
In-Reply-To: <bug-13285-10286@http.bugzilla.kernel.org/>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=dri-devel>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: dri-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net, dri-devel@lists.sourceforge.net
Cc: samanddeanus@yahoo.com, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Tue, 12 May 2009 01:40:48 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=13285
> 
>            Summary: INTELFB: Colors display incorrectly
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 2.6.30-rc5

This is a post-2.6.29 regression.

>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Console/Framebuffers
>         AssignedTo: jsimmons@infradead.org
>         ReportedBy: samanddeanus@yahoo.com
>         Regression: Yes
> 
> 
> On my system, the colors are displaying incorrectly when using the Intel
> framebuffer.  For example the Tux penguin logo has a blue background, and when
> I start X11 with the fbdev drivers, the xterm also has a blue background, when
> it is set up to have a white background.
> 
> This does not occur in kernel 2.6.29 -- I can see the Tasmanian devil in a
> penguin mask (Tuz) just fine and can view images, etc on the framebuffer.
> 

The only change to drivers/video/intelfb/ since 2.6.29 was
347486bb108fa6e0fd2753c1be3519d6be2516ed ("intelfb: support i854")
which added a device ID.

Do we think that this regression is due to fbdev changes, or to DRI
changes?

Thanks.

------------------------------------------------------------------------------
The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
production scanning environment may not be a perfect world - but thanks to
Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
Series Scanner you'll get full speed at 300 dpi even with all image 
processing features enabled. http://p.sf.net/sfu/kodak-com
--
