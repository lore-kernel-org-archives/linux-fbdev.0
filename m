From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: atyfb expert needed
Date: Tue, 17 Feb 2004 17:00:10 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1076997609.1046.168.camel@gaston>
References: <1076537453.868.123.camel@gaston>
	 <200402131641.29028.alex.kern@gmx.de> <1076714453.7304.103.camel@gaston>
	 <200402141626.39311.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AsyML-0002Tz-JG
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 16 Feb 2004 22:05:29 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AsyCS-0003iS-RM
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 16 Feb 2004 21:55:16 -0800
In-Reply-To: <200402141626.39311.alex.kern@gmx.de>
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
To: Alexander Kern <alex.kern@gmx.de>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2004-02-15 at 02:26, Alexander Kern wrote:
> Am Samstag, 14. Februar 2004 00:20 schrieb Benjamin Herrenschmidt:
> > > Hi,
> > > mach64_ct.c(where aty_dsp_gt is) from James tree should be identical with
> > > Daniel'S 2.4 tree. If not, please send me the diff.
> >
> > Is Daniel's latest version in current 2.4 or is there another source
> > for his patches ?

Ok. Comparing 2.4.24 & 2.6.3/fbdev to XFree driver, it seems that
2.6.3/fbdev matches XFree more closely.... Except that we are missing
the FIFO_24 attribute for the LT-G chip.

Fixing that leads to slightly less crapy display, but still unreadable... until
I figured out that acceleration (imageblit more precisely) has broken endianness...

This kludge fixes it for me (maybe incorrect, just a quick fix) :

@@ -419,9 +425,9 @@
                }
        } else {
                u32 *pbitmap;
-               for(pbitmap = (u32*)(image->data); dwords; dwords--, pbitmap++) {
-                       wait_for_fifo(1, par);
-                       aty_st_le32(HOST_DATA0, *pbitmap, par);
+               for (pbitmap = (u32*)(image->data); dwords; dwords--, pbitmap++) {
+                       wait_for_fifo(2, par);
+                       aty_st_le32(HOST_DATA0, le32_to_cpup(pbitmap), par);
                }
 
_BUT_ then, I get a lockup when reaching the end of the screen... Apparently,
it locks up when drawin the last line, not sure if it did a scroll yet or not.
I'm playing with the accel fifo a bit, but that's definitely a regression.

Ben.






-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
