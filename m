From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Vertical retrace interrupts?
Date: 30 Jan 2003 10:34:55 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1043893384.1052.127.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301281920520.12076-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18e4fz-0007BM-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 Jan 2003 18:43:39 -0800
In-Reply-To: <Pine.LNX.4.44.0301281920520.12076-100000@phoenix.infradead.org>
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
Cc: Fredrik Noring <noring@nocrew.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-01-29 at 03:21, James Simmons wrote:
> 
> > Are there any plans on merging DirectFB features? Stuff like vertical
> > retrace interrupts etc.?
> 

I wholeheartedly agree with this.  There are a lot of applications out
there (especially video players) where vtrace signal delivery is
critical for optimum operation.  Polling for VGA registers is not
totally correct for newer cards and is too inefficient, so this has to
be done at a per driver level.

> Thats already supported. Just add a poll function to fb_ops. To date no 
> one has used this feature.
> 

It's because there is no .poll entry in the struct file_operations in
fbmem.c  Something like this:

static struct file_operations fb_fops = {
	.owner =	THIS_MODULE,
	.read =		fb_read,
	.write =	fb_write,
	.ioctl =	fb_ioctl,
	.mmap =		fb_mmap,
	.open =		fb_open,
	.release =	fb_release,
#ifdef HAVE_ARCH_FB_UNMAPPED_AREA
	.get_unmapped_area = get_fb_unmapped_area,
#endif
	.poll =         fb_poll,
};

static unsigned int fb_poll(struct file *file, poll_table *wait)
{
	if (info->fbops->fb_poll)
		return (info->fbops->fb_poll(file, wait));
	return -EINVAL;
}

Also, poll is blocking.  You might want to include an .fasync entry too
for asynchronous I/O.

Finally, is the poll function too generic? I'm not sure about this but
basically we can only wait for events like 'there is data to read, it's
now okay to write', etc.  Is this too ambiguous?   Is it okay to define
a private event flag?  Or do we just agree that fb_poll means wait for
vretrace?

I know that there's already an overuse of ioctls, but for something
specific and important as this, we might not have a choice.

Tony

BTW:  It's not too difficult to add generic vsync interrupt handlers for
most VGA cards via register CR11. 




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
