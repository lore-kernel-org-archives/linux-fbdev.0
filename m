From: jayakumar lkml <jayakumar.lkml@gmail.com>
Subject: LCD controller with vertical packing
Date: Fri, 29 Apr 2005 20:40:24 +0800
Message-ID: <45a44e48050429054069f50fc3@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRUnJ-0006oT-Nh
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Apr 2005 05:40:33 -0700
Received: from zproxy.gmail.com ([64.233.162.202])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DRUnI-00081A-As
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Apr 2005 05:40:33 -0700
Received: by zproxy.gmail.com with SMTP id 9so1556465nzo
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Apr 2005 05:40:24 -0700 (PDT)
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi all,

I have a LCD board with a physical resolution of 384x128 which is made
up of a 3x2 grid of 128x64 monochrome black/white lcds. The interface
is 8bit data with a few other lines for handshaking and control. I'm
thinking of writing an fbdev driver for this device so that userspace
apps can do stuff like open /dev/fb0,write,close or maybe even
open,mmap,dostuff,cleanup or even use Xfbdev on it. But I think there
is a problem. The controller has an unusual pixel packing. It's packed
8-vertical pixels per byte. Meaning, that if you wanted to write a
single pixel high horizontal line 384 pixels wide at y=3D0, you'd have
to output 0x1 to the datalines 384 times. And say you wanted a
vertical stipple, it'd be 0xA to the datalines 384 times. Whereas if
you wanted to draw a black box 8 pixels high and 5 pixels wide, you'd
just write 0xF five times. I hope that explaination is clear. One
could also use the control lines to tell the controller an x and y
coordinate address to get to any individual 8 pixel vertical block.

I suspect this packing is not one that is easily supported in fbdev
given it's packing. Is this suspicion valid? I mean, I guess i could
use fb_ops->fb_write hooks and then repack any writes to the
framebuffer. Would that work for stuff like Xfbdev? I'm guessing
anything that depended on being able to mmap the fb would not work.
Maybe there's some way to make all mmaped writes to the fb cause some
kind of page fault and then have a handler that repacked it.

All advice and feedback is welcome.

Thanks,
jaya


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
