From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [RFC] Video Mode Handling
Date: Mon, 9 Aug 2004 09:43:58 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408090944.01414.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BtzI2-0001V1-05
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Aug 2004 18:49:30 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BtzI1-0003s1-ET
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Aug 2004 18:49:29 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id E0A68776723
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  9 Aug 2004 00:56:03 +0000 (UTC)
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>

Hi,

Video mode handling in fbdev-2.6 is becoming better, but is still not in
the same league as with fbdev-2.4.  The reason is that the upper vt layer
does not have any information about the video mode itself which leaves
the lower fbdev layer to fill in or replace the fields in a
partial/incorrect fb_var_sreeninfo structure (var).  This limitation is
partly alleviated by using fb_find_mode() to pass a complete var. 

fb_find_mode() will look for entries in a database in which most entries
are not compatible with the graphics/display combination.  The driver will
still need to "massage" the contents of var to make it work with the
particular combination.  Secondly, the current system does not preserve
the entire graphics per-console settings (such as bpp, virtual resolution,
etc). Thirdly, fb_find_mode() requires that the mode database need to stay
in the memory for the entire lifetime of fbdev/fbcon, increasing the kernel's
memory footprint. Finally, this requires that all drivers are capable of
guaranteeing a working display without any user intervention.

Most fbdev developers are proposing to bring back the per-display var
structures to ease the difficulty of video mode handling.  This proposal
is countered by a few (notably James) in that it severely increases the 
memory footprint of the kernel.  

How about a compromise then?

The fb_var_screeninfo structure contains the following:

	a. settings of the graphics card
	b. settings of the attached display
	c. fields used internally by core fbdev/fbcon which has no
	   relevance in video mode setting (ie, xoffset, yoffset)

Instead of saving the entire var, we just save the settings of the
graphics card.  Settings of the attached display will be replaced by
pointers to entries in a mode database.  Internally used fields will not be
saved, as these are typically handled by fbcon for each mode switch.

One requirement is the creation of a mode database that is valid and private
to the driver. This database must also be capable of adding new entries to its
list (such as when a user does an fbset), and optionally deleting entries which
might be entered by accident (such as when a var passes the driver's check_var()
function but the resulting mode is not acceptable).  

So when using 'stty', all fbcon needs to do is search the drivers private
mode database, and build a var using a combination of the previous graphics 
settings and the best fitting videomode.

When switching consoles, fbcon will rebuild the var using the settings in 
struct display and the saved pointer to a videomode structure.

Implementation:

The current modedb array is not sufficient for the task, as it's quite difficult
to manipulate array entries.  A more flexible format isneed. The mode database
can be made in the form of a double-linked list
((struct list_head) info->monspecs.modelist) to make the task easier.

Drivers can choose to add their own entries to the modelist. We have functions
that can convert a modedb array to a mode list. Or the driver can choose to
leave the modelist uninitialized/empty. In this case, fbdev will add a single
mode entry to the list, the values of which are gathered from the current var
(info->var).

Whatever approach is taken, the driver now has a private modelist with a minimum
of 1 entry where all entries are supposed to be guaranteed to work for the attached
display/s. The upper layer (fbcon) can then use this private modelist during
resizing or it can save an entry pointer in struct display, to be used when
switching consoles.

The modelist is required to grow in size since we cannot avoid users using their
own timings.  For each fb_set_var(), a struct fb_videomode is created from the var,
and if the mode is unique, it will be added to the modelist.

If a non-working mode entry is accidentally or unaccidentally added to the modelist,
we give the user the option to remove this from the list.  To make it simple, all
the user needs to do is an fb_set_var ioctl where the var contains the invalid
timings and var->activate = FB_ACTIVATE_INV_MODE.

The end-effect of all of the above is a behavior that approaches that of fbdev-2.4. 
Graphics/display settings are preserved per console. The 'stty' path, in theory,
should always work as it will only use entries in the driver's private mode list.
Although it has additional code size and complexity, this is more than compensated
for by the possibility that static data can be marked __init.  Instead of saving
the entire var structure per console, approximatedly half of the var's size is saved.
Another advantage is that the requirement for foolproof mode handling by drivers is
de-emphasized.

I'm going to follow-up with patches for the kernel and a patch for fbset to demonstrate
the proposal. The patch should not require any changes to low-level drivers nor break
compatibility with userland apps.

Let me know of comments or bugs.

Thanks.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
