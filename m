From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Subject: video/tdfxfb.c warning fix.
Date: Tue, 27 Apr 2004 17:18:33 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040427171833.4af6c4cd.lcapitulino@prefeitura.sp.gov.br>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIZ1r-0002G2-9o
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 13:18:07 -0700
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIZ1q-0007mF-UD
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 13:18:07 -0700
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
To: jsimmons@infradead.org
Cc: linux-fbdev-devel@lists.sourceforge.net


 Hi,

drivers/video/tdfxfb.c:1005: warning: `tdfxfb_cursor' defined but not used

 seems to me that tdfxfb_cursor(), is the one of accelerate functions, which
is not well tested. I'm wrong ?

 If not, can I made it avaliable in Kconfig as I did before for the other
drivers ?

thanks,

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
