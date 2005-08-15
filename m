From: Daniel Drake <dsd@gentoo.org>
Subject: Re: Framebuffer display corruption on 2.6.12
Date: Mon, 15 Aug 2005 22:35:42 +0100
Message-ID: <43010AAE.9040607@gentoo.org>
References: <42FCD122.4070705@gentoo.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E4mb2-0006RW-Ct
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Aug 2005 14:34:16 -0700
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E4mb0-0004Wm-OC
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Aug 2005 14:34:16 -0700
Received: from aamta11-winn.ispmail.ntl.com ([81.103.221.35])
          by mta07-winn.ispmail.ntl.com with ESMTP
          id <20050815213407.BTVZ21883.mta07-winn.ispmail.ntl.com@aamta11-winn.ispmail.ntl.com>
          for <linux-fbdev-devel@lists.sourceforge.net>;
          Mon, 15 Aug 2005 22:34:07 +0100
Received: from zog.reactivated.net ([81.99.81.161])
          by aamta11-winn.ispmail.ntl.com with ESMTP
          id <20050815213407.SBDF820.aamta11-winn.ispmail.ntl.com@zog.reactivated.net>
          for <linux-fbdev-devel@lists.sourceforge.net>;
          Mon, 15 Aug 2005 22:34:07 +0100
Received: from [192.168.0.2] (dsd [192.168.0.2])
	by zog.reactivated.net (Postfix) with ESMTP id 0801D7C009A
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Aug 2005 23:03:53 +0100 (BST)
In-Reply-To: <42FCD122.4070705@gentoo.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Cc: linux-fbdev-devel@lists.sourceforge.net

Daniel Drake wrote:
> Some Gentoo users have reported display corruption when using the 
> framebuffer, easily visible in dialog-based applications. Sample 
> screenshot:
> 
> https://bugs.gentoo.org/attachment.cgi?id=63264

This appears to be a userspace issue after all, relating to unicode settings. 
Sorry for the noise.

Daniel


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
