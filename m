From: James Simmons <jsimmons@infradead.org>
Subject: Re: atyfb correction for 3D Rage Mobility L
Date: Wed, 21 Apr 2004 18:51:01 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404211849460.9207-100000@phoenix.infradead.org>
References: <408681FA.50607@free.fr>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGLsI-0008AA-U2
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 10:51:06 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BGLsI-0003Sn-Ko
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 10:51:06 -0700
In-Reply-To: <408681FA.50607@free.fr>
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
To: Arnaud FONTAINE <arnaud.fontaine@free.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net


Yes those are the correct values. They are in a newer ATI driver I have. I 
looked at the default 2.6.5 code and it looks correct. Are you sure you 
are not using a modified driver?


On Wed, 21 Apr 2004, Arnaud FONTAINE wrote:

> Hi,
> I'm running a Debian sarge on an iBook SE with a 2.6.5 kernel.
> My iBook contains a "3D Rage Mobility L" and I've had some troubles with
> the atyfb: my screen was turning blank.
> 
> I've modified the MCLCK and XCLCK of the "3D Rage Mobility L" in
> drivers/video/aty/atyfb_base.c :
> 
> # old version
> 	{ 0x4c4e, 0x4c4e, 0x00, 0x00, m64n_mob_a, 230, 83, 125, M64F_GT |
> M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS |
> M64F_MFB_FORCE_4 }
> 
> 
> # new version
> 	{ 0x4c4e, 0x4c4e, 0x00, 0x00, m64n_mob_a, 230, 50, 50, M64F_GT |
> M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS |
> M64F_MFB_FORCE_4 }
> 
> 
> I don't know if these settings are rights for every architectures, but
> for powerpc it is.
> 
> Thanks in advance
> 
> Arnaud FONTAINE
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
