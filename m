From: James Simmons <jsimmons@infradead.org>
Subject: Re: [BK fbdev] Yet again more fbdev updates.
Date: Sat, 14 Dec 2002 15:08:04 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0212142204520.9829-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0212131707350.6750-100000@home.transmeta.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0212131707350.6750-100000@home.transmeta.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > 1) Its the same place on the screen or a different place every time?
>
> I think it's at the last line of the screen every time.

I think I might now what the problem is. scrup is using memcpy even when
the memory areas src, dest overlap. The key is to use memmove which
handles overlapping memory gracefully. Tell me if the following patch
works for you.

--- vt.c.orig	Sat Dec 14 13:32:42 2002
+++ vt.c	Sat Dec 14 13:34:46 2002
@@ -262,7 +262,7 @@
 		return;
 	d = (unsigned short *) (origin+video_size_row*t);
 	s = (unsigned short *) (origin+video_size_row*(t+nr));
-	scr_memcpyw(d, s, (b-t-nr) * video_size_row);
+	scr_memmovew(d, s, (b-t-nr) * video_size_row);
 	scr_memsetw(d + (b-t-nr) * video_num_columns, video_erase_char, video_size_row*nr);
 }
