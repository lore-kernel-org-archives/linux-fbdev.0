From: Antonino Daplas <adaplas@pol.net>
Subject: Re: LCD scaling type
Date: 11 Jan 2003 19:35:30 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042284929.977.46.camel@localhost.localdomain>
References: <1042227743.705.22.camel@zion.wanadoo.fr>
	<1042268184.932.165.camel@localhost.localdomain>
	<1042278469.541.27.camel@zion.wanadoo.fr>
	<1042279649.955.18.camel@localhost.localdomain> 
	<1042283284.541.38.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XK55-0004Fb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Jan 2003 03:45:39 -0800
In-Reply-To: <1042283284.541.38.camel@zion.wanadoo.fr>
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

On Sat, 2003-01-11 at 19:08, Benjamin Herrenschmidt wrote:
> On Sat, 2003-01-11 at 11:16, Antonino Daplas wrote: 
> > 
> > Well, yes of course, if a particular hardware feature is quite useful
> > and common, then you need something definitive.  But what I also want is
> > another field which will serve as a private communication channel
> > between userspace and driver. Adventurous users/testers can use them to
> > turn a unique hardware feature on/off.  This is similar to 'Tweak'ing
> > utilities common in MS Windows.
> 
> I already do that in some drivers using private ioctl's, though if
> what you want is really an additional "feature" affecting a mode
> setting, then it makes sense to fit it into fb_var_screeninfo
> 

If you only need to do is turn something on or off, assigning it an
ioctl may be too much.  The "feature" can be anything, not just a mode
setting. Also, you will have fbdev drivers writing their own ioctls just
for these "little" features, and each will need to have its own utility
written specifically for the driver.  If you have an
fb_var_screeninfo.tweaks field, you can simply use fbset, and it can be
used for all drivers.  One can even collect all possible 'hardware'
tweaks and create a general fb tweaks utility just by using fbset.

Of course, if the feature requires something more than just turning a
switch on and off, then an ioctl is more practical.

Tony



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
