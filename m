From: Antonino Daplas <adaplas@pol.net>
Subject: Re: rotation.
Date: 11 Jan 2003 13:13:20 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042261811.932.145.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301101940460.18287-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XE7O-0004Za-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jan 2003 21:23:39 -0800
In-Reply-To: <Pine.LNX.4.44.0301101940460.18287-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Sat, 2003-01-11 at 03:42, James Simmons wrote:
> 
> > > Yes. Hardware rotation shouldn't also not effect the way accel 
> > > operatations are done.
> >  
> > The main difference is if the hardware supports rotation, fbcon will
> > present it with "normal" data.  With the generic implementation, fbcon
> > will present the driver with rotated data.
> > 
> > So we need a driver capabilities field either in fb_info or
> > fb_fix_screeninfo.
> 
> We can just test if the rotation hook exist for the fbdev driver. No hook 
Okay.  What will the hook do, BTW?  Just turn hardware rotation to
the appropriate orientation?  Something like...

int fb_rotate(struct fb_info *info, int rotate);

Then we can do something like:

if (info->fbops->fb_rotate) {
	info->fbops->fb_rotate(info, FB_ROTATE_CCW);
	"pass 'normally' oriented data"
else
	"pass data rotated CCW"
}

Also, you may want to place the rotate field in fb_fix_screeninfo
instead.  You mentioned that rotation is to be activated at the console
layer, so the rotate field is for informational purposes only.

> then use generic code in fbcon. Also we have a angle field in var so we 
> can see if the user wants the data rotated.
> 
> > Not really.  We can dynamically rotate the fontdata using the default
> > display->fontdata into another buffer.  I believe I have functions that
> > do that in the patch I submitted.  (Sorry, I lost it when one of my
> > drives crashed :-(.
> 
> I have that patch. It just has to be updated to the latest changes.
> 
> 
Yeap.  Geert forwarded them to me.  Thanks Geert :-)

Tony





-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
