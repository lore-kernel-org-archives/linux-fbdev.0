From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: rivafb / DDC/CI problem
Date: Wed, 15 Sep 2004 05:15:14 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409150515.15015.adaplas@hotpop.com>
References: <1095177461.7045.24.camel@tom>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C7Kdp-00021q-Rn
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Sep 2004 14:15:09 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C7Kdn-0008CZ-8m
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Sep 2004 14:15:09 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 8239783CF02
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Sep 2004 21:14:54 +0000 (UTC)
In-Reply-To: <1095177461.7045.24.camel@tom>
Content-Disposition: inline
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
To: Nicolas Boichat <nicolas@boichat.ch>, adaplas@pol.net
Cc: akpm@osdl.org, torvalds@osdl.org, linux-fbdev-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>

On Tuesday 14 September 2004 23:57, Nicolas Boichat wrote:
> Hello,
>
> I have a problem with this patch :
> rivafb-directcolor-mode-and-miscellaneous-fixes.patch
>
> It has been included in 2.6.8.1-mm1, and in 2.6.9-rc1.
>
> The following part of the patch breaks DDC/CI implementation (monitor
> control by software, see http://sourceforge.net/projects/ddccontrol/),
> as bits are sent too fast to the monitor on the I2C bus:
>

Ok, will reverse.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
