From: James Simmons <jsimmons@infradead.org>
Subject: Re: 2.5.70 - Blank Screen with VESA VGA Framebuffer
Date: Thu, 12 Jun 2003 19:57:54 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306121956580.5915-100000@phoenix.infradead.org>
References: <0BCBFEACE44CF0469CF5EBF7F6B61253410228@chn-snr-msg.wipro.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19QXHI-00087h-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 12 Jun 2003 11:58:29 -0700
In-Reply-To: <0BCBFEACE44CF0469CF5EBF7F6B61253410228@chn-snr-msg.wipro.com>
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
To: Parag Warudkar <parag.warudkar@wipro.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


> I have a Sony VAIO laptop with ATI Mobility M1 AGP chip. I can use
> XFree86 on 2.4.x if I enable VESA VGA Frame buffer and enable vga=788 on
> kernel command line. With Kernel 2.5.70 after enabling VESA VGA
> Framebuffer console and specifying vga= commandline, I just get a blank
> screen just after the boot process starts and X doesn't work. (Garbled
> screen). Without the vga= commandline, I get normal boot screen but X
> needs the vga= option and doesn't work.
> 
> I have tried everything but to no avail. Does anyone know what do I need
> to do in order to get kernel 2.5.X working with Framebuffer console
> (VESA VGA or atyfb) and vga=788? I tried video=atyfb but that too
> doesn't work.. 

What does your config file look like. Did you enable both Framebuffer 
support and framebuffer console support? 



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
