From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: New FBDev patch
Date: Sun, 11 Jan 2004 12:09:03 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040111120903.D1931@flint.arm.linux.org.uk>
References: <20040108232621.B25760@flint.arm.linux.org.uk> <Pine.LNX.4.44.0401090035270.17957-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AfeP4-0001AZ-K2
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 11 Jan 2004 04:09:14 -0800
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AfeP3-0005C1-T4
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 11 Jan 2004 04:09:14 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401090035270.17957-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Fri, Jan 09, 2004 at 07:54:50PM +0000
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

On Fri, Jan 09, 2004 at 07:54:50PM +0000, James Simmons wrote:
> > sizeof(u32) != 32.  Proper fix is to place the pseudopalette array
> > inside cfb_info, and dispense with this addition here.
> 
> You have to make sure the struct fb_info pseudopalette points to the data 
> in cfb_info. Actually only drivers should allocate the pseudopalette at 
> boot time if the hardware doesn't support mode change. In the other case 
> the pseudopalette should be allocated in set_par. 

I respectfully disagree.  It is not possible to error out of the set_par()
function - for instance, fb_set_var() contains this code:

                        if (info->fbops->fb_set_par)
                                info->fbops->fb_set_par(info);

There isn't any error return checking (so why does fb_set_par return an
int when it isn't used?  It's fairly misleading.)

This all means that if the allocation of the pseudo_palette in set_par
fails, there's no way to abort the mode change - you _will_ oops in the
other fbcon layers due to a NULL pseudo_palette pointer.

Plus, we're only talking about an array of 16 32-bit words or 64 bytes.
That's hardly worth the extra code complexity to separately dynamically
allocate.

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
