From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Sane behavior of fbset
Date: Sat, 19 Jun 2004 02:40:46 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406190240.26228.adaplas@hotpop.com>
References: <200406180945.12444.adaplas@hotpop.com> <20040618173840.GA3989@havoc.gtf.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbOI0-0001zJ-Vj
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 11:40:36 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbOI0-0004cM-HO
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 11:40:36 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 936B35EB07A
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Jun 2004 18:01:58 +0000 (UTC)
In-Reply-To: <20040618173840.GA3989@havoc.gtf.org>
Content-Disposition: inline
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
To: David Eger <eger@havoc.gtf.org>, adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Saturday 19 June 2004 01:38, David Eger wrote:
> On Fri, Jun 18, 2004 at 09:45:12AM +0800, Antonino A. Daplas wrote:
> > Hi,
> >
> > Currently, using fbset either corrupts the display, or at worst, hangs
> > the GPU.  I consider this a critical bug.  I don't want to discuss the
> > pros/cons of using fbset vs stty to change the console size, but we need
> > to make sure that using fbset (or any utility that utilizes the
> > fb_set_var ioctl) does not produce undefined behavior.  There are at
> > least 3 possibilities:
> >
> > 1.  Revert to 2.4 behavior.  This is easy to add since fbdev already has
> > a notifier support. (I already have working code for this). Of course,
> > stty will still work.
>
> Just for my enlightenment, could you give a synopsis of 2.4 behavior
> versus 2.6 behavior?
>

In 2.4

1. you can use fbset to change the console window size.

2. stty will not change the window size (produce a small viewport or the 
contents will be clipped)

3. Switching from one console to another will preserve the video mode.  
Example:
tty1 - 800x600-16@85
tty2 - 1024x768-8@60

When switching from tty2 to tty1 or vice versa, your mode setting will be 
retained.  This is because each console has its own copy of  
fb_var_screeninfo.

4. The need to create/validate a modeline is optional as this is expected to 
be done in userland.
 
In 2.6

1. If you use fbset, you will get screen corruption or hang the GPU

2. stty will do the function of fbset.  However, stty will only pass rows and 
cols (xres and yres respectively).  There is no information for bit depth, 
timings, virtual resolution, etc.

3. Switching from one console to another may or may not preserve your mode 
settings.  In the example above, If I switch from tty2 to tty1, I might get a 
display with a refresh of 60Hz at 8 bpp.  The mode you get will depend on the 
drivers capability to pick/create a modeline.  This is because you only have 
1 valid fb_var_screeninfo at one time, and this is info->var.

4. Creation/validation of modelines by drivers is practically a necessity. 

Of course, 2.6 does have some good points.  It's easier to write a driver for 
it, the resulting driver code is probably smaller, it's faster, and fbcon and 
fbdev are separated, ie you can load fbdev without taking over your console.  
The last one is probably useful for embedded devices.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
