From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [RFC] Does fbdev need a cursor API for userland?
Date: Sun, 17 Oct 2004 23:47:15 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410172347.15516.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, linux-fbdev-users <linux-fbdev-users@lists.sourceforge.net>

Hi all,

I'm done with a little clean-up of the fbcon cursor code.  A problem still
remains with the cursor code in fbmem.c:fb_cursor(). This function is
accessible by the user through the FBIO_CURSOR ioctl.  However, just by
looking at it, I think it is broken. 

The question is, do we need to support this ioctl?  Coding for this correctly
is a bit complicated (very similar to coding for a rudimentary overlay).
However, if it's agreed upon to support this ioctl, here's a proposal and
questions for an implementation:

1. Below can be supported by the current cursor code.  Do we need more?

  - 2-color cursor
  - show, move, hide cursor
  - maximum dimensions of 64x64
  - invert and copy ROPs

2. Should fbdev implement a generic version, or should this be available only
to drivers with hardware cursors?

3. Additionally, code must be written for the following:
  - restriction for single use or locking for multiple use
  - save/restore framebuffer contents underlying the cursor (if a 
    software/generic version is supported) 

4. Implementation

A single ioctl is too unwieldy for usage.  It's probably better to split the
ioctl into at least following:

FBIO_CURSOR_ACTIVATE
	- activate/inactivate user-mode cursor.  This will disable/reenable the 
fbcon cursor, load initial data (colormap, image, map), etc.

FBIO_CURSOR_MOVE
	- show, move or hide cursor

FBIO_CURSOR_LOADCMAP
	- change cursor colormap

FBIO_CURSOR_LOADIMAGE
	- change cursor image and mask

IMO, I believe that the cursor ioctl should just be removed :-)

Comments?

Tony




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
