From: Ian Romanick <idr@us.ibm.com>
Subject: Re: RE: [Dri-devel] Memory management of AGP and VRAM
Date: Fri, 07 May 2004 14:23:39 -0700
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <409BFE5B.5020308@us.ibm.com>
References: <A98078D7EF5BEA4D8D8FD797FFBBC75F0742A3A0@fmsmsx402.fm.intel.com> <16539.63659.810291.931565@xf11.fra.suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <16539.63659.810291.931565@xf11.fra.suse.de>
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Egbert Eich <eich@pdx.freedesktop.org>
Cc: dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

Egbert Eich wrote:

> However chipset probing/display device probing and mode setting isn't
> required to live in kernel space. Portability and system stability 
> arguments speak against it. In fact only Apple MAC users seem to
> advocate this idea to be able to an initial video mode on their
> systems.

Allow me to speak up for users of IBM pSeries hardware or Sun SPARC 
hardware.  Users of those systems face exactly the same issues as Mac 
users.  I imagine most embedded systems will be in the same boat.  Being 
forced to use a serial console for early boot messages is so 1980's. ;)

The kernel doesn't need to have support for everything, but I think it's 
important to have at least minimal support.




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
