From: Otto Solares <solca@guug.org>
Subject: Re: opengl for framebuffer
Date: Mon, 5 Jan 2004 13:39:06 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040105193906.GA442@guug.org>
References: <3FF9846C.4080709@dbservice.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdaZR-00008c-Dc
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 11:39:25 -0800
Received: from [168.234.203.30] (helo=guug.galileo.edu)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AdaZQ-0002Pp-V4
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 11:39:25 -0800
Content-Disposition: inline
In-Reply-To: <3FF9846C.4080709@dbservice.com>
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
Content-Transfer-Encoding: 7bit
To: tomas carnecky <tom@dbservice.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Mon, Jan 05, 2004 at 04:36:12PM +0100, tomas carnecky wrote:
> Hi ,
> 
> I'm looking for a opengl library for the framebuffer devices.
> I found an project (http://fbdri.sf.net) but they released only one 
> tarball,
> and that was about two years ago. Anyone knows another project?
> 
> I think there is a port of the XFree86 xserver to the framebuffer,
> but I don't want to use this large bunch of applications and libraries,
> just to get opengl working on the framebuffer.
> 
> Long ago, I had the idea to write a collection of libraries to make 
> opengl 3D
> acceleration avilable without a xserver or framebuffer. It works now 
> (somehow).
> There exists a _really_ small documentation 
> (www.dbservice.com/tom/graphics.html).
> 
> I'd like to know what you think about it.
> 
> PS: I'm not subscribed to the list, so please send me a copy.

There are 2 possibilities:

mesa standalone + dri: http://www.mesa3d.org/fbdev-dri.html

mesa gl software only: http://www.mesa3d.org/glfbdev-driver.html

I am using successfully mesa+dri on a radeonfb.

-solca



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
