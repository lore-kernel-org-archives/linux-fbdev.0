From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [Linux-fbdev-users] PATCH: vga console tweak
Date: Fri, 13 May 2005 23:50:19 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0505132349250.14541@pentafluge.infradead.org>
References: <20050513214055.GA3107@cosmic.amd.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DWizO-0007GX-Vh
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 13 May 2005 15:50:38 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DWizN-0003Er-BG
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 13 May 2005 15:50:38 -0700
In-Reply-To: <20050513214055.GA3107@cosmic.amd.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>



On Fri, 13 May 2005, Jordan Crouse wrote:

> The attached patch puts a hard 32k ceiling on copies to and from
> the VGA VRAM space.
> 
> This bug was discovered with a 1920x1440 framebuffer console - before
> switching from VGA, the console is expanded to 240 cols x 90 rows, equaling
> a screenbuf_size of 43200 bytes.  Since the VGA VRAM space is only 32k bytes
> big, calling vgacon_save_screen during the console transfer copied in a good
> chunk of the video BIOS living at 0xc0000 too, resulting in some very purty
> colors and characters at the bottom of the new console.

Thanks for the patch. Will send it forward.



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
