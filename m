From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Feature Freeze?
Date: 05 Mar 2003 23:25:49 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046877877.1291.186.camel@localhost.localdomain>
References: <1046852721.1228.13.camel@localhost.localdomain>
	<20030305110529.GA2036@iliana>
	<1046868330.1229.59.camel@localhost.localdomain>
	<20030305134355.GA3105@iliana>
	<1046875559.1291.135.camel@localhost.localdomain> 
	<20030305144947.GA3946@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qakz-0005TJ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 07:24:33 -0800
In-Reply-To: <20030305144947.GA3946@iliana>
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
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-05 at 22:49, Sven Luther wrote:
> On Wed, Mar 05, 2003 at 10:46:37PM +0800, Antonino Daplas wrote:
> > > I thought that the new API, separating the fbcon layer from the fbdev
> > > drivers would add support for this more easily. I guess it would be easy
> > > for the Appian Jeronimo 2000 board, which has two permedia3 chips, and
> > > thus can be seen as two separate devices. Cards with two ramdacs per
> > > chip, like the G400, the later radeon's and most recent cards would need
> > > driver level support, that is understandable, but is all there for fbcon
> > > to take advantage of it ? What about multi-seat, with two full consoles,
> > > with mouse and keyboard for each ?
> > > 
> > 
> > This was one of the goals of the Ruby project, but I think it's mostly 
> > the input layer that got into the kernel. 
> 
> :(((
> 
> > Fbcon needs to be cleaned up, a lot. It still implements the "current
> > console or foreground console" concept (only one console active at a
> > time).  Also, this is more of a job for linuxconsole than fbdev.  I may
> > be wrong though.
> 
> Mmm, do you know who is working on linuxconsole, and what their plan are ?

James also. I think the site is http://linuxconsole.sourceforge.net.

Tony



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
