From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Radeon framebuffer weirdness in -mm2
Date: Fri, 21 Jan 2005 11:03:14 +1100
Message-ID: <1106265794.18397.17.camel@gaston>
References: <20050120232122.GF3867@waste.org>
	 <20050120153921.11d7c4fa.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CrmHa-00088y-2s
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 16:04:10 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CrmHY-0007Ar-IV
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 16:04:10 -0800
In-Reply-To: <20050120153921.11d7c4fa.akpm@osdl.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, ajoshi@shell.unixbox.com, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2005-01-20 at 15:39 -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > I'm seeing radeonfb on my ThinkPad T30 go weird on reboot (lots of
> > horizontal lines) and require powercycling to fix. Worked fine with 2.6.10.
> 
> Which radeon driver? CONFIG_FB_RADEON_OLD or CONFIG_FB_RADEON?
> 
> (cc Ben, who is the likely cuprit ;)
> 
> Which -mm2, btw?  2.6.10-mm2 or 2.6.11-rc1-mm2?
> 
> Did you try the corresponding -mm1?

/me curses possible BIOS crap ...

radeonfb tries to restore initial mode when the module is closed, which
wouldn't work for a VGA text thing in fact... I suspect something cause
driver remove() routines to be called on reboot, can you confirm ? Or is
it a module that gets removed ? It may well be a problem that has always
been there (regardless of the radeon driver version) and just triggered
by something the kernel does on reboot...

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
