From: John Bradford <john@grabjohn.com>
Subject: Re: Re: rotation.
Date: Wed, 8 Jan 2003 12:05:48 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200301081205.h08C5mPv000776@darkstar.example.net>
References: <yw1xu1gj51ep.fsf@tiptop.e.kth.se>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <yw1xu1gj51ep.fsf@tiptop.e.kth.se> from "=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=" at Jan 08, 2003 12:25:18 PM
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
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: luther@dpt-info.u-strasbg.fr, geert@linux-m68k.org, jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

> > > > I'm about to implement rotation which is needed for devices
> > > > like the ipaq.
> > > > The question is do we flip the xres and yres values depending
> > > > on the rotation or do we just alter the data that will be
> > > > drawn to make the screen appear to rotate. How does hardware
> > > > rotate view the x and y axis?  Are they rotated or does just
> > > > the data get rotated?
> > > 
> > > Where are you going to implement the rotation? At the fbcon or
> > > fbdev level? 
> > > 
> > > Fbcon has the advantage that it'll work for all frame buffer
> > > devices.
> > 
> > But you could also provide driver hooks for the chips which have
> > such a rotation feature included (don't know if such exist, but i
> > suppose they do, or may in the future).

It would be nice to have an option to be able to do the rotation
entirely in software - some desktop users might prefer to have a
portait-orientated display, when their graphics card doesn't have any
hardware rotation facilities at all.

John.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
