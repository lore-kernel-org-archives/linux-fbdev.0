From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Bugme-new] [Bug 13285] New: INTELFB:
 Colors display incorrectly
Date: Sat, 16 May 2009 20:42:05 +0200
Message-ID: <20090516204205.e91398b7.krzysztof.h1@poczta.fm>
References: <bug-13285-10286@http.bugzilla.kernel.org/>
	<20090512151934.d7e6c54e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20090512151934.d7e6c54e.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net, bugzilla-daemon@bugzilla.kernel.org, samanddeanus@yahoo.com

On Tue, 12 May 2009 15:19:34 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> 
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
> 
> On Tue, 12 May 2009 01:40:48 GMT
> bugzilla-daemon@bugzilla.kernel.org wrote:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=13285
> > 
> >            Summary: INTELFB: Colors display incorrectly
> >            Product: Drivers
> >            Version: 2.5
> >     Kernel Version: 2.6.30-rc5
> 
> This is a post-2.6.29 regression.
> 
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: Console/Framebuffers
> >         AssignedTo: jsimmons@infradead.org
> >         ReportedBy: samanddeanus@yahoo.com
> >         Regression: Yes
> > 
> > 
> > On my system, the colors are displaying incorrectly when using the Intel
> > framebuffer.  For example the Tux penguin logo has a blue background, and when
> > I start X11 with the fbdev drivers, the xterm also has a blue background, when
> > it is set up to have a white background.
> > 
> > This does not occur in kernel 2.6.29 -- I can see the Tasmanian devil in a
> > penguin mask (Tuz) just fine and can view images, etc on the framebuffer.
> > 
> 

I have reproduced the bug on Intel 852/855 chipset (Asus A3L laptop). 

It took me long because I had problems with a hard drive and had to wipe it with a low-level format tool.

I am trying to identify cause of the bug. 

Regards,
Krzysztof

----------------------------------------------------------------------
Fantastyczne nagrody do zgarniecia!
Zagraj >> http://link.interia.pl/f2177 



------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
