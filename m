From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: LCD scaling type
Date: 11 Jan 2003 13:08:30 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042286909.541.43.camel@zion.wanadoo.fr>
References: <1042227743.705.22.camel@zion.wanadoo.fr>
	 <1042268184.932.165.camel@localhost.localdomain>
	 <1042278469.541.27.camel@zion.wanadoo.fr>
	 <1042279649.955.18.camel@localhost.localdomain>
	 <1042283284.541.38.camel@zion.wanadoo.fr>
	 <1042284929.977.46.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-3-14.abo.wanadoo.fr ([193.253.250.14] helo=zion.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XKR7-0006uq-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Jan 2003 04:08:25 -0800
In-Reply-To: <1042284929.977.46.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2003-01-11 at 12:35, Antonino Daplas wrote:
> If you only need to do is turn something on or off, assigning it an
> ioctl may be too much.  The "feature" can be anything, not just a mode
> setting. Also, you will have fbdev drivers writing their own ioctls just
> for these "little" features, and each will need to have its own utility
> written specifically for the driver.  If you have an
> fb_var_screeninfo.tweaks field, you can simply use fbset, and it can be
> used for all drivers.  One can even collect all possible 'hardware'
> tweaks and create a general fb tweaks utility just by using fbset.
> 
> Of course, if the feature requires something more than just turning a
> switch on and off, then an ioctl is more practical.

Hrm... I think this is going too far for var_screeninfo. However,
we do have need for such "tunable" settings, that can be
brightness/contrast/backlight kind of stuff, geometry on some i2c-driven
monitors (iMacs typically) etc...

It may be interesting to think about an API where the fbdev (or the
monitor layer, which is something we currently lack that should probably
sit on top of fbdev) to expose the available "settings" and have std
ioctls to get/set their values. A bit like sound mixer settings work
today maybe.

For my immediate need, however, I still think turning one of the
reserved fields of var_screeninfo into a "mode_flags" would be useful,
we can already define a FB_MFLAG_LCD_FULLSCALE flag that would ask the
driver to not bother keeping aspect ratio (the idea here is that keeping
aspect ratio is the default, so 0, even if that's nor really working yet
in radeonfb or aty128fb).
 

-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
