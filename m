From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 1/13] vt: printk: Fix framebuffer
 console triggering might_sleep assertion
Date: Wed, 02 Aug 2006 07:10:31 +0800
Message-ID: <44CFDF67.4030206@gmail.com>
References: <44CE9108.1030606@gmail.com>
	<20060731235100.9f792539.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G83Nm-0005Ae-Vd for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 Aug 2006 16:10:39 -0700
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G83Nl-0007jQ-B1
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 Aug 2006 16:10:38 -0700
Received: by py-out-1112.google.com with SMTP id d42so1295146pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 01 Aug 2006 16:10:36 -0700 (PDT)
In-Reply-To: <20060731235100.9f792539.akpm@osdl.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Rodolfo Giometti <giometti@linux.it>, linux-fbdev-devel@lists.sourceforge.net

Andrew Morton wrote:
> hm, which (if any) of these would be considered 2.6.18 material?
> 
> *vt-printk-fix-framebuffer-console-triggering-might_sleep.patch
> *au1100fb-info-varrotate-fix.patch
>  au1100fb-add-option-to-enable-disable-the-cursor.patch
> *au1100fb-fix-startup-sequence.patch
>  intelfb-documentation-update.patch
>  rivafb-use-constants-instead-of-magic-values.patch
>  vfb-document-option-to-enable-the-driver.patch
>  fbdev-add-generic-ddc-read-functionality.patch
>  nvidiafb-use-generic-ddc-reading.patch
>  rivafb-use-generic-ddc-reading.patch
>  i810fb-use-generic-ddc-reading.patch
>  savagefb-use-generic-ddc-reading.patch
>  radeonfb-use-generic-ddc-reading.patch
> 
> I've asterisked my guesses.
> 

The first and third guesses, I believe, are 2.6.18 material. Not sure on
the second...

Tony

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
