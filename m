From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: New FBDev patch
Date: Thu, 8 Jan 2004 23:26:21 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040108232621.B25760@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0401082108080.12797-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AejXo-0006Ja-Nh
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Jan 2004 15:26:28 -0800
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AejXo-0003fW-52
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Jan 2004 15:26:28 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401082108080.12797-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Thu, Jan 08, 2004 at 10:03:54PM +0000
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Jan 08, 2004 at 10:03:54PM +0000, James Simmons wrote:
> This is the latest patch against 2.6.0-rc3. Give it a try.
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

This looks wrong (cyber2000fb.c):

@@ -1220,18 +1220,18 @@
 }

 static struct cfb_info * __devinit
-cyberpro_alloc_fb_info(unsigned int id, char *name)
+cyberpro_alloc_fb_info(unsigned int id, char *name, struct device *dev)
 {
        struct cfb_info *cfb;
+       struct fb_info *fb_info;

-       cfb = kmalloc(sizeof(struct cfb_info) +
-                      sizeof(u32) * 16, GFP_KERNEL);
+       fb_info = framebuffer_alloc(sizeof(struct cfb_info) + 32 * 16, dev);

sizeof(u32) != 32.  Proper fix is to place the pseudopalette array
inside cfb_info, and dispense with this addition here.

I could supply a patch, but I'll wait for this to be merged before
I fix this up.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
