From: James Simmons <jsimmons@infradead.org>
Subject: Re: Reading the EDID block for x86 machines
Date: Tue, 11 Mar 2003 15:49:24 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303111537420.23668-100000@phoenix.infradead.org>
References: <1047386934.1113.35.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18sm1R-0005g2-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 07:50:34 -0800
In-Reply-To: <1047386934.1113.35.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> I was wondering how to get the EDID block, and my first thought was to
> implement DDC.  But it is tricky to implement, so why not just get the
> EDID using an int 0x10 BIOS call?

DDC is tricky but the nice thing is it is very portable. We can do the 
BIOS call but that limits it support to intel family of processors.
I still like to do the BIOS call still because it allows us quick supprot 
of EDID on intel platforms. 

> The EDID block can be read before the kernel goes into protected mode
> (just a short assembly code in arch/i386/boot/video.S) and this can be
> saved later on as struct edid_info during the kernel's setup routine.  
> 
> One catch though is that that the "empty_zero_page" is becoming too
> tight, so it will just use the same offset used by the EDD (BIOS
> Enhanced Disk Drive).  So EDID reading will be disabled if EDD is
> enabled under the "Processor Type and Features"  option.

I believe it is possible to read the block after we are in protect mode.
Look at vesafb and also the aty128 driver allows you to probe the BIOS 
after we are in protect mode. I suggest we add a feild to struct 
screeninfo to store the address to the edid pointer. 
 
> One of the goals is to build a video data structure that also includes a
> database of video mode in fb_videomode format.  This can be dynamically
> created per device using the supported VESA modes, manufacturer's mode
> and detailed timings mode information in the EDID block. The EDID block
> also contain information on GTF capability.  With these types of
> displays, a video mode mode database may not be needed since all
> possible supported modelines can be calculated.
> 
> The advantage of the above is that the driver can switch to different
> modes without relying on user input (of course, user-entered modelines
> are still preferred).

Wow. I'm glad we both think alike. I was thinking the same thing except my 
hands are tied with working on the upper layer stuff. 

> Anyway, I need help in testing the code (especially the Detailed
> Information part).  Just apply the attached patch, disable Enhanced Disk
> Driver support (under Processor Type and Features), and enable EDID
> support (under Graphics option).  Finally, add the following line to the
> fbdev driver that you use (anywhere, but a good place is the init code):

Diable Enhanced Disk support :-( I have a few suggestions. One we add a 
pointer to struct screen_info that points to the edid information. We can 
use phys_to_virt to translate that address into virtual memory. I can 
create a patch today and store it in the BK tree. 



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
