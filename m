From: Otto Solares <solca@guug.org>
Subject: Re: framebuffer ioctl
Date: Mon, 6 Sep 2004 12:43:06 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040906184306.GA29544@guug.org>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be> <413A3735.9E7D2F11@orpatec.ch> <413B4925.5000706@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4OSU-0007Mm-F5
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Sep 2004 11:43:18 -0700
Received: from guug.galileo.edu ([168.234.203.30] helo=guug.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C4OSR-0004Cn-O6
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Sep 2004 11:43:18 -0700
Received: from solca by guug.org with local (Exim 3.36 #1 (Debian))
	id 1C4OSI-0007jN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 06 Sep 2004 12:43:06 -0600
Content-Disposition: inline
In-Reply-To: <413B4925.5000706@comcast.net>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Sun, Sep 05, 2004 at 10:13:09AM -0700, Zack wrote:
> Some reasons for moving drawing routines into the kernel include
> (correct me if I'm wrong)

Does 'moving drawing routines into the kernel' means 'exporting
to user-space drawing (possibly accelerated)' routines?

> 1. there is some needless duplication of effort between these
> various fullscreen-gui projects (svgalib, ggi, etc)
> 2. there is afaik presently no good facility for adding acceleration
> support for things like drawing lines
> 3. the chance that any fullscreen-gui project will become broken
> due to a new kernel is real (SVGAlib is broken with 2.4.26 & 2.6.7)
> 4. new features would be optional anyway: fullscreen-guis need not
> recognize their existence, but would benefit from doing so
> since some fb drivers would override the generic routines
> to implement accelerated routines.

These are good reasons for a single user-space library, not kernel
bloat.

The only consumer of drawing routines in the kernel is fbcon,
and acceleration should not go into the kernel, user-space libs do
a better and safer job here.

The only --true-- reason drawing routines should go into the kernel
is hw w/o a user-space accesible fb (maybe true for some rare and
for some next-gen cards).

-otto


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
