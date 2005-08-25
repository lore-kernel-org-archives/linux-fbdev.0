From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: BUG: fb_imageblit called before fb_check_var and fb_set_par function
Date: Thu, 25 Aug 2005 14:26:14 +0200
Message-ID: <430DB8E6.8000204@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8H7k-00079s-S4
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Aug 2005 05:46:28 -0700
Received: from mailout02.sul.t-online.com ([194.25.134.17])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E8H7j-0004Jv-Mi
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Aug 2005 05:46:29 -0700
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hi everybody,

under certain circumstances the X trident driver does disable mmio
upon returning to a linux console. As mapped ioports are no longer
available, this is an immediate problem.

I never had expected that upon switching from X to a linux console
drawing functions like fb_imageblit would be called before the
fb_check_var and  fb_set_par functions have been called. But that=B4s
definitely the case.

Cyblafb now has a workaround for the problem, but I do believe that
this odd behaviour could also be the reason for failure or problems of
some other drivers  that do work fine as long as X is not involved,
but fail or show problems upon switching between the linux console
and X.

Please have a look at the code.

cu,
 Knut


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
