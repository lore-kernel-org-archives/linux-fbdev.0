From: Antonino Daplas <adaplas@pol.net>
Subject: Re: LCD scaling type
Date: 11 Jan 2003 21:27:35 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042291653.1389.88.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0301111428410.18570-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XLpa-0004N6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Jan 2003 05:37:46 -0800
In-Reply-To: <Pine.GSO.4.21.0301111428410.18570-100000@vervain.sonytel.be>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2003-01-11 at 21:29, Geert Uytterhoeven wrote:
> On 11 Jan 2003, Antonino Daplas wrote:
> > I also have a couple of things that come to mind (like switching from
> > truecolor to directcolor and vice versa without rebooting).  I currently
> > use var->nonstd which is probably not the the right thing to do.
> 
> Since directcolor is a superset of truecolor, shouldn't a driver always use
> directcolor, if the hardware supports it?
> 
Some apps don't know how to treat directcolor.  DirectFB-0.9.15 is
messed up when visual is in directcolor, so I need truecolor here. I
submitted a patch to them so it should get fixed with their next
release.

However, when I go to X, I want it to be in directcolor, for gamma
utilities to work 

Tony




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
