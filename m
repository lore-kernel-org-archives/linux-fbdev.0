From: "Buttchereit, Axel (XL)" <XL@XLsigned.net>
Subject: Re: [patch] intelfb: add (partial) support for
 915G
Date: Wed, 02 Feb 2005 17:40:15 +0100
Message-ID: <4201026F.1080309@XLsigned.net>
References: <41FB1AEB.4090206@XLsigned.net> <200502022019.21453.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CwNYF-00078b-FY
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Feb 2005 08:40:23 -0800
Received: from mail.goracer.de ([62.75.192.134])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CwNYE-00047X-PS
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Feb 2005 08:40:23 -0800
In-Reply-To: <200502022019.21453.adaplas@hotpop.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: sylvain.meyer@worldonline.fr, adaplas@pol.net

Antonino A. Daplas wrote:
> On Saturday 29 January 2005 13:11, Buttchereit, Axel (XL) wrote:
> 
>>Add (partial) support for 915G
>>  No HW cursor at the moment
>>  Screen is blanked but signal/sync is not switched off
>>Mostly derived from XFree86/Xorg driver
>>Pass "vesa_modes" and VESA_MODEDB_SIZE in call to "fb_find_mode()"
>>  to allow loading as module. Makes "vesa_modes" also the default
>>  "modedb" when linking statically into the kernel.
>>Change PREFERRED_MODE to more reasonable value "1024x768-32@70"
>>
> 
> 
> Can you resend?  Patch is malformed.
Sure!
But it would be much easier for me, if I know what's wrong with my patch.

I assume that the kernel source version I was using is wrong (outdated),
i. e. I have to make my patch base on (at least) version 2.6.11-rc2.

I would like to know, if the following statements are true:

@2.6.10 	=	kernel/v2.6/linux-2.6.10.tar.bz2
@2.6.11-rc1 	= 	@2.6.10 + kernel/v2.6/testing/patch-2.6.11-rc1.bz2
@2.6.11-rc2 	= 	@2.6.10 + kernel/v2.6/testing/patch-2.6.11-rc2.bz2
@2.6.11-rc2-bk1 =	@2.6.11-rc2 + kernel/v2.6/snapshots/patch-2.6.11-rc2-bk1.bz2
@2.6.11-rc2-bk2 =	@2.6.11-rc2 + kernel/v2.6/snapshots/patch-2.6.11-rc2-bk2.bz2
...
@2.6.11-rc1-mm1 =	@2.6.11-rc1 + kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm1/2.6.11-rc1-mm1.bz2
@2.6.11-rc1-mm2 =	@2.6.11-rc1 + kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm2/2.6.11-rc1-mm2.bz2
@2.6.11-rc2-mm1 =	@2.6.11-rc2 + kernel/people/akpm/patches/2.6/2.6.11-rc2/2.6.11-rc2-mm1/2.6.11-rc2-mm1.bz2
@2.6.11-rc2-mm2 =	@2.6.11-rc2 + kernel/people/akpm/patches/2.6/2.6.11-rc2/2.6.11-rc2-mm2/2.6.11-rc2-mm2.bz2

The "2.6.11-rc[V]-bk[W]" are maintained by Linus who integrates patches from Andrews's mm-tree,
i. e. "patch-2.6.11-rc[V]-bk[W]" is a subset (selected patches) from Andrew's current
"2.6.11-rc2-mm[I]" patchset.

Right?
(What about the "-ac" patches? Are they also running into "2.6.11-rc[V]-bk[W]")

Thanks for your patience
--Axel



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
