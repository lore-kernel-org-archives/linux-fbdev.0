From: Antonino Daplas <adaplas@pol.net>
Subject: Re: LCD scaling type
Date: 11 Jan 2003 18:16:11 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042279649.955.18.camel@localhost.localdomain>
References: <1042227743.705.22.camel@zion.wanadoo.fr>
	<1042268184.932.165.camel@localhost.localdomain> 
	<1042278469.541.27.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XIqO-0007h6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Jan 2003 02:26:25 -0800
In-Reply-To: <1042278469.541.27.camel@zion.wanadoo.fr>
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

On Sat, 2003-01-11 at 17:47, Benjamin Herrenschmidt wrote:
> On Sat, 2003-01-11 at 07:58, Antonino Daplas wrote:
> > On Sat, 2003-01-11 at 03:42, Benjamin Herrenschmidt wrote:
> 
> > I second to this.  It's useful to have an extra field in
> > fb_var_screeninfo for drivers to play around.  It's like an extension
> > field and its main use is to expose a hardware capability which is
> > uncommon enough to warrant generic support.  It's meaning will vary from
> > driver to driver.  
> 
> I don't fully agree here. While I agree a driver specific field might
> be useful, I beleive the "flags" field should have defined meaning.
> 
> > I also have a couple of things that come to mind (like switching from
> > truecolor to directcolor and vice versa without rebooting).  I currently
> > use var->nonstd which is probably not the the right thing to do.
> 
> For this too, defined flags would make sense as other driver might want
> to implement the same capability, in which case we really want all of
> them to do it the same way.
> 

Well, yes of course, if a particular hardware feature is quite useful
and common, then you need something definitive.  But what I also want is
another field which will serve as a private communication channel
between userspace and driver. Adventurous users/testers can use them to
turn a unique hardware feature on/off.  This is similar to 'Tweak'ing
utilities common in MS Windows.

Tony



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
