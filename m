From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: LCD scaling type
Date: 11 Jan 2003 12:08:04 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042283284.541.38.camel@zion.wanadoo.fr>
References: <1042227743.705.22.camel@zion.wanadoo.fr>
	 <1042268184.932.165.camel@localhost.localdomain>
	 <1042278469.541.27.camel@zion.wanadoo.fr>
	 <1042279649.955.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-3-14.abo.wanadoo.fr ([193.253.250.14] helo=zion.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XJUi-00067n-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Jan 2003 03:08:04 -0800
In-Reply-To: <1042279649.955.18.camel@localhost.localdomain>
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

On Sat, 2003-01-11 at 11:16, Antonino Daplas wrote: 
> 
> Well, yes of course, if a particular hardware feature is quite useful
> and common, then you need something definitive.  But what I also want is
> another field which will serve as a private communication channel
> between userspace and driver. Adventurous users/testers can use them to
> turn a unique hardware feature on/off.  This is similar to 'Tweak'ing
> utilities common in MS Windows.

I already do that in some drivers using private ioctl's, though if
what you want is really an additional "feature" affecting a mode
setting, then it makes sense to fit it into fb_var_screeninfo

-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
