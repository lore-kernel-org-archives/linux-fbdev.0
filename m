From: "Sottek, Matthew J" <matthew.j.sottek@intel.com>
Subject: RE: Framebuffer with banked memory
Date: Wed, 30 Oct 2002 13:09:48 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <2B4461BF89BAD511A86100508B66D53804E4FA67@fmsmsx112.fm.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from fmr02.intel.com ([192.55.52.25] helo=caduceus.fm.intel.com)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18706D-0007Zl-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Oct 2002 13:10:01 -0800
Received: from talaria.fm.intel.com (talaria.fm.intel.com [10.1.192.39])
	by caduceus.fm.intel.com (8.11.6/8.11.6/d: outer.mc,v 1.51 2002/09/23 20:43:23 dmccart Exp $) with ESMTP id g9UL5qo27514
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Oct 2002 21:05:52 GMT
Received: from fmsmsxv040-1.fm.intel.com (fmsmsxvs040.fm.intel.com [132.233.42.124])
	by talaria.fm.intel.com (8.11.6/8.11.6/d: inner.mc,v 1.27 2002/10/16 23:46:59 dmccart Exp $) with SMTP id g9ULCjD09922
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Oct 2002 21:12:45 GMT
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: 'alain volmat' <avolmat@yahoo.fr>, linux-fbdev-devel@lists.sourceforge.net


Alain,
   I worked on an i810 driver that would use the banked memory instead =
of
requiring agp to be functioning at boot time (See the other thread =
going on
now).  Basically the i810 can use banked memory OR have agpgart.
  The short answer to your problem is that, sadly, much of the 2.4
framebuffer is badly implemented, allowing device independent code to
directly access device memory etc. Some of this is cleaned up for 2.5, =
but
as I've not looked at it lately I'm not sure how much.  Here are some
pointers as to what is required for 2.4.

#1 The Boot penguin code directly accesses your video memory. If you =
have
banked memory this will likely fall off the end of a pointer and oops =
the
kernel or worse.

#2 Read/Write Access video memory directly. I had added a read/write
handler to the fb_ops to hook these out and switch banks.=20
Read/write are also incorrect if your pitch !=3D width.

#3 Memory map can't be done. I had coded up a working version that =
would
map a single back and page fault in the banks as necessary. This worked
but would get hung up on unaligned accesses where one instruction =
accessed
two memory banks at the same time. So memory map isn't possible.

 The jist was that I could disable memory map. Implement character =
drawing
with bank switching. Implement read/write handlers that did bank =
switching,
then make the read/write fops use the handlers. Then lastly redo the
penguin drawing code to use the write handler rather than direct =
access.
All this to get a console... and not much else.

-Matt



-----Original Message-----
From: alain volmat [mailto:avolmat@yahoo.fr]
Sent: Wednesday, October 30, 2002 2:49 AM
To: linux-fbdev-devel@lists.sourceforge.net
Subject: [Linux-fbdev-devel] Framebuffer with banked memory


Hi,

I've been searching on the mailing list concerning the
case of writing a framebuffer for a video card which
DOESN'T have linear video memory. Actually I didn't
found any reply to my question.
(well this might means that there is no solution to my
problem .. but in that case I would like
confirmation).

As I said the video card I am now writing a
framebuffer for, doesn't have linear memory, which
means that I can only access a small part of the
memory at a time and then set offset registers in
order to access another part of the memory.

I would like to know if there is such case in current
framebuffer drivers ?? If so, what is the common
solution to do that ??

In fact the problem remains in the case of mmap (which
is the most common ;( of course), since the memory
seams to be accessed directly by pointer, there might
be no wait to detect if we need to set or not an
offset. In case of fb_read fb_write, it is possible to
do that before the actual write at the end (even if it
is not sooo beautiful ... ).

Anyway, it would be very helpful to me if I could get
an answer to this question.
Thanks by advance.

Alain Volmat

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en fran=E7ais !
Yahoo! Mail : http://fr.mail.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future=20
of Java(TM) technology. Join the Java Community=20
Process(SM) (JCP(SM)) program now.=20
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
