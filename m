From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 13285] New: INTELFB:
 Colors display incorrectly
Date: Tue, 2 Jun 2009 13:18:55 -0700
Message-ID: <20090602131855.1d69f442.akpm@linux-foundation.org>
References: <bug-13285-10286@http.bugzilla.kernel.org/>
	<20090512151934.d7e6c54e.akpm@linux-foundation.org>
	<20090517081743.92002707.krzysztof.h1@poczta.fm>
	<20090516231932.2e02647b.akpm@linux-foundation.org>
	<20090517123032.2b8bad00.krzysztof.h1@poczta.fm>
	<a5d587fb0905170807j4cf60ce7ucf675cc6161e7850@mail.gmail.com>
	<20090530135833.6a2c1bb2.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20090530135833.6a2c1bb2.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: bugzilla-daemon@bugzilla.kernel.org, samanddeanus@yahoo.com, linux-fbdev-devel@lists.sourceforge.net, dri-devel@lists.sourceforge.net, hramrach@centrum.cz

On Sat, 30 May 2009 13:58:33 +0200
Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> The intelfb driver sets color map depending on currently active pipe. However, if an LVDS 
> display is attached (like in laptop) the active pipe variable is never set. The default value is 
> PIPE_A and can be wrong.
> Set up the pipe variable during driver initialization after hardware state was read.
> 
> Also, the detection of the active display (and hence the pipe) is wrong. The pipes are assigned
> to so called planes. Both pipes are always enabled on my laptop but only one plane is enabled
> (the plane A for the CRT or the plane B for the LVDS). Change active pipe detection code
> to take into account a status of the plane assigned to each pipe.
> 
> The problem is visible in the 8 bpp mode if colors above 15 are used. The first 16 color
> entries are displayed correctly.
> 
> The graphics chip description is here (G45 vol. 3):
> http://intellinuxgraphics.org/documentation.html
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> ---
> The second version of the fix to this problem. Now, it is much more sophisticated
> based on the knowledge gained from documentation available at http://intellinuxgraphics.org/.
> 
> It does not change a default behaviour (assumed pipe A) for all cases except the case that only 
> the plane assigned to the pipe B is active. It is enough to fix the issue for me.

I queued this.

> Please test it.

But it would great be Dean and/or Michal were to be able to test it, please.

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
