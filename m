From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: Re: rotation.
Date: Wed, 8 Jan 2003 13:55:30 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030108125530.GC11138@iliana>
References: <yw1xu1gj51ep.fsf@tiptop.e.kth.se> <200301081205.h08C5mPv000776@darkstar.example.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233] helo=mel-rto3.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WFl9-0001CJ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 08 Jan 2003 04:56:39 -0800
Content-Disposition: inline
In-Reply-To: <200301081205.h08C5mPv000776@darkstar.example.net>
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
Content-Transfer-Encoding: 7bit
To: John Bradford <john@grabjohn.com>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>, luther@dpt-info.u-strasbg.fr, geert@linux-m68k.org, jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 12:05:48PM +0000, John Bradford wrote:
> > > > > I'm about to implement rotation which is needed for devices
> > > > > like the ipaq.
> > > > > The question is do we flip the xres and yres values depending
> > > > > on the rotation or do we just alter the data that will be
> > > > > drawn to make the screen appear to rotate. How does hardware
> > > > > rotate view the x and y axis?  Are they rotated or does just
> > > > > the data get rotated?
> > > > 
> > > > Where are you going to implement the rotation? At the fbcon or
> > > > fbdev level? 
> > > > 
> > > > Fbcon has the advantage that it'll work for all frame buffer
> > > > devices.
> > > 
> > > But you could also provide driver hooks for the chips which have
> > > such a rotation feature included (don't know if such exist, but i
> > > suppose they do, or may in the future).
> 
> It would be nice to have an option to be able to do the rotation
> entirely in software - some desktop users might prefer to have a
> portait-orientated display, when their graphics card doesn't have any
> hardware rotation facilities at all.

Well, that is James plan. I suppose that for hardware that can do
hardware rotation, it will be faster to do it instead of having the
software do it though, and thus it would be nice to have a driver hook
or something.

This way, if rotation is asked, then if the driver supports hardware
rotation, do it, and if not, do it in software.

At first, no driver will support hardware rotation anyway, so it would
be done in software.

And then, you reuse the same stuff to drive a chinese console or
something such.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
