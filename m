From: Antonino Daplas <adaplas@pol.net>
Subject: Re: LCD scaling type
Date: 11 Jan 2003 14:58:18 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042268184.932.165.camel@localhost.localdomain>
References: <1042227743.705.22.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XFl3-0003HS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jan 2003 23:08:41 -0800
In-Reply-To: <1042227743.705.22.camel@zion.wanadoo.fr>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2003-01-11 at 03:42, Benjamin Herrenschmidt wrote:
> Hi !
> 
> When setting a mode on an LCD display that is not exactly the
> native mode of that display, we can, on some chips, setup a
> scaler. However, most of the time, we have 2 difference choices
> for setting up this scaler: It can preserve or not preserve
> the aspect ratio. A typical example is the titnium powerbook's 1152x768
> mode. If I set it to 1024x768, I can get either horizontal scaling (not
> preserving aspect ratio) or no scaling with black bars on left & right
> (preserving aspect ratio).
> 
> While in most case you actually want to preserve the aspect ratio, it
> would still I beleive make sense to let the user choose it. 
> 
> Could we define one of the reserved fields in fb_var_screeninfo as
> beeing a "flags" field for such things ? There are a couple of other
> things that we may want to stuff into such a bitfield later, I'd suggest
> reserving one 32 bits field for such flags.
> 

I second to this.  It's useful to have an extra field in
fb_var_screeninfo for drivers to play around.  It's like an extension
field and its main use is to expose a hardware capability which is
uncommon enough to warrant generic support.  It's meaning will vary from
driver to driver.  

I also have a couple of things that come to mind (like switching from
truecolor to directcolor and vice versa without rebooting).  I currently
use var->nonstd which is probably not the the right thing to do.

Tony





-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
