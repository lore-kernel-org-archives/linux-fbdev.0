From: Kromer <krom@gazeta.pl>
Subject: framebuffer  with  non-direct memory access
Date: Fri, 10 Oct 2003 09:20:11 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3F865DAB.3010900@gazeta.pl>
Reply-To: krom@gazeta.pl
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A7rZL-0000v9-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Oct 2003 00:20:11 -0700
Received: from [195.117.141.6] (helo=dgt-lab.com.pl)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A7rZJ-0002SX-S2
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Oct 2003 00:20:10 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: krom@gazeta.pl

hello fb-everybody	

i'm just writing my own framebuffer driver for device acessed only via
parallel port (tlike lcd where is no way to direct read/write it's memory)

i just want to use memory allocated in kernel module, and acess it
application with mmmap (and of course flush this memory to device
periodicaly)

i have tried to use vmalloc like in vfb.c, and it works only with file 
transfers, when i'm using write to my framebuffer i can see it in my 
allocated memory
but, with mmap function there is no changes in my memory after writes 
(even i've flushed it with msync!)

the only way to acces mmap is to:
copy_from_user(my_memory,pointer_passed_to_fb_mmap_function,size)
that's not ver efficient

q1: where is documentation of writing own mmap  functions
q2: what fields need to be set in  mmap function implementation
q3: what kind of memory allocation i should use inside driver
       (kmalloc, vmalloc, with GFP_KERNEL or FGP_USER?)
q4: how to remap (or not?) in mmap function

q5: is there any simply way to build acess for non-direct memory ?
      i mean for each byte read/write to this
      memory need to be called my own function


please answer to my priv (mailto:krom@gazeta.pl) too
thx



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
