From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: framebuffer_{alloc,release}
Date: Thu, 18 Sep 2003 18:01:42 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030918160142.GA2280@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A01FK-000709-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 18 Sep 2003 09:03:06 -0700
Received: from mail-7.tiscali.it ([195.130.225.153])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A01FJ-0006dh-Kw
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Sep 2003 09:03:05 -0700
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


Hum, I don't see original email...

James Simmons wrote:
>The patch looks nice except for one thing. framebuffer_alloc is incorrect 
>in assuming there is one struct xxx_par per strut fb_info. Struct xxx_par
>represents the physically hardware in a way independent of the 
>framebuffer. The reason for this was to handle cards with more than one 
>physical framebuffer. For example take a dual headed radeon card. You 
>would have a design like this.
>		   |-----------------	
> ____________	   |	 | /dev/fb0 |
>| radeon_par | ----|	 ------------
>|____________|	   |
>		   |
>		   |-----------------
>		   	 | /dev/fb1 |
>		   	 ------------
>
>the reason for this design is simple. If fb0 video resolution changes it 
>affects par. Now par's state affect fb1. We need to see if changes to 
>either fb0 or fb1 affects the other display as well.

framebuffer_alloc doesn't assume anything. It allocates fb_info->par iff
it's  told to. For  dual  head you  can allocate  par  yourself (and  do
whatever you want with it) or do something like this (matrox fb is doing
something similar):

if (seconday) {
        fb_info = framebuffer_alloc(0, NULL);
        fb_info->par = primary->par;
} else
        fb_info = framebuffer_alloc(sizeof(struct foo_par), NULL);

release_fb_info  won't  touch  fb_info->par  unless it  was  created  by
framebuffer_alloc. If  secondary driver  can work  even when  primary is
unloaded  then you  can  use  class_device_get (or  a  wrapper) to  keep
primary fb data around:

if (secondary) {
        if (!primary_fb_info)
                secondary_fb_info = framebuffer_alloc(sizeof(struct foo_par), NULL);
        else {
                if (!class_device_get(&primary_fb_info->class_dev))
                        /* primary is going away */
                else {
                        secondary_fb_info = framebuffer_alloc(0, NULL);
                        secondary_fb_info->par = primary_fb_info->par;
                }
        }
}


I've created a bk tree here:

bk://mesa3d.bkbits.net/fbdev-2.5

It's cloned from your tree and you can do a bk pull. You'll get the
following changesets:

<kronos@kronoz.cjb.net> (03/09/17 1.1285)
   Update sparc framebuffer drivers to the new API.

<kronos@kronoz.cjb.net> (03/09/17 1.1281.1.1)
   Add new API framebuffer_alloc and framebuffer_release.

   Framebuffer info structure (ie. struct fb_info) must be obtained from
   framebuffer_alloc. When it is no longer needed (after unregister_framebuffer
   and clean up) it can be released using framebuffer_release.

   If the framebuffer is not registered yet (eg. on error path) then fb_info must
   be released via kfree.


David S. Miller has ack'ed sparc changes.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Runtime error 6D at f000:a12f : user incompetente


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
