From: "Jochen Roth" <jochen@panix.com>
Subject: Re: X endianess problem
Date: Tue, 10 Jun 2003 07:04:00 -0400 (EDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200306101104.h5AB40k12305@panix3.panix.com>
References: <20030606064155.GA2166@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail1.panix.com ([166.84.1.72])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Pgv5-0002ib-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 10 Jun 2003 04:04:03 -0700
In-Reply-To: <20030606064155.GA2166@iliana> from "Sven Luther" at Jun 06, 2003 08:41:55 AM
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
To: Sven Luther <sven.luther@wanadoo.fr>, linux-fbdev-devel@lists.sourceforge.net

I just finished reading through the radeonfb/endianness thread. I am
working on an old IBM PReP thin client with an S3 Trio64V2/DX.

I started out with 2.4.19 from kernel.org and added startup code and
some patches for prep_pci.c etc. I am testing this under XFree86
4.1.0.1 with the fbdev module, current stable ppc off of debian.org.

I got the 16bit console stuff working by byte-swapping the packed
rgb words in the _setcolreg handler. Same code basically as in the
clgenfb.c, for instance.

Neither X nor fbi get the byte order right, though. I tried both the
0, 5, 10 and the 8, -3, 2 offsets for 5:5:5, and the equialents for
5:6:5 as well. (I understand the -3 conceptually, but I need to look
at the source for the library fbi uses.)

BTW, here is what happens after startx (xinit):
...
s3triofb_op_set_var con=6 1024x768-1024x768-16bpp mode=22271 56 8\
 41 0 176 8 -- act=2
fb_mmap() enter
fb_mmap() success
s3triofb_op_set_var con=6 1024x768-1024x768-16bpp mode=15385 160\
 24 29 3 136 6 AT act=0
...

The 22271 ps mode must get set by XFree, or it is the default for a
new VT. Then comes the mmap, followed by the proper mode switch -- this
order is not really safe, I would think.

BTW, based on my debug output X never turns off the accelerator. Is
that OK?

The hardware documentation for my chip says that there is supposed to
be an endian-swapped mapping for the frame buffer, essentially the
second 32MB of the 64MB total bar0. As far as I can tell this second
mapping does not byte-swap the video buffer.

Any suggestions on how best to proceed are greatly appreciated.

Jochen



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
