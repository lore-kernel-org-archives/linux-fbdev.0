From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: Feature Freeze?
Date: Wed, 5 Mar 2003 15:49:47 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030305144947.GA3946@iliana>
References: <1046852721.1228.13.camel@localhost.localdomain> <20030305110529.GA2036@iliana> <1046868330.1229.59.camel@localhost.localdomain> <20030305134355.GA3105@iliana> <1046875559.1291.135.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233] helo=mel-rto3.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qaDY-0000jy-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 06:50:00 -0800
Content-Disposition: inline
In-Reply-To: <1046875559.1291.135.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Mar 05, 2003 at 10:46:37PM +0800, Antonino Daplas wrote:
> > I thought that the new API, separating the fbcon layer from the fbdev
> > drivers would add support for this more easily. I guess it would be easy
> > for the Appian Jeronimo 2000 board, which has two permedia3 chips, and
> > thus can be seen as two separate devices. Cards with two ramdacs per
> > chip, like the G400, the later radeon's and most recent cards would need
> > driver level support, that is understandable, but is all there for fbcon
> > to take advantage of it ? What about multi-seat, with two full consoles,
> > with mouse and keyboard for each ?
> > 
> 
> This was one of the goals of the Ruby project, but I think it's mostly 
> the input layer that got into the kernel. 

:(((

> Fbcon needs to be cleaned up, a lot. It still implements the "current
> console or foreground console" concept (only one console active at a
> time).  Also, this is more of a job for linuxconsole than fbdev.  I may
> be wrong though.

Mmm, do you know who is working on linuxconsole, and what their plan are ?

> > > It does have one benefit though, the newer code should make it easier to
> > > add an infrastructure on top of fbdev, such as xinerama-style support. 
> > > But this will be in the future.
> > 
> > Mmm, I don't know if there is really a point to this, are there really
> > all that much applications which do xinerama-like things on top of fbdev ?
> > I rather thought that more higlevel userland apps would be doing this.
> > like either xfree86 with chip-specific drivers or fbdev drivers, or
> > directfb or something such.
> > 
> 
> You're right, xinerama is mainly user-app.

:)))

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
