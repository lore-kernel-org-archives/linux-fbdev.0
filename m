From: <JosephChan@via.com.tw>
Subject: Re: [Question] sumbit VIAFB driver
Date: Tue, 6 May 2008 08:44:19 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F36485@exchtp03.taipei.via.com.tw>
References: <Pine.LNX.4.64.0805052035180.3160@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JtBIC-0003xW-JR for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 17:44:28 -0700
Received: from mailtp.via.com.tw ([61.66.243.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JtBIB-0000qk-5h
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 17:44:28 -0700
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0805052035180.3160@anakin>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: geert@linux-m68k.org, akpm@linux-foundation.org
Cc: linux-fbdev-devel@lists.sourceforge.net

 
Hi Geert,

Thanks for your help. I will spilt the patch after I do the final check.

BRs,
Joseph Chan 

-----Original Message-----
From: geert@linux-m68k.org [mailto:geert@linux-m68k.org] 
Sent: Tuesday, May 06, 2008 2:37 AM
To: Joseph Chan; Andrew Morton
Cc: Linux Frame Buffer Device Development
Subject: Re: [Linux-fbdev-devel] [Question] sumbit VIAFB driver


	Hi Joseph,

On Mon, 5 May 2008, JosephChan@via.com.tw wrote:
> We would like to sumbit VIA's framebuffer device driver into kernel 
> and I've done the patch file.
> But the patch seems too large to send (2 files exceed 2700 lines, 
> other
> 3 more files exceed 1000 lines), it's appreciated to guide me to 
> separate those signle file into multiple parts?

For review, you can split the patch in multiple parts (one for each big
change) and send them separately.

For submission (after integrating the review comments!), you can send it
as one big patch to Andrew Morton, I think. Andrew?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker.
But when I'm talking to journalists I just say "programmer" or something
like that.
							    -- Linus
Torvalds


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
