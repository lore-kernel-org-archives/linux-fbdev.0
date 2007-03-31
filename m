From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: nvidiafb, monitor A & B and CRTC 0 & 1
Date: Sat, 31 Mar 2007 19:51:33 +0800
Message-ID: <1175341893.4420.1.camel@daplas>
References: <460672C1.3080303@vc.cvut.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HXc7T-0004th-5a for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 31 Mar 2007 04:51:43 -0700
Received: from nz-out-0506.google.com ([64.233.162.236])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HXc7R-0000lP-CY
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 31 Mar 2007 04:51:43 -0700
Received: by nz-out-0506.google.com with SMTP id i11so1332812nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 31 Mar 2007 04:51:40 -0700 (PDT)
In-Reply-To: <460672C1.3080303@vc.cvut.cz>
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Sun, 2007-03-25 at 06:01 -0700, Petr Vandrovec wrote:
> Hello,
>    how much are you sure that monitor A i2c should use ddc_base 0x3E, 
> and monitor B base 0x36 ?

This was chosen arbitrarily, hoping that the code will sort out which is
which.  If reversing the ports worked for you, I will not disagree with
the patch.

Thanks.

Tony



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
