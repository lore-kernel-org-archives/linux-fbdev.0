From: Gerd Knorr <kraxel@bytesex.org>
Subject: cursor bug
Date: Mon, 8 Nov 2004 17:11:13 +0100
Message-ID: <20041108161113.GA23504@bytesex>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRCFV-0007w7-6A
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Nov 2004 08:20:09 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CRCFT-0005VG-Bk
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Nov 2004 08:20:09 -0800
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

  Hi,

There is annonying cursor bug in recent kernels (started in 2.6.10-rc1
IIRC).  There kernel seems not to keep track of the cursor state
correctly when switching virtual terminals.  Here is how to reproduce
it:

  (1) boot with vesafb (thats what I'm using, maybe it shows on other
      framebuffers and/or vgacon as well).
  (2) login into one terminal, then type "echo -ne '\033[?17;15;239c'".
      You should have a nice, yellow and *not* blinking cursor block.
      That is what I have in my .profile because I can't stand the
      blinking cursors.
  (3) Switch to another terminal.  The cursor goes into blinking
      underscore mode now (i.e. the default cursor).
  (4) Switch back to the first terminal.  Now you have a yellow block
      with the last two pixel lines (i.e. the underscore) blinking.

Oh no.  Please fix that.  Thank you.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
